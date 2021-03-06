#pragma once
#include "CudaImageContainer.cuh"
#include "CudaDeviceImages.cuh"
#include "CudaUtilities.h"
#include "CudaDeviceInfo.h"
#include "Kernel.cuh"
#include "KernelIterator.cuh"
#include "ImageDimensions.cuh"
#include "ImageChunk.h"
#include "Defines.h"
#include "Vec.h"
#include "KernelGenerators.h"
#include "SeparableMultiplySum.cuh"
#include "CudaElementWiseDifference.cuh"

#include <cuda_runtime.h>
#include <limits>
#include <omp.h>

template <class PixelTypeIn, class PixelTypeOut>
void cHighPassFilter(ImageContainer<PixelTypeIn> imageIn, ImageContainer<PixelTypeOut>& imageOut, Vec<double> sigmas, int device = -1)
{
	const float MIN_VAL = std::numeric_limits<float>::lowest();
	const float MAX_VAL = std::numeric_limits<float>::max();
	const int NUM_BUFF_NEEDED = 3;

	setUpOutIm<PixelTypeOut>(imageIn.getDims(), imageOut);

	CudaDevices cudaDevs(cudaMultiplySum<float, float>, device);

	Vec<std::size_t> kernDims(0);
	float* hostKernels = createGaussianKernel(sigmas, kernDims);

	std::vector<ImageChunk> chunks = calculateBuffers(imageIn.getDims(), NUM_BUFF_NEEDED, cudaDevs, sizeof(float), kernDims);

	Vec<std::size_t> maxDeviceDims;
	setMaxDeviceDims(chunks, maxDeviceDims);

	omp_set_num_threads(MIN(chunks.size(), cudaDevs.getNumDevices()));
	#pragma omp parallel default(shared)
	{
		const int CUDA_IDX = omp_get_thread_num();
		const int N_THREADS = omp_get_num_threads();
		const int CUR_DEVICE = cudaDevs.getDeviceIdx(CUDA_IDX);

		CudaDeviceImages<float> deviceImagesIn(NUM_BUFF_NEEDED, maxDeviceDims, CUR_DEVICE);

		Kernel constFullKern(kernDims.sum(), hostKernels, CUR_DEVICE);
		Kernel constKernelMem_x = constFullKern.getOffsetCopy(Vec<std::size_t>(kernDims.x, 1, 1), 0);
		Kernel constKernelMem_y = constFullKern.getOffsetCopy(Vec<std::size_t>(1, kernDims.y, 1), kernDims.x);
		Kernel constKernelMem_z = constFullKern.getOffsetCopy(Vec<std::size_t>(1, 1, kernDims.z), kernDims.x + kernDims.y);

		for (int i = CUDA_IDX; i < chunks.size(); i += N_THREADS)
		{
			if (!chunks[i].sendROI(imageIn, deviceImagesIn.getCurBuffer()))
				std::runtime_error("Error sending ROI to device!");

			deviceImagesIn.setAllDims(chunks[i].getFullChunkSize());

			// blur the input image
			SeparableMultiplySum(chunks[i], deviceImagesIn, constKernelMem_x, constKernelMem_y, constKernelMem_z, MIN_VAL, MAX_VAL);

			// subtract the blurred image from the original
			chunks[i].sendROI(imageIn, deviceImagesIn.getNextBuffer());
			cudaElementWiseDifference<<<chunks[i].blocks, chunks[i].threads>>>(*(deviceImagesIn.getNextBuffer()), *(deviceImagesIn.getCurBuffer()), *(deviceImagesIn.getThirdBuffer()), 0.0f, MAX_VAL);

			chunks[i].retriveROI(imageOut, deviceImagesIn.getThirdBuffer());
		}

		constFullKern.clean();
	}

	delete[] hostKernels;
}
