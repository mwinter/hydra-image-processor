#include "Process.h"
#include "CudaImageBuffer.cuh"

void addConstant(const MexImagePixelType* image,  MexImagePixelType* imageOut, Vec<unsigned int> imageDims, double additive)
{
	CudaImageBuffer<unsigned char> cudaBuffer(imageDims,true);
	cudaBuffer.loadImage(image);

	cudaBuffer.addConstant(additive);

	cudaBuffer.retrieveImage(imageOut);
}

void addImageWith(const MexImagePixelType* image1, const MexImagePixelType* image2, MexImagePixelType* imageOut,
								Vec<unsigned int> imageDims, double factor)
{
	CudaImageBuffer<unsigned char> cudaBuffer1(imageDims,true);
	CudaImageBuffer<unsigned char> cudaBuffer2(imageDims,true);
	cudaBuffer1.loadImage(image1);
	cudaBuffer2.loadImage(image2);

	cudaBuffer1.addImageWith(&cudaBuffer2,factor);

	unsigned char* outImage = cudaBuffer1.retrieveImage();
}

void applyPolyTransformation( const MexImagePixelType* image, MexImagePixelType* imageOut, Vec<unsigned int> imageDims, double a, double b, double c, MexImagePixelType minValue, MexImagePixelType maxValue )
{
	CudaImageBuffer<unsigned char> cudaBuffer(imageDims,true);
	cudaBuffer.loadImage(image);

	cudaBuffer.applyPolyTransformation(a,b,c,minValue,maxValue);

	cudaBuffer.retrieveImage(imageOut);
}

void calculateMinMax(const MexImagePixelType* image, Vec<unsigned int> imageDims, double& minValue, double& maxValue)
{
	CudaImageBuffer<unsigned char> cudaBuffer(imageDims,true);
	cudaBuffer.loadImage(image);

	cudaBuffer.calculateMinMax(minValue,maxValue);
}

void contrastEnhancement(const MexImagePixelType* image, MexImagePixelType* imageOut, Vec<unsigned int> imageDims, Vec<float> sigmas,
									   Vec<unsigned int> medianNeighborhood)
{
	CudaImageBuffer<unsigned char> cudaBuffer(imageDims,true);
	cudaBuffer.loadImage(image);

	cudaBuffer.contrastEnhancement(sigmas,medianNeighborhood);

	cudaBuffer.retrieveImage(imageOut);
}

void gaussianFilter( const MexImagePixelType* image, MexImagePixelType* imageOut, Vec<unsigned int> imageDims, Vec<float> sigmas )
{
	CudaImageBuffer<unsigned char> cudaBuffer(imageDims,true);
	cudaBuffer.loadImage(image);

	cudaBuffer.gaussianFilter(sigmas);

	cudaBuffer.retrieveImage(imageOut);
}

void maxFilter( const MexImagePixelType* image, MexImagePixelType* imageOut, Vec<unsigned int> imageDims, Vec<unsigned int> neighborhood )
{
	CudaImageBuffer<unsigned char> cudaBuffer(imageDims,true);
	cudaBuffer.loadImage(image);

	cudaBuffer.maxFilter(neighborhood);

	cudaBuffer.retrieveImage(imageOut);
}

void maximumIntensityProjection( const MexImagePixelType* image, MexImagePixelType* imageOut, Vec<unsigned int> imageDims )
{
	CudaImageBuffer<unsigned char> cudaBuffer(imageDims,true);
	cudaBuffer.loadImage(image);

	cudaBuffer.maximumIntensityProjection();

	cudaBuffer.retrieveImage(imageOut);
}

void meanFilter( const MexImagePixelType* image, MexImagePixelType* imageOut, Vec<unsigned int> imageDims, Vec<unsigned int> neighborhood )
{
	CudaImageBuffer<unsigned char> cudaBuffer(imageDims,true);
	cudaBuffer.loadImage(image);

	cudaBuffer.meanFilter(neighborhood);

	cudaBuffer.retrieveImage(imageOut);
}

void medianFilter( const MexImagePixelType* image, MexImagePixelType* imageOut, Vec<unsigned int> imageDims, Vec<unsigned int> neighborhood )
{
	CudaImageBuffer<unsigned char> cudaBuffer(imageDims,true);
	cudaBuffer.loadImage(image);

	cudaBuffer.medianFilter(neighborhood);

	cudaBuffer.retrieveImage(imageOut);
}

void minFilter( const MexImagePixelType* image, MexImagePixelType* imageOut, Vec<unsigned int> imageDims, Vec<unsigned int> neighborhood )
{
	CudaImageBuffer<unsigned char> cudaBuffer(imageDims,true);
	cudaBuffer.loadImage(image);

	cudaBuffer.minFilter(neighborhood);

	cudaBuffer.retrieveImage(imageOut);
}

void multiplyImage( const MexImagePixelType* image, MexImagePixelType* imageOut, Vec<unsigned int> imageDims, double factor )
{
	CudaImageBuffer<unsigned char> cudaBuffer(imageDims,true);
	cudaBuffer.loadImage(image);

	cudaBuffer.multiplyImage(factor);

	cudaBuffer.retrieveImage(imageOut);
}

void multiplyImageWith( const MexImagePixelType* image1, const MexImagePixelType* image2, MexImagePixelType* imageOut, Vec<unsigned int> imageDims )
{
	CudaImageBuffer<unsigned char> cudaBuffer1(imageDims,true);
	CudaImageBuffer<unsigned char> cudaBuffer2(imageDims,true);
	cudaBuffer1.loadImage(image1);
	cudaBuffer2.loadImage(image2);

	cudaBuffer1.multiplyImageWith(&cudaBuffer2);

	unsigned char* outImage = cudaBuffer1.retrieveImage();
}

void imagePow( const MexImagePixelType* image, MexImagePixelType* imageOut, Vec<unsigned int> imageDims, int p )
{
	CudaImageBuffer<unsigned char> cudaBuffer(imageDims,true);
	cudaBuffer.loadImage(image);

	cudaBuffer.imagePow(p);

	cudaBuffer.retrieveImage(imageOut);
}

double sumArray(const MexImagePixelType* image, Vec<unsigned int> imageDims)
{
	CudaImageBuffer<unsigned char> cudaBuffer(imageDims,true);
	cudaBuffer.loadImage(image);

	double sum;
	cudaBuffer.sumArray(sum);
	return sum;
}

MexImagePixelType* reduceImage( const MexImagePixelType* image, Vec<unsigned int>& imageDims, Vec<double> reductions )
{
	CudaImageBuffer<unsigned char> cudaBuffer(imageDims,true);
	cudaBuffer.loadImage(image);

	cudaBuffer.reduceImage(reductions);

	imageDims = cudaBuffer.getDimension();
	return cudaBuffer.retrieveImage();
}

void thresholdFilter( const MexImagePixelType* image, MexImagePixelType* imageOut, Vec<unsigned int> imageDims, double threshold )
{
	CudaImageBuffer<unsigned char> cudaBuffer(imageDims,true);
	cudaBuffer.loadImage(image);

	cudaBuffer.thresholdFilter(threshold);

	cudaBuffer.retrieveImage(imageOut);
}

void unmix( const MexImagePixelType* image1, const MexImagePixelType* image2, MexImagePixelType* imageOut, Vec<unsigned int> imageDims, Vec<unsigned int> neighborhood )
{
	CudaImageBuffer<unsigned char> cudaBuffer1(imageDims,true);
	CudaImageBuffer<unsigned char> cudaBuffer2(imageDims,true);
	cudaBuffer1.loadImage(image1);
	cudaBuffer2.loadImage(image2);

	cudaBuffer1.unmix(&cudaBuffer2,neighborhood);

	cudaBuffer1.retrieveImage(imageOut);
}