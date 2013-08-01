#ifndef CUDA_KERNALS_H
#define CUDA_KERNALS_H

#include "Vec.h"

template<typename ImagePixelType>
__global__ void meanFilter(ImagePixelType* imageIn, ImagePixelType* imageOut, Vec<int> imageDims, int kernalDiameter)
{
	int x = threadIdx.x + blockIdx.x * blockDim.x;
	int y = threadIdx.y + blockIdx.y * blockDim.y;
	int z = threadIdx.z + blockIdx.z * blockDim.z;

	if (x<imageDims.x && y<imageDims.y && z<imageDims.z)
	{
		int kernalRadius = kernalDiameter/2;
		double val = 0;
		int xMin = max(0,x-kernalRadius);
		int xMax = min(imageDims.x,x+kernalRadius);
		int yMin = max(0,y-kernalRadius);
		int yMax = min(imageDims.y,y+kernalRadius);
		int zMin = max(0,z-kernalRadius);
		int zMax = min(imageDims.z,z+kernalRadius);

		for (int i=xMin; i<xMax; ++i)
		{
			for (int j=yMin; j<yMax; ++j)
			{
				for (int k=zMin; k<zMax; ++k)
					val += imageIn[i+j*imageDims.x+k*imageDims.y*imageDims.x];
			}
		}

		imageOut[x+y*imageDims.x+z*imageDims.y*imageDims.x] = min(val/((xMax-xMin)*(yMax-yMin)*(zMax-zMin)),255.0f);
	}
}

template<typename ImagePixelType1, typename ImagePixelType2, typename FactorType>
__global__ void multiplyImage(ImagePixelType1* imageIn, ImagePixelType2* imageOut, Vec<int> imageDims, FactorType factor)
{
	int x = threadIdx.x + blockIdx.x * blockDim.x;
	int y = threadIdx.y + blockIdx.y * blockDim.y;
	int z = threadIdx.z + blockIdx.z * blockDim.z;

	if (x<imageDims.x && y<imageDims.y && z<imageDims.z)
	{
		imageOut[x+y*imageDims.x+z*imageDims.y*imageDims.x] = factor * imageIn[x+y*imageDims.x+z*imageDims.y*imageDims.x];
	}
}

template<typename ImagePixelType1, typename ImagePixelType2, typename FactorType>
__global__ void normalizeImage(ImagePixelType1* imageIn, ImagePixelType2* imageOut, Vec<int> imageDims, FactorType factor)
{
	int x = threadIdx.x + blockIdx.x * blockDim.x;
	int y = threadIdx.y + blockIdx.y * blockDim.y;
	int z = threadIdx.z + blockIdx.z * blockDim.z;

	if (x<imageDims.x && y<imageDims.y && z<imageDims.z)
	{
		imageOut[x+y*imageDims.x+z*imageDims.y*imageDims.x] = max((FactorType)0,factor * imageIn[x+y*imageDims.x+z*imageDims.y*imageDims.x]);
	}
}

template<typename ImagePixelType1, typename ImagePixelType2, typename ImagePixelType3, typename FactorType>
__global__ void addTwoImagesWithFactor(ImagePixelType1* imageIn1, ImagePixelType2* imageIn2, ImagePixelType3* imageOut,
	Vec<int> imageDims, FactorType factor)
{
	int x = threadIdx.x + blockIdx.x * blockDim.x;
	int y = threadIdx.y + blockIdx.y * blockDim.y;
	int z = threadIdx.z + blockIdx.z * blockDim.z;

	if (x<imageDims.x && y<imageDims.y && z<imageDims.z)
	{
		imageOut[x+y*imageDims.x+z*imageDims.y*imageDims.x] = 
			imageIn1[x+y*imageDims.x+z*imageDims.y*imageDims.x] - factor*imageIn2[x+y*imageDims.x+z*imageDims.y*imageDims.x];
	}
}

template<typename ImagePixelType>
__device__ ImagePixelType findMedian(ImagePixelType* vals, int numVals)
{
	//TODO this algo could use some improvement
	int minIndex;
	ImagePixelType minValue;
	ImagePixelType tempValue;
	for (int i=0; i<=numVals/2; ++i)
	{
		minIndex = i;
		minValue = vals[i];
		for (int j=i+1; j<numVals; ++j)
		{
			if (vals[j]<minValue)
			{
				minIndex = j;
				minValue = vals[j];
			}
			tempValue = vals[i];
			vals[i] = vals[minIndex];
			vals[minIndex] = tempValue;
		}
	}
	//return vals[numVals/2];
	return vals[0];
}

template<typename ImagePixelType>
__global__ void medianFilter(ImagePixelType* imageIn, ImagePixelType* imageOut, Vec<int> imageDims, Vec<int> kernalDims)
{
	int x = threadIdx.x + blockIdx.x * blockDim.x;
	int y = threadIdx.y + blockIdx.y * blockDim.y;
	int z = threadIdx.z + blockIdx.z * blockDim.z;

	if (x<imageDims.x && y<imageDims.y && z<imageDims.z)
	{
		ImagePixelType* vals = new ImagePixelType[kernalDims.x*kernalDims.y*kernalDims.z];
		int halfKwidth = kernalDims.x/2;
		int halfKheight = kernalDims.y/2;
		int halfKdepth = kernalDims.z/2;
		int iIm=-halfKwidth, iKer=0;
		for (; iIm<halfKwidth; ++iIm, ++iKer)
		{
			int imXcoor = min(max(x+iIm,0),imageDims.x-1);
			int jIm=-halfKheight, jKer=0;
			for (; jIm<halfKheight; ++jIm, ++jKer)
			{
				int imYcoor = min(max(y+jIm,0),imageDims.y-1);
				int kIm=-halfKdepth, kKer=0;
				for (; kIm<halfKdepth; ++kIm, ++kKer)
				{
					int imZcoor = min(max(z+kIm,0),imageDims.z-1);
					vals[iKer+jKer*kernalDims.y+kKer*kernalDims.y*kernalDims.x] = 
						imageIn[imXcoor + imYcoor*imageDims.x + imZcoor*imageDims.y*imageDims.x];
				}
			}
		}

		imageOut[x+y*imageDims.x+z*imageDims.y*imageDims.x] = findMedian(vals,kernalDims.x*kernalDims.y*kernalDims.z);
		delete vals;
	}
}

template<typename ImagePixelType1, typename ImagePixelType2, typename KernalType>
__global__ void multAddFilter(ImagePixelType1* imageIn, ImagePixelType2* imageOut, Vec<int> imageDims, KernalType* kernal,
	Vec<int> kernalDims)
{
	extern __shared__ KernalType ker[];
	for (int i=0; i<kernalDims.x*kernalDims.y*kernalDims.z; ++i)
		ker[i] = kernal[i];

	int x = threadIdx.x + blockIdx.x * blockDim.x;
	int y = threadIdx.y + blockIdx.y * blockDim.y;
	int z = threadIdx.z + blockIdx.z * blockDim.z;

	if (x<imageDims.x && y<imageDims.y && z<imageDims.z)
	{
		KernalType val = 0;
		int halfKwidth = kernalDims.x/2;
		int halfKheight = kernalDims.y/2;
		int halfKdepth = kernalDims.z/2;
		int iIm=-halfKwidth, iKer=0;
		KernalType kernFactor = 0;
		for (; iIm<halfKwidth; ++iIm, ++iKer)
		{
			int imXcoor = min(max(x+iIm,0),imageDims.x-1);
			int jIm=-halfKheight, jKer=0;
			for (; jIm<halfKheight; ++jIm, ++jKer)
			{
				int imYcoor = min(max(y+jIm,0),imageDims.y-1);
				int kIm=-halfKdepth, kKer=0;
				for (; kIm<halfKdepth; ++kIm, ++kKer)
				{
					int imZcoor = min(max(z+kIm,0),imageDims.z-1);
					kernFactor += kernal[iKer+jKer*kernalDims.x+kKer*kernalDims.y*kernalDims.x];
					val += imageIn[imXcoor + imYcoor*imageDims.x + imZcoor*imageDims.y*imageDims.x] * 
						kernal[iKer+jKer*kernalDims.x+kKer*kernalDims.y*kernalDims.x];
				}
			}
		}

		imageOut[x+y*imageDims.x+z*imageDims.y*imageDims.x] = val/kernFactor;
	}
}

template<typename ImagePixelType, typename KernalType>
__global__ void minFilter(ImagePixelType* imageIn, ImagePixelType* imageOut, Vec<int> imageDims, KernalType* kernal,
	Vec<int> kernalDims)
{
	int x = threadIdx.x + blockIdx.x * blockDim.x;
	int y = threadIdx.y + blockIdx.y * blockDim.y;
	int z = threadIdx.z + blockIdx.z * blockDim.z;

	if (x<imageDims.x && y<imageDims.y && z<imageDims.z)
	{
		ImagePixelType minVal = imageOut[x+y*imageDims.x+z*imageDims.y*imageDims.z];
		int halfKwidth = kernalDims.x/2;
		int halfKheight = kernalDims.y/2;
		int halfKdepth = kernalDims.z/2;
		int iIm=-halfKwidth, iKer=0;
		for (; iIm<halfKwidth; ++iIm, ++iKer)
		{
			int imXcoor = min(max(x+iIm,0),imageDims.x-1);
			int jIm=-halfKheight, jKer=0;
			for (; jIm<halfKheight; ++jIm, ++jKer)
			{
				int imYcoor = min(max(y+jIm,0),imageDims.y-1);
				int kIm=-halfKdepth, kKer=0;
				for (; kIm<halfKdepth; ++kIm, ++kKer)
				{
					int imZcoor = min(max(z+kIm,0),imageDims.z-1);
					if(kernal[iKer+jKer*kernalDims.x+kKer*kernalDims.y*kernalDims.x]>0)
					{
						minVal = min((float)minVal, imageIn[imXcoor + imYcoor*imageDims.x + imZcoor*imageDims.y*imageDims.x]*
							kernal[iKer+jKer*kernalDims.x+kKer*kernalDims.y*kernalDims.x]);
					}
				}
			}
		}

		imageOut[x+y*imageDims.x+z*imageDims.y*imageDims.x] = minVal;
	}
}

template<typename ImagePixelType, typename KernalType>
__global__ void maxFilter(ImagePixelType* imageIn, ImagePixelType* imageOut, Vec<int> imageDims, KernalType* kernal,
	Vec<int> kernalDims)
{
	int x = threadIdx.x + blockIdx.x * blockDim.x;
	int y = threadIdx.y + blockIdx.y * blockDim.y;
	int z = threadIdx.z + blockIdx.z * blockDim.z;

	if (x<imageDims.x && y<imageDims.y && z<imageDims.z)
	{
		ImagePixelType maxVal = imageOut[x+y*imageDims.x+z*imageDims.y*imageDims.x];
		int halfKwidth = kernalDims.x/2;
		int halfKheight = kernalDims.y/2;
		int halfKdepth = kernalDims.z/2;
		int iIm=-halfKwidth, iKer=0;
		for (; iIm<halfKwidth; ++iIm, ++iKer)
		{
			int imXcoor = min(max(x+iIm,0),imageDims.x-1);
			int jIm=-halfKheight, jKer=0;
			for (; jIm<halfKheight; ++jIm, ++jKer)
			{
				int imYcoor = min(max(y+jIm,0),imageDims.y-1);
				int kIm=-halfKdepth, kKer=0;
				for (; kIm<halfKdepth; ++kIm, ++kKer)
				{
					int imZcoor = min(max(z+kIm,0),imageDims.z-1);
					if(kernal[iKer+jKer*kernalDims.x+kKer*kernalDims.y*kernalDims.x]>0)
					{
						maxVal = max((float)maxVal, imageIn[imXcoor + imYcoor*imageDims.x + imZcoor*imageDims.y*imageDims.x]*
							kernal[iKer+jKer*kernalDims.x+kKer*kernalDims.y*kernalDims.x]);
					}
				}
			}
		}

		imageOut[x+y*imageDims.x+z*imageDims.y*imageDims.x] = maxVal;
	}
}

template<typename ImagePixelType>
__global__ void histogramCreate(ImagePixelType* imageIn, unsigned int* histogram, Vec<int> imageDims)
{
	//This code is modified from that of Sanders - Cuda by Example
	__shared__ unsigned int tempHisto[NUM_BINS];
	tempHisto[threadIdx.x] = 0;
	__syncthreads();

	int i = threadIdx.x + blockIdx.x * blockDim.x;
	int stride = blockDim.x * gridDim.x;

	while (i < imageDims.x*imageDims.y*imageDims.z)
	{
		atomicAdd(&(tempHisto[imageIn[i]]), 1);
		i += stride;
	}

	__syncthreads();
	atomicAdd(&(histogram[threadIdx.x]), tempHisto[threadIdx.x]);
}

__global__ void normalizeHistogram(unsigned int* histogram, double* normHistogram, Vec<int> imageDims)
{
	normHistogram[blockIdx.x] = (double)(histogram[blockIdx.x]) / (imageDims.x*imageDims.y*imageDims.z);
}

template<typename ImagePixelType, typename ThresholdType>
__global__ void thresholdImage(ImagePixelType* imageIn, ImagePixelType* imageOut, Vec<int> imageDims, ThresholdType threshold)
{
	int x = threadIdx.x + blockIdx.x * blockDim.x;
	int y = threadIdx.y + blockIdx.y * blockDim.y;
	int z = threadIdx.z + blockIdx.z * blockDim.z;

	if (x<imageDims.x && y<imageDims.y && z<imageDims.z)
	{
		if (imageIn[x+y*imageDims.x+z*imageDims.y*imageDims.x]>=threshold)
			imageOut[x+y*imageDims.x+z*imageDims.y*imageDims.x] = 1;
		else
			imageOut[x+y*imageDims.x+z*imageDims.y*imageDims.x] = 0;
	}
}

template<typename ImagePixelType>
__global__ void findMinMax(ImagePixelType* arrayIn, ImagePixelType* minArrayOut, ImagePixelType* maxArrayOut, unsigned int n)

{
	extern __shared__ float maxData[];
	extern __shared__ float minData[];

	unsigned int tid = threadIdx.x;
	unsigned int i = blockIdx.x*blockDim.x*2 + tid;
	unsigned int gridSize = blockDim.x*2*gridDim.x;

	while (i<n)
	{
		maxData[tid] = arrayIn[i];
		minData[tid] = arrayIn[i];

		if (i+blockDim.x<n)
		{
			if(maxData[tid]<arrayIn[i+blockDim.x])
				maxData[tid] = arrayIn[i+blockDim.x];

			if(minData[tid]>arrayIn[i+blockDim.x])
				minData[tid] = arrayIn[i+blockDim.x];
		}

		i += gridSize;
	}
	__syncthreads();


	if (blockDim.x >= 2048)
	{
		if (tid < 1024) 
		{
			if(maxData[tid]<maxData[tid + 1024])
				maxData[tid] = maxData[tid + 1024];

			if(minData[tid]>minData[tid + 1024])
				minData[tid] = minData[tid + 1024];
		}
		__syncthreads();
	}
	if (blockDim.x >= 1024)
	{
		if (tid < 512) 
		{
			if(maxData[tid]<maxData[tid + 512])
				maxData[tid] = maxData[tid + 512];

			if(minData[tid]>minData[tid + 512])
				minData[tid] = minData[tid + 512];
		}
		__syncthreads();
	}
	if (blockDim.x >= 512)
	{
		if (tid < 256) 
		{
			if(maxData[tid]<maxData[tid + 256])
				maxData[tid] = maxData[tid + 256];

			if(minData[tid]>minData[tid + 256])
				minData[tid] = minData[tid + 256];
		}
		__syncthreads();
	}
	if (blockDim.x >= 256) {
		if (tid < 128)
		{
			if(maxData[tid]<maxData[tid + 128])
				maxData[tid] = maxData[tid + 128];

			if(minData[tid]>minData[tid + 128])
				minData[tid] = minData[tid + 128];
		}
		__syncthreads(); 
	}
	if (blockDim.x >= 128) 
	{
		if (tid < 64)
		{
			if(maxData[tid]<maxData[tid + 64])
				maxData[tid] = maxData[tid + 64];

			if(minData[tid]>minData[tid + 64])
				minData[tid] = minData[tid + 64];
		}
		__syncthreads(); 
	}

	if (tid < 32) {
		if (blockDim.x >= 64) 
		{
			{
				if(maxData[tid]<maxData[tid + 64])
					maxData[tid] = maxData[tid + 64];

				if(minData[tid]>minData[tid + 64])
					minData[tid] = minData[tid + 64];
			}
			__syncthreads(); 
		}
		if (blockDim.x >= 32)
		{
			if(maxData[tid]<maxData[tid + 16])
				maxData[tid] = maxData[tid + 16];

			if(minData[tid]>minData[tid + 16])
				minData[tid] = minData[tid + 16];
			__syncthreads(); 
		}
		if (blockDim.x >= 16)
		{
			if(maxData[tid]<maxData[tid + 8])
				maxData[tid] = maxData[tid + 8];

			if(minData[tid]>minData[tid + 8])
				minData[tid] = minData[tid + 8];
			__syncthreads(); 
		}
		if (blockDim.x >= 8)
		{
			if(maxData[tid]<maxData[tid + 4])
				maxData[tid] = maxData[tid + 4];

			if(minData[tid]>minData[tid + 4])
				minData[tid] = minData[tid + 4];
			__syncthreads(); 
		}
		if (blockDim.x >= 4)
		{
			if(maxData[tid]<maxData[tid + 2])
				maxData[tid] = maxData[tid + 2];

			if(minData[tid]>minData[tid + 2])
				minData[tid] = minData[tid + 2];
			__syncthreads(); 
		}
		if (blockDim.x >= 2)
		{
			if(maxData[tid]<maxData[tid + 1])
				maxData[tid] = maxData[tid + 1];

			if(minData[tid]>minData[tid + 1])
				minData[tid] = minData[tid + 1];
			__syncthreads(); 
		}
	}

	if (tid==0)
	{
		minArrayOut[blockIdx.x] = minData[0];
		maxArrayOut[blockIdx.x] = maxData[0];
	}
}

template<typename ImagePixelType, typename ThresholdType>
__global__ void polyTransferFuncImage(ImagePixelType* imageIn, ImagePixelType* imageOut, Vec<int> imageDims, ThresholdType a,
	ThresholdType b, ThresholdType c, ThresholdType maxPixelValue)
{
	int x = threadIdx.x + blockIdx.x * blockDim.x;
	int y = threadIdx.y + blockIdx.y * blockDim.y;
	int z = threadIdx.z + blockIdx.z * blockDim.z;

	if (x<imageDims.x && y<imageDims.y && z<imageDims.z)
	{
		ThresholdType pixVal = imageIn[x+y*imageDims.x+z*imageDims.y*imageDims.x] / maxPixelValue;
		ThresholdType multiplier = a*pixVal*pixVal + b*pixVal + c;
		if (multiplier<0)
			multiplier = 0;
		if (multiplier>1)
			multiplier = 1;

		ImagePixelType newPixelVal = multiplier * maxPixelValue;

		imageOut[x+y*imageDims.x+z*imageDims.y*imageDims.x] = newPixelVal;
	}
}

template<typename ImagePixelType, typename ThresholdType>
__global__ void getCoordinates(ImagePixelType* imageIn, Vec<int>* coordinatesOut, Vec<int> imageDims, ThresholdType threshold)
{
	int x = threadIdx.x + blockIdx.x * blockDim.x;
	int y = threadIdx.y + blockIdx.y * blockDim.y;
	int z = threadIdx.z + blockIdx.z * blockDim.z;

	if (x<imageDims.x && y<imageDims.y && z<imageDims.z)
	{
		Vec<int> coord;
		if (imageIn[x+y*imageDims.x+z*imageDims.y*imageDims.x]>threshold)
		{
			coord = Vec<int>(x,y,z);
		}
		else
		{
			coord = Vec<int>(-1,-1,-1);
		}

		coordinatesOut[x+y*imageDims.x+z*imageDims.y*imageDims.x] = coord;
	}
}

__global__ void fillCoordinates(Vec<int>* coordinatesIn, Vec<int>* coordinatesOut, Vec<int> imageDims, int overDimension);

template<typename T>
__global__ void reduceArray(T* arrayIn, T* arrayOut, unsigned int n)

{
	//This algorithm was used from a this website:
	// http://developer.download.nvidia.com/compute/cuda/1.1-Beta/x86_website/projects/reduction/doc/reduction.pdf
	// accessed 4/28/2013

	extern __shared__ T sdata[];

	unsigned int tid = threadIdx.x;
	unsigned int i = blockIdx.x*blockDim.x*2 + tid;
	unsigned int gridSize = blockDim.x*2*gridDim.x;
	sdata[tid] = 0;

	while (i<n)
	{
		sdata[tid] = arrayIn[i];

		if (i+blockDim.x<n)
			sdata[tid] += arrayIn[i+blockDim.x];

		i += gridSize;
	}
	__syncthreads();


	if (blockDim.x >= 2048)
	{
		if (tid < 1024) 
			sdata[tid] += sdata[tid + 1024];
		__syncthreads();
	}
	if (blockDim.x >= 1024)
	{
		if (tid < 512) 
			sdata[tid] += sdata[tid + 512];
		__syncthreads();
	}
	if (blockDim.x >= 512)
	{
		if (tid < 256) 
			sdata[tid] += sdata[tid + 256];
		__syncthreads();
	}
	if (blockDim.x >= 256) {
		if (tid < 128)
			sdata[tid] += sdata[tid + 128];
		__syncthreads(); 
	}
	if (blockDim.x >= 128) 
	{
		if (tid < 64)
			sdata[tid] += sdata[tid + 64];
		__syncthreads(); 
	}

	if (tid < 32) {
		if (blockDim.x >= 64) 
		{
			sdata[tid] += sdata[tid + 32];
			__syncthreads(); 
		}
		if (blockDim.x >= 32)
		{
			sdata[tid] += sdata[tid + 16];
			__syncthreads(); 
		}
		if (blockDim.x >= 16)
		{
			sdata[tid] += sdata[tid + 8];
			__syncthreads(); 
		}
		if (blockDim.x >= 8)
		{
			sdata[tid] += sdata[tid + 4];
			__syncthreads(); 
		}
		if (blockDim.x >= 4)
		{
			sdata[tid] += sdata[tid + 2];
			__syncthreads(); 
		}
		if (blockDim.x >= 2)
		{
			sdata[tid] += sdata[tid + 1];
			__syncthreads(); 
		}
	}

	if (tid==0)
		arrayOut[blockIdx.x] = sdata[0];
}

template<typename ImagePixelType>
__global__ void ruduceImage(ImagePixelType* imageIn, ImagePixelType* imageOut, Vec<int> imageInDims, unsigned int reductionAmount)
{
	unsigned int x = threadIdx.x + blockIdx.x * blockDim.x;
	unsigned int y = threadIdx.y + blockIdx.y * blockDim.y;
	unsigned int z = threadIdx.z + blockIdx.z * blockDim.z;
	Vec<int> imageOutDims = imageInDims/reductionAmount;

	if (x<imageOutDims.x && y<imageOutDims.y && z<imageOutDims.z)
	{
		ImagePixelType val = 0;
		unsigned int xMin = x*reduction;
		unsigned int xMax = min(x*reduction+reduction,imageInDims.x);
		unsigned int yMin = y*reduction;
		unsigned int yMax = min(y*reduction+reduction,imageInDims.y);
		unsigned int zMin = z*(reduction/2);
		unsigned int zMax = min(z*(reduction/2)+(reduction/2),imageInDims.z);

		for (unsigned int i=xMin; i<xMax; ++i)
		{
			for (unsigned int j=yMin; j<yMax; ++j)
			{
				for (unsigned int k=zMin; k<zMax; ++k)
					//center imageIn[x+y*imageWidth]
					val += (float)imageIn[i+j*imageInDims.x+k*imageInDims.y*imageInDims.x];
			}
		}

		imageOut[x+y*imageOutDims.x+z*imageOutDims.y*imageOutDims.x] = 
			(double)val/((xMax-xMin)*(yMax-yMin)*(zMax-zMin));
	}
}

template<typename ImagePixelType>
__global__ void maximumIntensityProjection(ImagePixelType* imageIn, ImagePixelType* imageOut, Vec<int> imageInDims)
{
	int x = threadIdx.x + blockIdx.x * blockDim.x;
	int y = threadIdx.y + blockIdx.y * blockDim.y;
	int z = threadIdx.z + blockIdx.z * blockDim.z;

	if (x<imageDims.x && y<imageDims.y && z==0)
	{
		ImagePixelType maxVal = 0;
		for (int depth=0; depth<imageDims.z; ++depth)
		{
			if (maxVal<imageIn[x+y*imageDims.x+depth*imageDims.y*imageDims.x])
			{
				maxVal = imageIn[x+y*imageDims.x+depth*imageDims.y*imageDims.x];
			}
		}

		imageOut[x+y*imageDims.x] = maxVal;
	}
}
#endif