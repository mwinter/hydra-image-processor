#pragma once

#define DEVICE_VEC
#include "Vec.h"
#undef DEVICE_VEC

#include "CudaImageContainer.cuh"
#include "Vec.h"
#include <vector>
#include "CHelpers.h"
#include "ImageChunk.cuh"
#include "CudaDeviceImages.cuh"

template <class PixelType>
__device__ PixelType* SubDivide(PixelType* pB, PixelType* pE)
{
	PixelType* pPivot = --pE;
	const PixelType pivot = *pPivot;

	while (pB < pE)
	{
		if (*pB > pivot)
		{
			--pE;
			PixelType temp = *pB;
			*pB = *pE;
			*pE = temp;
		} else
			++pB;
	}

	PixelType temp = *pPivot;
	*pPivot = *pE;
	*pE = temp;

	return pE;
}

template <class PixelType>
__device__ void SelectElement(PixelType* pB, PixelType* pE, size_t k)
{
	while (true)
	{
		PixelType* pPivot = SubDivide(pB, pE);
		size_t n = pPivot - pB;

		if (n == k)
			break;

		if (n > k)
			pE = pPivot;
		else
		{
			pB = pPivot + 1;
			k -= (n + 1);
		}
	}
}

template <class PixelType>
__device__ PixelType cudaFindMedian(PixelType* vals, int numVals)
{
	SelectElement(vals,vals+numVals, numVals/2);
	return vals[numVals/2];
}

template <class PixelType>
__global__ void cudaMedianFilter( CudaImageContainer<PixelType> imageIn, CudaImageContainer<PixelType> imageOut,
								 Vec<size_t> hostKernelDims )
{
	extern __shared__ unsigned char valsShared[];
	PixelType* vals = (PixelType*)valsShared;

	DeviceVec<size_t> coordinate;
	coordinate.x = threadIdx.x + blockIdx.x * blockDim.x;
	coordinate.y = threadIdx.y + blockIdx.y * blockDim.y;
	coordinate.z = threadIdx.z + blockIdx.z * blockDim.z;

	if (coordinate<imageIn.getDeviceDims())
	{
		DeviceVec<size_t> blockDimVec(blockDim.x,blockDim.y,blockDim.z);
		DeviceVec<size_t> kernelDims = hostKernelDims;
		size_t linearThreadIdx = blockDimVec.linearAddressAt(DeviceVec<size_t>(threadIdx.x,threadIdx.y,threadIdx.z));
		int sharedMemOffset = linearThreadIdx*kernelDims.product();
		int kernelVolume = 0;

		DeviceVec<int> startLimit = DeviceVec<int>(coordinate) - DeviceVec<int>((kernelDims)/2);
		DeviceVec<size_t> endLimit = coordinate + (kernelDims+1)/2;
		DeviceVec<size_t> kernelStart(DeviceVec<int>::max(-startLimit,DeviceVec<int>(0,0,0)));

		startLimit = DeviceVec<int>::max(startLimit,DeviceVec<int>(0,0,0));
		endLimit = DeviceVec<size_t>::min(DeviceVec<size_t>(endLimit),imageIn.getDeviceDims());

		DeviceVec<size_t> imageStart(coordinate-(kernelDims/2)+kernelStart);
		DeviceVec<size_t> iterationEnd(endLimit-DeviceVec<size_t>(startLimit));

		DeviceVec<size_t> i(0,0,0);
  		for (i.z=0; i.z<iterationEnd.z; ++i.z)
  		{
  			for (i.y=0; i.y<iterationEnd.y; ++i.y)
  			{
  				for (i.x=0; i.x<iterationEnd.x; ++i.x)
  				{
 					vals[kernelVolume+sharedMemOffset] = (double)imageIn[imageStart+i];
 					++kernelVolume;
  				}
  			}
  		}

		imageOut[coordinate] = (PixelType)cudaFindMedian(vals+sharedMemOffset,kernelVolume);
	}
	__syncthreads();
}

template <class PixelType>
PixelType* cMedianFilter(const PixelType* imageIn, Vec<size_t> dims, Vec<size_t> neighborhood, PixelType** imageOut=NULL, int device=0)
{
	PixelType* imOut = setUpOutIm(dims, imageOut);

	neighborhood = neighborhood.clamp(Vec<size_t>(1,1,1),dims);

	cudaDeviceProp props;
	cudaGetDeviceProperties(&props,device);

	size_t memAvail, total;
	cudaMemGetInfo(&memAvail,&total);

	size_t sizeOfsharedMem = neighborhood.product()*sizeof(PixelType);
	int numThreads = (int)floor((double)props.sharedMemPerBlock/(double)sizeOfsharedMem);
	if (numThreads<1)
		throw std::runtime_error("Median neighborhood is too large to fit in shared memory on the GPU!");

	std::vector<ImageChunk> chunks = calculateBuffers<PixelType>(dims,2,(size_t)(memAvail*MAX_MEM_AVAIL),props,neighborhood,numThreads);

	Vec<size_t> maxDeviceDims;
	setMaxDeviceDims(chunks, maxDeviceDims);

	CudaDeviceImages<PixelType> deviceImages(2,maxDeviceDims,device);

	for (std::vector<ImageChunk>::iterator curChunk=chunks.begin(); curChunk!=chunks.end(); ++curChunk)
	{
		curChunk->sendROI(imageIn,dims,deviceImages.getCurBuffer());
		deviceImages.setNextDims(curChunk->getFullChunkSize());

		size_t sharedMemorysize = neighborhood.product()*sizeof(PixelType) * curChunk->threads.x * curChunk->threads.y * curChunk->threads.z;

		cudaMedianFilter<<<curChunk->blocks,curChunk->threads,sharedMemorysize>>>
			(*(deviceImages.getCurBuffer()),*(deviceImages.getNextBuffer()),neighborhood);

		DEBUG_KERNEL_CHECK();
		deviceImages.incrementBuffer();

		curChunk->retriveROI(imOut,dims,deviceImages.getCurBuffer());
	}

	return imOut;
}