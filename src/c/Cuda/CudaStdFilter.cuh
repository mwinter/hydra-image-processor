#pragma once

#include "CudaImageContainer.cuh"
#include "KernelIterator.cuh"
#include "Vec.h"
#include <vector>
#include "CHelpers.h"
#include "ImageChunk.h"
#include "CudaDeviceImages.cuh"

template <class PixelType>
__global__ void cudaStdFilter(CudaImageContainer<PixelType> imageIn,CudaImageContainer<PixelType> imageOut,Vec<size_t> hostKernelDims)
{
	Vec<size_t> coordinate;
	coordinate.x = threadIdx.x + blockIdx.x * blockDim.x;
	coordinate.y = threadIdx.y + blockIdx.y * blockDim.y;
	coordinate.z = threadIdx.z + blockIdx.z * blockDim.z;

	if(coordinate<imageIn.getDims())
	{
		double val = 0;
		double kernelVolume = 0;
		Vec<size_t> kernelDims = hostKernelDims;
		KernelIterator kIt(coordinate, imageIn.getDims(), kernelDims);

		for(; !kIt.end(); ++kIt)
		{
			val += imageIn(kIt.getImageCoordinate());
			++kernelVolume;
		}

		double mu = val/kernelVolume;

		kIt.reset();

		for(; !kIt.end(); ++kIt)
		{
			val += SQR(imageIn(kIt.getImageCoordinate())-mu);
		}

		imageOut(coordinate) = sqrt(val/(kernelVolume-1));
	}
}

template <class PixelType>
PixelType* cStdFilter(const PixelType* imageIn,Vec<size_t> dims,Vec<size_t> neighborhood,PixelType** imageOut=NULL,int device=0)
{
    cudaSetDevice(device);
	PixelType* imOut = setUpOutIm(dims,imageOut);

	neighborhood = neighborhood.clamp(Vec<size_t>(1,1,1),dims);

	cudaDeviceProp props;
	cudaGetDeviceProperties(&props,device);

	size_t memAvail,total;
	cudaMemGetInfo(&memAvail,&total);

    int blockSize = getKernelMaxThreads(cudaStdFilter<PixelType>);

	std::vector<ImageChunk> chunks = calculateBuffers<PixelType>(dims,2,(size_t)(memAvail*MAX_MEM_AVAIL),props,neighborhood,blockSize);

	Vec<size_t> maxDeviceDims;
	setMaxDeviceDims(chunks,maxDeviceDims);

	CudaDeviceImages<PixelType> deviceImages(2,maxDeviceDims,device);

	for(std::vector<ImageChunk>::iterator curChunk=chunks.begin(); curChunk!=chunks.end(); ++curChunk)
	{
		curChunk->sendROI(imageIn,dims,deviceImages.getCurBuffer());
		deviceImages.setNextDims(curChunk->getFullChunkSize());

		cudaStdFilter<<<curChunk->blocks,curChunk->threads>>>(*(deviceImages.getCurBuffer()),*(deviceImages.getNextBuffer()),neighborhood);
		DEBUG_KERNEL_CHECK();

		deviceImages.incrementBuffer();

		curChunk->retriveROI(imOut,dims,deviceImages.getCurBuffer());
	}

	return imOut;
}
