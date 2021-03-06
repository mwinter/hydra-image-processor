#include "CWrappers.h"
#include "CudaDeviceCount.cuh"
#include "CudaDeviceStats.h"
#include "CudaMemoryStats.cuh"

#include "CudaClosure.cuh"
#include "CudaElementWiseDifference.cuh"
#include "CudaEntropyFilter.cuh"
#include "CudaGaussian.cuh"
#include "CudaGetMinMax.cuh"
#include "CudaHighPassFilter.cuh"
#include "CudaLoG.cuh"
#include "CudaMaxFilter.cuh"
#include "CudaMedianFilter.cuh"
#include "CudaMeanFilter.cuh"
#include "CudaMinFilter.cuh"
#include "CudaMinMax.cuh"
#include "CudaMultiplySum.cuh"
#include "CudaOpener.cuh"
#include "CudaStdFilter.cuh"
#include "CudaSum.cuh"
#include "CudaVarFilter.cuh"
#include "CudaWienerFilter.cuh"


void clearDevice()
{
	cudaDeviceReset();
}

 int deviceCount()
 {
	 return cDeviceCount();
 }

 int deviceStats(DevStats** stats)
 {
	 return cDeviceStats(stats);
 }

 int memoryStats(std::size_t** stats)
 {
	 return cMemoryStats(stats);
 }

 /// Example wrapper code
 //void fooFilter(const ImageContainer<bool> imageIn, ImageContainer<bool>& imageOut, ImageContainer<float> kernel, int numIterations /*= 1*/, int device /*= -1*/)
 //{
	// cFooFilter(imageIn, imageOut, kernel, numIterations, device);
 //}


 //void fooFilter(const ImageContainer<char> imageIn, ImageContainer<char>& imageOut, ImageContainer<float> kernel, int numIterations /*= 1*/, int device /*= -1*/)
 //{
	// cFooFilter(imageIn, imageOut, kernel, numIterations, device);
 //}


 //void fooFilter(const ImageContainer<unsigned char> imageIn, ImageContainer<unsigned char>& imageOut, ImageContainer<float> kernel, int numIterations /*= 1*/, int device /*= -1*/)
 //{
	// cFooFilter(imageIn, imageOut, kernel, numIterations, device);
 //}


 //void fooFilter(const ImageContainer<short> imageIn, ImageContainer<short>& imageOut, ImageContainer<float> kernel, int numIterations /*= 1*/, int device /*= -1*/)
 //{
	// cFooFilter(imageIn, imageOut, kernel, numIterations, device);
 //}


 //void fooFilter(const ImageContainer<unsigned short> imageIn, ImageContainer<unsigned short>& imageOut, ImageContainer<float> kernel, int numIterations /*= 1*/, int device /*= -1*/)
 //{
	// cFooFilter(imageIn, imageOut, kernel, numIterations, device);
 //}


 //void fooFilter(const ImageContainer<int> imageIn, ImageContainer<int>& imageOut, ImageContainer<float> kernel, int numIterations /*= 1*/, int device /*= -1*/)
 //{
	// cFooFilter(imageIn, imageOut, kernel, numIterations, device);
 //}


 //void fooFilter(const ImageContainer<unsigned int> imageIn, ImageContainer<unsigned int>& imageOut, ImageContainer<float> kernel, int numIterations /*= 1*/, int device /*= -1*/)
 //{
	// cFooFilter(imageIn, imageOut, kernel, numIterations, device);
 //}


 //void fooFilter(const ImageContainer<float> imageIn, ImageContainer<float>& imageOut, ImageContainer<float> kernel, int numIterations /*= 1*/, int device /*= -1*/)
 //{
	// cFooFilter(imageIn, imageOut, kernel, numIterations, device);
 //}

 //void fooFilter(const ImageContainer<double> imageIn, ImageContainer<double>& imageOut, ImageContainer<float> kernel, int numIterations /*= 1*/, int device /*= -1*/)
 //{
 // cFooFilter(imageIn, imageOut, kernel, numIterations, device);
 //}

 void closure(const ImageContainer<bool> imageIn, ImageContainer<bool>& imageOut, ImageContainer<float> kernel, int numIterations /*= 1*/, int device /*= -1*/)
 {
	 cClosure(imageIn, imageOut, kernel, numIterations, device);
 }
 
 void closure(const ImageContainer<char> imageIn, ImageContainer<char>& imageOut, ImageContainer<float> kernel, int numIterations /*= 1*/, int device /*= -1*/)
 {
	 cClosure(imageIn, imageOut, kernel, numIterations, device);
 }
 
 void closure(const ImageContainer<unsigned char> imageIn, ImageContainer<unsigned char>& imageOut, ImageContainer<float> kernel, int numIterations /*= 1*/, int device /*= -1*/)
 {
	 cClosure(imageIn, imageOut, kernel, numIterations, device);
 }
 
 void closure(const ImageContainer<short> imageIn, ImageContainer<short>& imageOut, ImageContainer<float> kernel, int numIterations /*= 1*/, int device /*= -1*/)
 {
	 cClosure(imageIn, imageOut, kernel, numIterations, device);
 }
 
 void closure(const ImageContainer<unsigned short> imageIn, ImageContainer<unsigned short>& imageOut, ImageContainer<float> kernel, int numIterations /*= 1*/, int device /*= -1*/)
 {
	 cClosure(imageIn, imageOut, kernel, numIterations, device);
 }
 
 void closure(const ImageContainer<int> imageIn, ImageContainer<int>& imageOut, ImageContainer<float> kernel, int numIterations /*= 1*/, int device /*= -1*/)
 {
	 cClosure(imageIn, imageOut, kernel, numIterations, device);
 }
 
 void closure(const ImageContainer<unsigned int> imageIn, ImageContainer<unsigned int>& imageOut, ImageContainer<float> kernel, int numIterations /*= 1*/, int device /*= -1*/)
 {
	 cClosure(imageIn, imageOut, kernel, numIterations, device);
 }
 
 void closure(const ImageContainer<float> imageIn, ImageContainer<float>& imageOut, ImageContainer<float> kernel, int numIterations /*= 1*/, int device /*= -1*/)
 {
	 cClosure(imageIn, imageOut, kernel, numIterations, device);
 }
 
 void closure(const ImageContainer<double> imageIn, ImageContainer<double>& imageOut, ImageContainer<float> kernel, int numIterations /*= 1*/, int device /*= -1*/)
 {
	 cClosure(imageIn, imageOut, kernel, numIterations, device);
 }

 
 void elementWiseDifference(const ImageContainer<bool> image1In, ImageContainer<bool> image2In, ImageContainer<bool>& imageOut, int device /*= -1*/)
 {
	 cElementWiseDifference(image1In, image2In, imageOut, device);
 }

 void elementWiseDifference(const ImageContainer<char> image1In, ImageContainer<char> image2In, ImageContainer<char>& imageOut, int device /*= -1*/)
 {
	 cElementWiseDifference(image1In, image2In, imageOut, device);
 }

 void elementWiseDifference(const ImageContainer<unsigned char> image1In, ImageContainer<unsigned char> image2In, ImageContainer<unsigned char>& imageOut, int device /*= -1*/)
 {
	 cElementWiseDifference(image1In, image2In, imageOut, device);
 }

 void elementWiseDifference(const ImageContainer<short> image1In, ImageContainer<short> image2In, ImageContainer<short>& imageOut, int device /*= -1*/)
 {
	 cElementWiseDifference(image1In, image2In, imageOut, device);
 }

 void elementWiseDifference(const ImageContainer<unsigned short> image1In, ImageContainer<unsigned short> image2In, ImageContainer<unsigned short>& imageOut, int device /*= -1*/)
 {
	 cElementWiseDifference(image1In, image2In, imageOut, device);
 }

 void elementWiseDifference(const ImageContainer<int> image1In, ImageContainer<int> image2In, ImageContainer<int>& imageOut, int device /*= -1*/)
 {
	 cElementWiseDifference(image1In, image2In, imageOut, device);
 }

 void elementWiseDifference(const ImageContainer<unsigned int> image1In, ImageContainer<unsigned int> image2In, ImageContainer<unsigned int>& imageOut, int device /*= -1*/)
 {
	 cElementWiseDifference(image1In, image2In, imageOut, device);
 }

 void elementWiseDifference(const ImageContainer<float> image1In, ImageContainer<float> image2In, ImageContainer<float>& imageOut, int device /*= -1*/)
 {
	 cElementWiseDifference(image1In, image2In, imageOut, device);
 }

 void elementWiseDifference(const ImageContainer<double> image1In, ImageContainer<double> image2In, ImageContainer<double>& imageOut, int device /*= -1*/)
 {
	 cElementWiseDifference(image1In, image2In, imageOut, device);
 }

 
 void entropyFilter(const ImageContainer<bool> imageIn, ImageContainer<float>& imageOut, ImageContainer<float> kernel, int device /*= -1*/)
 {
	 cEntropyFilter(imageIn, imageOut, kernel, device);
 }
 
 void entropyFilter(const ImageContainer<char> imageIn, ImageContainer<float>& imageOut, ImageContainer<float> kernel, int device /*= -1*/)
 {
	 cEntropyFilter(imageIn, imageOut, kernel, device);
 }
 
 void entropyFilter(const ImageContainer<unsigned char> imageIn, ImageContainer<float>& imageOut, ImageContainer<float> kernel, int device /*= -1*/)
 {
	 cEntropyFilter(imageIn, imageOut, kernel, device);
 }

 void entropyFilter(const ImageContainer<short> imageIn, ImageContainer<float>& imageOut, ImageContainer<float> kernel, int device /*= -1*/)
 {
	 cEntropyFilter(imageIn, imageOut, kernel, device);
 }
  
 void entropyFilter(const ImageContainer<unsigned short> imageIn, ImageContainer<float>& imageOut, ImageContainer<float> kernel, int device /*= -1*/)
 {
	 cEntropyFilter(imageIn, imageOut, kernel, device);
 }
 
 void entropyFilter(const ImageContainer<int> imageIn, ImageContainer<float>& imageOut, ImageContainer<float> kernel, int device /*= -1*/)
 {
	 cEntropyFilter(imageIn, imageOut, kernel, device);
 }
 
 void entropyFilter(const ImageContainer<unsigned int> imageIn, ImageContainer<float>& imageOut, ImageContainer<float> kernel, int device /*= -1*/)
 {
	 cEntropyFilter(imageIn, imageOut, kernel, device);
 }
 
 void entropyFilter(const ImageContainer<float> imageIn, ImageContainer<float>& imageOut, ImageContainer<float> kernel, int device /*= -1*/)
 {
	 cEntropyFilter(imageIn, imageOut, kernel, device);
 }
 
 void entropyFilter(const ImageContainer<double> imageIn, ImageContainer<float>& imageOut, ImageContainer<float> kernel, int device /*= -1*/)
 {
	 cEntropyFilter(imageIn, imageOut, kernel, device);
 }


void gaussian(const ImageContainer<bool> imageIn, ImageContainer<bool>& imageOut, Vec<double> sigmas, int numIterations /*= 1*/, int device /*= -1*/)
 {
	 cGaussian(imageIn, imageOut, sigmas, numIterations, device);
 }
 
 void gaussian(const ImageContainer<char> imageIn, ImageContainer<char>& imageOut, Vec<double> sigmas, int numIterations /*= 1*/, int device /*= -1*/)
 {
	 cGaussian(imageIn, imageOut, sigmas, numIterations, device);
 }
 
 void gaussian(const ImageContainer<unsigned char> imageIn, ImageContainer<unsigned char>& imageOut, Vec<double> sigmas, int numIterations /*= 1*/, int device /*= -1*/)
 {
	 cGaussian(imageIn, imageOut, sigmas, numIterations, device);
 }
 
 void gaussian(const ImageContainer<short> imageIn, ImageContainer<short>& imageOut, Vec<double> sigmas, int numIterations /*= 1*/, int device /*= -1*/)
 {
	 cGaussian(imageIn, imageOut, sigmas, numIterations, device);
 }
 
 void gaussian(const ImageContainer<unsigned short> imageIn, ImageContainer<unsigned short>& imageOut, Vec<double> sigmas, int numIterations /*= 1*/, int device /*= -1*/)
 {
	 cGaussian(imageIn, imageOut, sigmas, numIterations, device);
 }
 
 void gaussian(const ImageContainer<int> imageIn, ImageContainer<int>& imageOut, Vec<double> sigmas, int numIterations /*= 1*/, int device /*= -1*/)
 {
	 cGaussian(imageIn, imageOut, sigmas, numIterations, device);
 }
 
 void gaussian(const ImageContainer<unsigned int> imageIn, ImageContainer<unsigned int>& imageOut, Vec<double> sigmas, int numIterations /*= 1*/, int device /*= -1*/)
 {
	 cGaussian(imageIn, imageOut, sigmas, numIterations, device);
 }

 void gaussian(const ImageContainer<float> imageIn, ImageContainer<float>& imageOut, Vec<double> sigmas, int numIterations /*= 1*/, int device /*= -1*/)
 {
	 cGaussian(imageIn, imageOut, sigmas, numIterations, device);
 }

 void gaussian(const ImageContainer<double> imageIn, ImageContainer<double>& imageOut, Vec<double> sigmas, int numIterations /*= 1*/, int device /*= -1*/)
 {
	 cGaussian(imageIn, imageOut, sigmas, numIterations, device);
 }


 void getMinMax(const bool* imageIn, std::size_t numElements, bool& minVal, bool& maxVal, int device /*= 0*/)
 {
	 cGetMinMax(imageIn, numElements, minVal, maxVal, device);
 }

 void getMinMax(const char* imageIn, std::size_t numElements, char& minVal, char& maxVal, int device /*= 0*/)
 {
	 cGetMinMax(imageIn, numElements, minVal, maxVal, device);
 }

 void getMinMax(const unsigned char* imageIn, std::size_t numElements, unsigned char& minVal, unsigned char& maxVal, int device /*= 0*/)
 {
	 cGetMinMax(imageIn, numElements, minVal, maxVal, device);
 }

 void getMinMax(const short* imageIn, std::size_t numElements, short& minVal, short& maxVal, int device /*= 0*/)
 {
	 cGetMinMax(imageIn, numElements, minVal, maxVal, device);
 }

 void getMinMax(const unsigned short* imageIn, std::size_t numElements, unsigned short& minVal, unsigned short& maxVal, int device /*= 0*/)
 {
	 cGetMinMax(imageIn, numElements, minVal, maxVal, device);
 }

 void getMinMax(const int* imageIn, std::size_t numElements, int& minVal, int& maxVal, int device /*= 0*/)
 {
	 cGetMinMax(imageIn, numElements, minVal, maxVal, device);
 }

 void getMinMax(const unsigned int* imageIn, std::size_t numElements, unsigned int& minVal, unsigned int& maxVal, int device /*= 0*/)
 {
	 cGetMinMax(imageIn, numElements, minVal, maxVal, device);
 }

 void getMinMax(const float* imageIn, std::size_t numElements, float& minVal, float& maxVal, int device /*= 0*/)
 {
	 cGetMinMax(imageIn, numElements, minVal, maxVal, device);
 }

 void getMinMax(const double* imageIn, std::size_t numElements, double& minVal, double& maxVal, int device /*= 0*/)
 {
	 cGetMinMax(imageIn, numElements, minVal, maxVal, device);
 }


 void highPassFilter(const ImageContainer<bool> imageIn, ImageContainer<bool>& imageOut, Vec<double> sigmas, int device /*= -1*/)
 {
	 cHighPassFilter(imageIn, imageOut, sigmas, device);
 }
 
 void highPassFilter(const ImageContainer<char> imageIn, ImageContainer<char>& imageOut, Vec<double> sigmas, int device /*= -1*/)
 {
	 cHighPassFilter(imageIn, imageOut, sigmas, device);
 }
 
 void highPassFilter(const ImageContainer<unsigned char> imageIn, ImageContainer<unsigned char>& imageOut, Vec<double> sigmas, int device /*= -1*/)
 {
	 cHighPassFilter(imageIn, imageOut, sigmas, device);
 }
 
 void highPassFilter(const ImageContainer<short> imageIn, ImageContainer<short>& imageOut, Vec<double> sigmas, int device /*= -1*/)
 {
	 cHighPassFilter(imageIn, imageOut, sigmas, device);
 }
 
 void highPassFilter(const ImageContainer<unsigned short> imageIn, ImageContainer<unsigned short>& imageOut, Vec<double> sigmas, int device /*= -1*/)
 {
	 cHighPassFilter(imageIn, imageOut, sigmas, device);
 }
 
 void highPassFilter(const ImageContainer<int> imageIn, ImageContainer<int>& imageOut, Vec<double> sigmas, int device /*= -1*/)
 {
	 cHighPassFilter(imageIn, imageOut, sigmas, device);
 }
 
 void highPassFilter(const ImageContainer<unsigned int> imageIn, ImageContainer<unsigned int>& imageOut, Vec<double> sigmas, int device /*= -1*/)
 {
	 cHighPassFilter(imageIn, imageOut, sigmas, device);
 }
 
 void highPassFilter(const ImageContainer<float> imageIn, ImageContainer<float>& imageOut, Vec<double> sigmas, int device /*= -1*/)
 {
	 cHighPassFilter(imageIn, imageOut, sigmas, device);
 }
 
 void highPassFilter(const ImageContainer<double> imageIn, ImageContainer<double>& imageOut, Vec<double> sigmas, int device /*= -1*/)
 {
	 cHighPassFilter(imageIn, imageOut, sigmas, device);
 }


 void LoG(const ImageContainer<bool> imageIn, ImageContainer<float>& imageOut, Vec<double> sigmas, int device /*= -1*/)
 {
	 cLoG(imageIn, imageOut, sigmas, device);
 }

 void LoG(const ImageContainer<char> imageIn, ImageContainer<float>& imageOut, Vec<double> sigmas, int device /*= -1*/)
 {
	 cLoG(imageIn, imageOut, sigmas, device);
 }

 void LoG(const ImageContainer<unsigned char> imageIn, ImageContainer<float>& imageOut, Vec<double> sigmas, int device /*= -1*/)
 {
	 cLoG(imageIn, imageOut, sigmas, device);
 }

 void LoG(const ImageContainer<short> imageIn, ImageContainer<float>& imageOut, Vec<double> sigmas, int device /*= -1*/)
 {
	 cLoG(imageIn, imageOut, sigmas, device);
 }

 void LoG(const ImageContainer<unsigned short> imageIn, ImageContainer<float>& imageOut, Vec<double> sigmas, int device /*= -1*/)
 {
	 cLoG(imageIn, imageOut, sigmas, device);
 }

 void LoG(const ImageContainer<int> imageIn, ImageContainer<float>& imageOut, Vec<double> sigmas, int device /*= -1*/)
 {
	 cLoG(imageIn, imageOut, sigmas, device);
 }

 void LoG(const ImageContainer<unsigned int> imageIn, ImageContainer<float>& imageOut, Vec<double> sigmas, int device /*= -1*/)
 {
	 cLoG(imageIn, imageOut, sigmas, device);
 }

 void LoG(const ImageContainer<float> imageIn, ImageContainer<float>& imageOut, Vec<double> sigmas, int device /*= -1*/)
 {
	 cLoG(imageIn, imageOut, sigmas, device);
 }

 void LoG(const ImageContainer<double> imageIn, ImageContainer<float>& imageOut, Vec<double> sigmas, int device /*= -1*/)
 {
	 cLoG(imageIn, imageOut, sigmas, device);
 }


 void maxFilter(const ImageContainer<bool> imageIn, ImageContainer<bool>& imageOut, ImageContainer<float> kernel, int numIterations /*= 1*/, int device /*= -1*/)
 {
	 cMaxFilter(imageIn, imageOut, kernel, numIterations, device);
 }
 
 void maxFilter(const ImageContainer<char> imageIn, ImageContainer<char>& imageOut, ImageContainer<float> kernel, int numIterations /*= 1*/, int device /*= -1*/)
 {
	 cMaxFilter(imageIn, imageOut, kernel, numIterations, device);
 }
 
 void maxFilter(const ImageContainer<unsigned char> imageIn, ImageContainer<unsigned char>& imageOut, ImageContainer<float> kernel, int numIterations /*= 1*/, int device /*= -1*/)
 {
	 cMaxFilter(imageIn, imageOut, kernel, numIterations, device);
 }
 
 void maxFilter(const ImageContainer<short> imageIn, ImageContainer<short>& imageOut, ImageContainer<float> kernel, int numIterations /*= 1*/, int device /*= -1*/)
 {
	 cMaxFilter(imageIn, imageOut, kernel, numIterations, device);
 }
 
 void maxFilter(const ImageContainer<unsigned short> imageIn, ImageContainer<unsigned short>& imageOut, ImageContainer<float> kernel, int numIterations /*= 1*/, int device /*= -1*/)
 {
	 cMaxFilter(imageIn, imageOut, kernel, numIterations, device);
 }
 
 void maxFilter(const ImageContainer<int> imageIn, ImageContainer<int>& imageOut, ImageContainer<float> kernel, int numIterations /*= 1*/, int device /*= -1*/)
 {
	 cMaxFilter(imageIn, imageOut, kernel, numIterations, device);
 }
 
 void maxFilter(const ImageContainer<unsigned int> imageIn, ImageContainer<unsigned int>& imageOut, ImageContainer<float> kernel, int numIterations /*= 1*/, int device /*= -1*/)
 {
	 cMaxFilter(imageIn, imageOut, kernel, numIterations, device);
 }
 
 void maxFilter(const ImageContainer<float> imageIn, ImageContainer<float>& imageOut, ImageContainer<float> kernel, int numIterations /*= 1*/, int device /*= -1*/)
 {
	 cMaxFilter(imageIn, imageOut, kernel, numIterations, device);
 }
 
 void maxFilter(const ImageContainer<double> imageIn, ImageContainer<double>& imageOut, ImageContainer<float> kernel, int numIterations /*= 1*/, int device /*= -1*/)
 {
	 cMaxFilter(imageIn, imageOut, kernel, numIterations, device);
 }
 

 void meanFilter(const ImageContainer<bool> imageIn, ImageContainer<bool>& imageOut, ImageContainer<float> kernel, int numIterations /*= 1*/, int device /*= -1*/)
 {
	 cMeanFilter(imageIn, imageOut, kernel, numIterations, device);
 }

 void meanFilter(const ImageContainer<char> imageIn, ImageContainer<char>& imageOut, ImageContainer<float> kernel, int numIterations /*= 1*/, int device /*= -1*/)
 {
	 cMeanFilter(imageIn, imageOut, kernel, numIterations, device);
 }
 
 void meanFilter(const ImageContainer<unsigned char> imageIn, ImageContainer<unsigned char>& imageOut, ImageContainer<float> kernel, int numIterations /*= 1*/, int device /*= -1*/)
 {
	 cMeanFilter(imageIn, imageOut, kernel, numIterations, device);
 }
 
 void meanFilter(const ImageContainer<short> imageIn, ImageContainer<short>& imageOut, ImageContainer<float> kernel, int numIterations /*= 1*/, int device /*= -1*/)
 {
	 cMeanFilter(imageIn, imageOut, kernel, numIterations, device);
 }
 
 void meanFilter(const ImageContainer<unsigned short> imageIn, ImageContainer<unsigned short>& imageOut, ImageContainer<float> kernel, int numIterations /*= 1*/, int device /*= -1*/)
 {
	 cMeanFilter(imageIn, imageOut, kernel, numIterations, device);
 }
 
 void meanFilter(const ImageContainer<int> imageIn, ImageContainer<int>& imageOut, ImageContainer<float> kernel, int numIterations /*= 1*/, int device /*= -1*/)
 {
	 cMeanFilter(imageIn, imageOut, kernel, numIterations, device);
 }
 
 void meanFilter(const ImageContainer<unsigned int> imageIn, ImageContainer<unsigned int>& imageOut, ImageContainer<float> kernel, int numIterations /*= 1*/, int device /*= -1*/)
 {
	 cMeanFilter(imageIn, imageOut, kernel, numIterations, device);
 }

 void meanFilter(const ImageContainer<float> imageIn, ImageContainer<float>& imageOut, ImageContainer<float> kernel, int numIterations /*= 1*/, int device /*= -1*/)
 {
	 cMeanFilter(imageIn, imageOut, kernel, numIterations, device);
 }
 
 void meanFilter(const ImageContainer<double> imageIn, ImageContainer<double>& imageOut, ImageContainer<float> kernel, int numIterations /*= 1*/, int device /*= -1*/)
 {
	 cMeanFilter(imageIn, imageOut, kernel, numIterations, device);
 }


 void medianFilter(const ImageContainer<bool> imageIn, ImageContainer<bool>& imageOut, ImageContainer<float> kernel, int numIterations /*= 1*/, int device /*= -1*/)
 {
	 cMedianFilter(imageIn, imageOut, kernel, numIterations, device);
 }

 void medianFilter(const ImageContainer<char> imageIn, ImageContainer<char>& imageOut, ImageContainer<float> kernel, int numIterations /*= 1*/, int device /*= -1*/)
 {
	 cMedianFilter(imageIn, imageOut, kernel, numIterations, device);
 }

 void medianFilter(const ImageContainer<unsigned char> imageIn, ImageContainer<unsigned char>& imageOut, ImageContainer<float> kernel, int numIterations /*= 1*/, int device /*= -1*/)
 {
	 cMedianFilter(imageIn, imageOut, kernel, numIterations, device);
 }

 void medianFilter(const ImageContainer<short> imageIn, ImageContainer<short>& imageOut, ImageContainer<float> kernel, int numIterations /*= 1*/, int device /*= -1*/)
 {
	 cMedianFilter(imageIn, imageOut, kernel, numIterations, device);
 }

 void medianFilter(const ImageContainer<unsigned short> imageIn, ImageContainer<unsigned short>& imageOut, ImageContainer<float> kernel, int numIterations /*= 1*/, int device /*= -1*/)
 {
	 cMedianFilter(imageIn, imageOut, kernel, numIterations, device);
 }

 void medianFilter(const ImageContainer<int> imageIn, ImageContainer<int>& imageOut, ImageContainer<float> kernel, int numIterations /*= 1*/, int device /*= -1*/)
 {
	 cMedianFilter(imageIn, imageOut, kernel, numIterations, device);
 }

 void medianFilter(const ImageContainer<unsigned int> imageIn, ImageContainer<unsigned int>& imageOut, ImageContainer<float> kernel, int numIterations /*= 1*/, int device /*= -1*/)
 {
	 cMedianFilter(imageIn, imageOut, kernel, numIterations, device);
 }

 void medianFilter(const ImageContainer<float> imageIn, ImageContainer<float>& imageOut, ImageContainer<float> kernel, int numIterations /*= 1*/, int device /*= -1*/)
 {
	 cMedianFilter(imageIn, imageOut, kernel, numIterations, device);
 }

 void medianFilter(const ImageContainer<double> imageIn, ImageContainer<double>& imageOut, ImageContainer<float> kernel, int numIterations /*= 1*/, int device /*= -1*/)
 {
	 cMedianFilter(imageIn, imageOut, kernel, numIterations, device);
 }


 void minFilter(const ImageContainer<bool> imageIn, ImageContainer<bool>& imageOut, ImageContainer<float> kernel, int numIterations /*= 1*/, int device /*= -1*/)
 {
	 cMinFilter(imageIn, imageOut, kernel, numIterations, device);
 }
 
 void minFilter(const ImageContainer<char> imageIn, ImageContainer<char>& imageOut, ImageContainer<float> kernel, int numIterations /*= 1*/, int device /*= -1*/)
 {
	 cMinFilter(imageIn, imageOut, kernel, numIterations, device);
 }
 
 void minFilter(const ImageContainer<unsigned char> imageIn, ImageContainer<unsigned char>& imageOut, ImageContainer<float> kernel, int numIterations /*= 1*/, int device /*= -1*/)
 {
	 cMinFilter(imageIn, imageOut, kernel, numIterations, device);
 }

 void minFilter(const ImageContainer<short> imageIn, ImageContainer<short>& imageOut, ImageContainer<float> kernel, int numIterations /*= 1*/, int device /*= -1*/)
 {
	 cMinFilter(imageIn, imageOut, kernel, numIterations, device);
 }
 
 void minFilter(const ImageContainer<unsigned short> imageIn, ImageContainer<unsigned short>& imageOut, ImageContainer<float> kernel, int numIterations /*= 1*/, int device /*= -1*/)
 {
	 cMinFilter(imageIn, imageOut, kernel, numIterations, device);
 }
 
 void minFilter(const ImageContainer<int> imageIn, ImageContainer<int>& imageOut, ImageContainer<float> kernel, int numIterations /*= 1*/, int device /*= -1*/)
 {
	 cMinFilter(imageIn, imageOut, kernel, numIterations, device);
 }
 
 void minFilter(const ImageContainer<unsigned int> imageIn, ImageContainer<unsigned int>& imageOut, ImageContainer<float> kernel, int numIterations /*= 1*/, int device /*= -1*/)
 {
	 cMinFilter(imageIn, imageOut, kernel, numIterations, device);
 }
 
 void minFilter(const ImageContainer<float> imageIn, ImageContainer<float>& imageOut, ImageContainer<float> kernel, int numIterations /*= 1*/, int device /*= -1*/)
 {
	 cMinFilter(imageIn, imageOut, kernel, numIterations, device);
 }
 
 void minFilter(const ImageContainer<double> imageIn, ImageContainer<double>& imageOut, ImageContainer<float> kernel, int numIterations /*= 1*/, int device /*= -1*/)
 {
	 cMinFilter(imageIn, imageOut, kernel, numIterations, device);
 }
 

 void minMax(const ImageContainer<bool> imageIn, bool& minVal, bool& maxVal, int device /*= -1*/)
 {
	 cMinMax(imageIn, minVal, maxVal, device);
 }

 void minMax(const ImageContainer<char> imageIn, char& minVal, char& maxVal, int device /*= -1*/)
 {
	 cMinMax(imageIn, minVal, maxVal, device);
 }

 void minMax(const ImageContainer<unsigned char> imageIn, unsigned char& minVal, unsigned char& maxVal, int device /*= -1*/)
 {
	 cMinMax(imageIn, minVal, maxVal, device);
 }

 void minMax(const ImageContainer<short> imageIn, short& minVal, short& maxVal, int device /*= -1*/)
 {
	 cMinMax(imageIn, minVal, maxVal, device);
 }

 void minMax(const ImageContainer<unsigned short> imageIn, unsigned short& minVal, unsigned short& maxVal, int device /*= -1*/)
 {
	 cMinMax(imageIn, minVal, maxVal, device);
 }

 void minMax(const ImageContainer<int> imageIn, int& minVal, int& maxVal, int device /*= -1*/)
 {
	 cMinMax(imageIn, minVal, maxVal, device);
 }

 void minMax(const ImageContainer<unsigned int> imageIn, unsigned int& minVal, unsigned int& maxVal, int device /*= -1*/)
 {
	 cMinMax(imageIn, minVal, maxVal, device);
 }

 void minMax(const ImageContainer<float> imageIn, float& minVal, float& maxVal, int device /*= -1*/)
 {
	 cMinMax(imageIn, minVal, maxVal, device);
 }

 void minMax(const ImageContainer<double> imageIn, double& minVal, double& maxVal, int device /*= -1*/)
 {
	 cMinMax(imageIn, minVal, maxVal, device);
 }


 void multiplySum(const ImageContainer<bool> imageIn, ImageContainer<bool>& imageOut, ImageContainer<float> kernel, int numIterations /*= 1*/, int device /*= -1*/)
 {
	 cMultiplySum(imageIn, imageOut, kernel, numIterations, device);
 }
 
 void multiplySum(const ImageContainer<char> imageIn, ImageContainer<char>& imageOut, ImageContainer<float> kernel, int numIterations /*= 1*/, int device /*= -1*/)
 {
	 cMultiplySum(imageIn, imageOut, kernel, numIterations, device);
 }
 
 void multiplySum(const ImageContainer<unsigned char> imageIn, ImageContainer<unsigned char>& imageOut, ImageContainer<float> kernel, int numIterations /*= 1*/, int device /*= -1*/)
 {
	 cMultiplySum(imageIn, imageOut, kernel, numIterations, device);
 }
 
 void multiplySum(const ImageContainer<short> imageIn, ImageContainer<short>& imageOut, ImageContainer<float> kernel, int numIterations /*= 1*/, int device /*= -1*/)
 {
	 cMultiplySum(imageIn, imageOut, kernel, numIterations, device);
 }
 
 void multiplySum(const ImageContainer<unsigned short> imageIn, ImageContainer<unsigned short>& imageOut, ImageContainer<float> kernel, int numIterations /*= 1*/, int device /*= -1*/)
 {
	 cMultiplySum(imageIn, imageOut, kernel, numIterations, device);
 }
 
 void multiplySum(const ImageContainer<int> imageIn, ImageContainer<int>& imageOut, ImageContainer<float> kernel, int numIterations /*= 1*/, int device /*= -1*/)
 {
	 cMultiplySum(imageIn, imageOut, kernel, numIterations, device);
 }
 
 void multiplySum(const ImageContainer<unsigned int> imageIn, ImageContainer<unsigned int>& imageOut, ImageContainer<float> kernel, int numIterations /*= 1*/, int device /*= -1*/)
 {
	 cMultiplySum(imageIn, imageOut, kernel, numIterations, device);
 }
 
 void multiplySum(const ImageContainer<float> imageIn, ImageContainer<float>& imageOut, ImageContainer<float> kernel, int numIterations /*= 1*/, int device /*= -1*/)
 {
	 cMultiplySum(imageIn, imageOut, kernel, numIterations, device);
 }
 
 void multiplySum(const ImageContainer<double> imageIn, ImageContainer<double>& imageOut, ImageContainer<float> kernel, int numIterations /*= 1*/, int device /*= -1*/)
 {
	 cMultiplySum(imageIn, imageOut, kernel, numIterations, device);
 }
 

 void opener(const ImageContainer<bool> imageIn, ImageContainer<bool>& imageOut, ImageContainer<float> kernel, int numIterations /*= 1*/, int device /*= -1*/)
 {
	 cOpener(imageIn, imageOut, kernel, numIterations, device);
 }

 void opener(const ImageContainer<char> imageIn, ImageContainer<char>& imageOut, ImageContainer<float> kernel, int numIterations /*= 1*/, int device /*= -1*/)
 {
	 cOpener(imageIn, imageOut, kernel, numIterations, device);
 }

 void opener(const ImageContainer<unsigned char> imageIn, ImageContainer<unsigned char>& imageOut, ImageContainer<float> kernel, int numIterations /*= 1*/, int device /*= -1*/)
 {
	 cOpener(imageIn, imageOut, kernel, numIterations, device);
 }

 void opener(const ImageContainer<short> imageIn, ImageContainer<short>& imageOut, ImageContainer<float> kernel, int numIterations /*= 1*/, int device /*= -1*/)
 {
	 cOpener(imageIn, imageOut, kernel, numIterations, device);
 }

 void opener(const ImageContainer<unsigned short> imageIn, ImageContainer<unsigned short>& imageOut, ImageContainer<float> kernel, int numIterations /*= 1*/, int device /*= -1*/)
 {
	 cOpener(imageIn, imageOut, kernel, numIterations, device);
 }

 void opener(const ImageContainer<int> imageIn, ImageContainer<int>& imageOut, ImageContainer<float> kernel, int numIterations /*= 1*/, int device /*= -1*/)
 {
	 cOpener(imageIn, imageOut, kernel, numIterations, device);
 }

 void opener(const ImageContainer<unsigned int> imageIn, ImageContainer<unsigned int>& imageOut, ImageContainer<float> kernel, int numIterations /*= 1*/, int device /*= -1*/)
 {
	 cOpener(imageIn, imageOut, kernel, numIterations, device);
 }

 void opener(const ImageContainer<float> imageIn, ImageContainer<float>& imageOut, ImageContainer<float> kernel, int numIterations /*= 1*/, int device /*= -1*/)
 {
	 cOpener(imageIn, imageOut, kernel, numIterations, device);
 }

 void opener(const ImageContainer<double> imageIn, ImageContainer<double>& imageOut, ImageContainer<float> kernel, int numIterations /*= 1*/, int device /*= -1*/)
 {
	 cOpener(imageIn, imageOut, kernel, numIterations, device);
 }


 void stdFilter(const ImageContainer<bool> imageIn, ImageContainer<bool>& imageOut, ImageContainer<float> kernel, int numIterations /*= 1*/, int device /*= -1*/)
 {
	 cStdFilter(imageIn, imageOut, kernel, numIterations, device);
 }
 
 void stdFilter(const ImageContainer<char> imageIn, ImageContainer<char>& imageOut, ImageContainer<float> kernel, int numIterations /*= 1*/, int device /*= -1*/)
 {
	 cStdFilter(imageIn, imageOut, kernel, numIterations, device);
 }
 
 void stdFilter(const ImageContainer<unsigned char> imageIn, ImageContainer<unsigned char>& imageOut, ImageContainer<float> kernel, int numIterations /*= 1*/, int device /*= -1*/)
 {
	 cStdFilter(imageIn, imageOut, kernel, numIterations, device);
 }
 
 void stdFilter(const ImageContainer<short> imageIn, ImageContainer<short>& imageOut, ImageContainer<float> kernel, int numIterations /*= 1*/, int device /*= -1*/)
 {
	 cStdFilter(imageIn, imageOut, kernel, numIterations, device);
 }
 
 void stdFilter(const ImageContainer<unsigned short> imageIn, ImageContainer<unsigned short>& imageOut, ImageContainer<float> kernel, int numIterations /*= 1*/, int device /*= -1*/)
 {
	 cStdFilter(imageIn, imageOut, kernel, numIterations, device);
 }
 
 void stdFilter(const ImageContainer<int> imageIn, ImageContainer<int>& imageOut, ImageContainer<float> kernel, int numIterations /*= 1*/, int device /*= -1*/)
 {
	 cStdFilter(imageIn, imageOut, kernel, numIterations, device);
 }
 
 void stdFilter(const ImageContainer<unsigned int> imageIn, ImageContainer<unsigned int>& imageOut, ImageContainer<float> kernel, int numIterations /*= 1*/, int device /*= -1*/)
 {
	 cStdFilter(imageIn, imageOut, kernel, numIterations, device);
 }
 
 void stdFilter(const ImageContainer<float> imageIn, ImageContainer<float>& imageOut, ImageContainer<float> kernel, int numIterations /*= 1*/, int device /*= -1*/)
 {
	 cStdFilter(imageIn, imageOut, kernel, numIterations, device);
 }
 
 void stdFilter(const ImageContainer<double> imageIn, ImageContainer<double>& imageOut, ImageContainer<float> kernel, int numIterations /*= 1*/, int device /*= -1*/)
 {
	 cStdFilter(imageIn, imageOut, kernel, numIterations, device);
 }


 void sum(const ImageContainer<bool> imageIn, std::size_t& valOut, int device /*= -1*/)
 {
	 cSum(imageIn, valOut, device);
 }

 void sum(const ImageContainer<char> imageIn, long long& valOut, int device /*= -1*/)
 {
	 cSum(imageIn, valOut, device);
 }

 void sum(const ImageContainer<unsigned char> imageIn, std::size_t& valOut, int device /*= -1*/)
 {
	 cSum(imageIn, valOut, device);
 }

 void sum(const ImageContainer<short> imageIn, long long& valOut, int device /*= -1*/)
 {
	 cSum(imageIn, valOut, device);
 }

 void sum(const ImageContainer<unsigned short> imageIn, std::size_t& valOut, int device /*= -1*/)
 {
	 cSum(imageIn, valOut, device);
 }

 void sum(const ImageContainer<int> imageIn, long long& valOut, int device /*= -1*/)
 {
	 cSum(imageIn, valOut, device);
 }

 void sum(const ImageContainer<unsigned int> imageIn, std::size_t& valOut, int device /*= -1*/)
 {
	 cSum(imageIn, valOut, device);
 }

 void sum(const ImageContainer<float> imageIn, double& valOut, int device /*= -1*/)
 {
	 cSum(imageIn, valOut, device);
 }

 void sum(const ImageContainer<double> imageIn, double& valOut, int device /*= -1*/)
 {
	 cSum(imageIn, valOut, device);
 }


 void varFilter(const ImageContainer<bool> imageIn, ImageContainer<bool>& imageOut, ImageContainer<float> kernel, int numIterations /*= 1*/, int device /*= -1*/)
 {
	 cVarFilter(imageIn, imageOut, kernel, numIterations, device);
 }
 
 void varFilter(const ImageContainer<char> imageIn, ImageContainer<char>& imageOut, ImageContainer<float> kernel, int numIterations /*= 1*/, int device /*= -1*/)
 {
	 cVarFilter(imageIn, imageOut, kernel, numIterations, device);
 }

 void varFilter(const ImageContainer<unsigned char> imageIn, ImageContainer<unsigned char>& imageOut, ImageContainer<float> kernel, int numIterations /*= 1*/, int device /*= -1*/)
 {
	 cVarFilter(imageIn, imageOut, kernel, numIterations, device);
 }
 
 void varFilter(const ImageContainer<short> imageIn, ImageContainer<short>& imageOut, ImageContainer<float> kernel, int numIterations /*= 1*/, int device /*= -1*/)
 {
	 cVarFilter(imageIn, imageOut, kernel, numIterations, device);
 }
 
 void varFilter(const ImageContainer<unsigned short> imageIn, ImageContainer<unsigned short>& imageOut, ImageContainer<float> kernel, int numIterations /*= 1*/, int device /*= -1*/)
 {
	 cVarFilter(imageIn, imageOut, kernel, numIterations, device);
 }

 void varFilter(const ImageContainer<int> imageIn, ImageContainer<int>& imageOut, ImageContainer<float> kernel, int numIterations /*= 1*/, int device /*= -1*/)
 {
	 cVarFilter(imageIn, imageOut, kernel, numIterations, device);
 }

 void varFilter(const ImageContainer<unsigned int> imageIn, ImageContainer<unsigned int>& imageOut, ImageContainer<float> kernel, int numIterations /*= 1*/, int device /*= -1*/)
 {
	 cVarFilter(imageIn, imageOut, kernel, numIterations, device);
 }

 void varFilter(const ImageContainer<float> imageIn, ImageContainer<float>& imageOut, ImageContainer<float> kernel, int numIterations /*= 1*/, int device /*= -1*/)
 {
	 cVarFilter(imageIn, imageOut, kernel, numIterations, device);
 }
 
 void varFilter(const ImageContainer<double> imageIn, ImageContainer<double>& imageOut, ImageContainer<float> kernel, int numIterations /*= 1*/, int device /*= -1*/)
 {
	 cVarFilter(imageIn, imageOut, kernel, numIterations, device);
 }


 void wienerFilter(ImageContainer<bool> imageIn, ImageContainer<bool>& imageOut, ImageContainer<float> kernel, double noiseVariance, int device /*= -1*/)
 {						  
	 cWienerFilter(imageIn, imageOut, kernel, noiseVariance, device);
 }		  
	  
 void wienerFilter(ImageContainer<char> imageIn, ImageContainer<char>& imageOut, ImageContainer<float> kernel, double noiseVariance, int device /*= -1*/)
 {						  
	 cWienerFilter(imageIn, imageOut, kernel, noiseVariance, device);
 }

 void wienerFilter(ImageContainer<unsigned char> imageIn, ImageContainer<unsigned char>& imageOut, ImageContainer<float> kernel, double noiseVariance, int device /*= -1*/)
 {
	 cWienerFilter(imageIn, imageOut, kernel, noiseVariance, device);
 }

 void wienerFilter(ImageContainer<short> imageIn, ImageContainer<short>& imageOut, ImageContainer<float> kernel, double noiseVariance, int device /*= -1*/)
 {
	 cWienerFilter(imageIn, imageOut, kernel, noiseVariance, device);
 }

 void wienerFilter(ImageContainer<unsigned short> imageIn, ImageContainer<unsigned short>& imageOut, ImageContainer<float> kernel, double noiseVariance, int device /*= -1*/)
 {
	 cWienerFilter(imageIn, imageOut, kernel, noiseVariance, device);
 }

 void wienerFilter(ImageContainer<int> imageIn, ImageContainer<int>& imageOut, ImageContainer<float> kernel, double noiseVariance, int device /*= -1*/)
 {
	 cWienerFilter(imageIn, imageOut, kernel, noiseVariance, device);
 }

 void wienerFilter(ImageContainer<unsigned int> imageIn, ImageContainer<unsigned int>& imageOut, ImageContainer<float> kernel, double noiseVariance, int device /*= -1*/)
 {
	 cWienerFilter(imageIn, imageOut, kernel, noiseVariance, device);
 }

 void wienerFilter(ImageContainer<float> imageIn, ImageContainer<float>& imageOut, ImageContainer<float> kernel, double noiseVariance, int device /*= -1*/)
 {
	 cWienerFilter(imageIn, imageOut, kernel, noiseVariance, device);
 }

 void wienerFilter(ImageContainer<double> imageIn, ImageContainer<double>& imageOut, ImageContainer<float> kernel, double noiseVariance, int device /*= -1*/)
 {
	 cWienerFilter(imageIn, imageOut, kernel, noiseVariance, device);
 }
