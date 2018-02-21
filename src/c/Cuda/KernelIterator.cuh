#pragma once

#include "Vec.h"

class KernelIterator
{
public:
	__device__ KernelIterator(Vec<size_t> inputPos, Vec<size_t> inputSize, Vec<size_t> kernelSize);
	__device__ __host__ ~KernelIterator();

	__device__ KernelIterator& operator++();
	__device__ bool end() { return isEnd; }
	__device__ Vec<float> getImageCoordinate();
	__device__ Vec<size_t> getKernelIdx();
	
private:
	__device__ __host__ KernelIterator() {}

	// This is the first coordinate that to be used in the image
	// If the coordinate is non-integer, then the image should be interpolated
	Vec<float> inputStartCoordinate;

	// This is the first index of the kernel to use
	Vec<size_t> kernelStartIdx;

	// This is the last index of the kernel to use (e.g. end+1 is out of bounds)
	Vec<size_t> kernelEndIdx;

	// This indicates the current position
	Vec<size_t> iterator;

	bool isEnd;
};

