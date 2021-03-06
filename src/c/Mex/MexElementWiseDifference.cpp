#include "MexCommand.h"
#include "../Cuda/Vec.h"
#include "../Cuda/CWrappers.h"
#include "../Cuda/ImageDimensions.cuh"
#include "../Cuda/ImageContainer.h"
#include "MexKernel.h"

void MexElementWiseDifference::execute(int nlhs, mxArray* plhs[], int nrhs, const mxArray* prhs[]) const
{
	int device = -1;

	if (!mxIsEmpty(prhs[2]))
		device = mat_to_c((int)mxGetScalar(prhs[3]));

	ImageDimensions imageDims;
	if (mxIsLogical(prhs[0]))
	{
		bool* image1InPtr, *image2InPtr, *imageOutPtr;
		ImageDimensions image1Dims;
		Script::setupInputPointers(prhs[0], image1Dims, &image1InPtr);
		ImageDimensions image2Dims;
		Script::setupInputPointers(prhs[1], image2Dims, &image2InPtr);
		imageDims = ImageDimensions(Vec<std::size_t>::max(image1Dims.dims, image2Dims.dims), MAX(image1Dims.chan, image2Dims.chan), MAX(image1Dims.frame, image2Dims.frame));
		Script::setupOutputPointers(&plhs[0], imageDims, &imageOutPtr);

		ImageContainer<bool> image1In(image1InPtr, image1Dims);
		ImageContainer<bool> image2In(image2InPtr, image2Dims);
		ImageContainer<bool> imageOut(imageOutPtr, imageDims);

		elementWiseDifference(image1In, image2In, imageOut, device);

	}
	else if (mxIsUint8(prhs[0]))
	{
		unsigned char* image1InPtr, *image2InPtr, *imageOutPtr;
		ImageDimensions image1Dims;
		Script::setupInputPointers(prhs[0], image1Dims, &image1InPtr);
		ImageDimensions image2Dims;
		Script::setupInputPointers(prhs[1], image2Dims, &image2InPtr);
		imageDims = ImageDimensions(Vec<std::size_t>::max(image1Dims.dims, image2Dims.dims), MAX(image1Dims.chan, image2Dims.chan), MAX(image1Dims.frame, image2Dims.frame));
		Script::setupOutputPointers(&plhs[0], imageDims, &imageOutPtr);

		ImageContainer<unsigned char> image1In(image1InPtr, image1Dims);
		ImageContainer<unsigned char> image2In(image2InPtr, image2Dims);
		ImageContainer<unsigned char> imageOut(imageOutPtr, imageDims);

		elementWiseDifference(image1In, image2In, imageOut, device);
	}
	else if (mxIsUint16(prhs[0]))
	{
		unsigned short* image1InPtr, *image2InPtr, *imageOutPtr;
		ImageDimensions image1Dims;
		Script::setupInputPointers(prhs[0], image1Dims, &image1InPtr);
		ImageDimensions image2Dims;
		Script::setupInputPointers(prhs[1], image2Dims, &image2InPtr);
		imageDims = ImageDimensions(Vec<std::size_t>::max(image1Dims.dims, image2Dims.dims), MAX(image1Dims.chan, image2Dims.chan), MAX(image1Dims.frame, image2Dims.frame));
		Script::setupOutputPointers(&plhs[0], imageDims, &imageOutPtr);

		ImageContainer<unsigned short> image1In(image1InPtr, image1Dims);
		ImageContainer<unsigned short> image2In(image2InPtr, image2Dims);
		ImageContainer<unsigned short> imageOut(imageOutPtr, imageDims);

		elementWiseDifference(image1In, image2In, imageOut, device);
	}
	else if (mxIsInt16(prhs[0]))
	{
		short* image1InPtr, *image2InPtr, *imageOutPtr;
		ImageDimensions image1Dims;
		Script::setupInputPointers(prhs[0], image1Dims, &image1InPtr);
		ImageDimensions image2Dims;
		Script::setupInputPointers(prhs[1], image2Dims, &image2InPtr);
		imageDims = ImageDimensions(Vec<std::size_t>::max(image1Dims.dims, image2Dims.dims), MAX(image1Dims.chan, image2Dims.chan), MAX(image1Dims.frame, image2Dims.frame));
		Script::setupOutputPointers(&plhs[0], imageDims, &imageOutPtr);

		ImageContainer<short> image1In(image1InPtr, image1Dims);
		ImageContainer<short> image2In(image2InPtr, image2Dims);
		ImageContainer<short> imageOut(imageOutPtr, imageDims);

		elementWiseDifference(image1In, image2In, imageOut, device);
	}
	else if (mxIsUint32(prhs[0]))
	{
		unsigned int* image1InPtr, *image2InPtr, *imageOutPtr;
		ImageDimensions image1Dims;
		Script::setupInputPointers(prhs[0], image1Dims, &image1InPtr);
		ImageDimensions image2Dims;
		Script::setupInputPointers(prhs[1], image2Dims, &image2InPtr);
		imageDims = ImageDimensions(Vec<std::size_t>::max(image1Dims.dims, image2Dims.dims), MAX(image1Dims.chan, image2Dims.chan), MAX(image1Dims.frame, image2Dims.frame));
		Script::setupOutputPointers(&plhs[0], imageDims, &imageOutPtr);

		ImageContainer<unsigned int> image1In(image1InPtr, image1Dims);
		ImageContainer<unsigned int> image2In(image2InPtr, image2Dims);
		ImageContainer<unsigned int> imageOut(imageOutPtr, imageDims);

		elementWiseDifference(image1In, image2In, imageOut, device);
	}
	else if (mxIsInt32(prhs[0]))
	{
		int* image1InPtr, *image2InPtr, *imageOutPtr;
		ImageDimensions image1Dims;
		Script::setupInputPointers(prhs[0], image1Dims, &image1InPtr);
		ImageDimensions image2Dims;
		Script::setupInputPointers(prhs[1], image2Dims, &image2InPtr);
		imageDims = ImageDimensions(Vec<std::size_t>::max(image1Dims.dims, image2Dims.dims), MAX(image1Dims.chan, image2Dims.chan), MAX(image1Dims.frame, image2Dims.frame));
		Script::setupOutputPointers(&plhs[0], imageDims, &imageOutPtr);

		ImageContainer<int> image1In(image1InPtr, image1Dims);
		ImageContainer<int> image2In(image2InPtr, image2Dims);
		ImageContainer<int> imageOut(imageOutPtr, imageDims);

		elementWiseDifference(image1In, image2In, imageOut, device);
	}
	else if (mxIsSingle(prhs[0]))
	{
		float* image1InPtr, *image2InPtr, *imageOutPtr;
		ImageDimensions image1Dims;
		Script::setupInputPointers(prhs[0], image1Dims, &image1InPtr);
		ImageDimensions image2Dims;
		Script::setupInputPointers(prhs[1], image2Dims, &image2InPtr);
		imageDims = ImageDimensions(Vec<std::size_t>::max(image1Dims.dims, image2Dims.dims), MAX(image1Dims.chan, image2Dims.chan), MAX(image1Dims.frame, image2Dims.frame));
		Script::setupOutputPointers(&plhs[0], imageDims, &imageOutPtr);

		ImageContainer<float> image1In(image1InPtr, image1Dims);
		ImageContainer<float> image2In(image2InPtr, image2Dims);
		ImageContainer<float> imageOut(imageOutPtr, imageDims);

		elementWiseDifference(image1In, image2In, imageOut, device);
	}
	else if (mxIsDouble(prhs[0]))
	{
		double* image1InPtr, *image2InPtr, *imageOutPtr;
		ImageDimensions image1Dims;
		Script::setupInputPointers(prhs[0], image1Dims, &image1InPtr);
		ImageDimensions image2Dims;
		Script::setupInputPointers(prhs[1], image2Dims, &image2InPtr);
		imageDims = ImageDimensions(Vec<std::size_t>::max(image1Dims.dims, image2Dims.dims), MAX(image1Dims.chan, image2Dims.chan), MAX(image1Dims.frame, image2Dims.frame));
		Script::setupOutputPointers(&plhs[0], imageDims, &imageOutPtr);

		ImageContainer<double> image1In(image1InPtr, image1Dims);
		ImageContainer<double> image2In(image2InPtr, image2Dims);
		ImageContainer<double> imageOut(imageOutPtr, imageDims);

		elementWiseDifference(image1In, image2In, imageOut, device);
	}
	else
	{
		mexErrMsgTxt("Image type not supported!");
	}
}

std::string MexElementWiseDifference::check(int nlhs, mxArray* plhs[], int nrhs, const mxArray* prhs[]) const
{
	if (nrhs != 3)
		return "Incorrect number of inputs!";

	if (nlhs != 1)
		return "Requires one output!";

	std::size_t imgNumDims = mxGetNumberOfDimensions(prhs[0]);
	if (imgNumDims > 5)
		return "Image1 can have a maximum of five dimensions!";

	imgNumDims = mxGetNumberOfDimensions(prhs[1]);
	if (imgNumDims > 5)
		return "Image2 can have a maximum of five dimensions!";

	return "";
}

void MexElementWiseDifference::usage(std::vector<std::string>& outArgs, std::vector<std::string>& inArgs) const
{
	inArgs.push_back("array1In");
	inArgs.push_back("array2In");
	inArgs.push_back("[device]");
	outArgs.push_back("arrayOut");
}

void MexElementWiseDifference::help(std::vector<std::string>& helpLines) const
{
	helpLines.push_back("This subtracts the second array from the first, element by element (A-B).");

	helpLines.push_back("\timage1In = This is a one to five dimensional array. The first three dimensions are treated as spatial.");
	helpLines.push_back("\t\tThe spatial dimensions will have the kernel applied. The last two dimensions will determine");
	helpLines.push_back("\t\thow to stride or jump to the next spatial block.");
	helpLines.push_back("");

	helpLines.push_back("\timage2In = This is a one to five dimensional array. The first three dimensions are treated as spatial.");
	helpLines.push_back("\t\tThe spatial dimensions will have the kernel applied. The last two dimensions will determine");
	helpLines.push_back("\t\thow to stride or jump to the next spatial block.");
	helpLines.push_back("");

	helpLines.push_back("\tdevice (optional) = Use this if you have multiple devices and want to select one explicitly.");
	helpLines.push_back("\t\tSetting this to [] allows the algorithm to either pick the best device and/or will try to split");
	helpLines.push_back("\t\tthe data across multiple devices.");
	helpLines.push_back("");

	helpLines.push_back("\timageOut = This will be an array of the same type and shape as the input array.");
}
