#include "MexCommand.h"
#include "CWrappers.h"
#include "Vec.h"

void MexLinearUnmixing::execute(int nlhs, mxArray* plhs[], int nrhs, const mxArray* prhs[]) const
{
	int device = 0;

	if (nrhs > 3)
		device = mat_to_c((int)mxGetScalar(prhs[3]));

	size_t numImDims = mxGetNumberOfDimensions(prhs[0]);
	const mwSize* IM_DIMS = mxGetDimensions(prhs[0]);
	size_t numMatrixDims = mxGetNumberOfDimensions(prhs[1]);
	const mwSize* MATRIX_DIMS = mxGetDimensions(prhs[1]);
	size_t numImages = IM_DIMS[numImDims - 1];

	Vec<size_t> imageDims, umixingDims;

	double* unmixing;
	setupImagePointers(prhs[1], &unmixing, &umixingDims);
	float* unmix = new float[umixingDims.product()];
	for (int i = 0; i < umixingDims.product(); ++i)
		unmix[i] = (float)unmixing[i];

	if (mxIsUint8(prhs[0]))
	{
		unsigned char* imageIn, *imageOut;
		setupImagePointers(prhs[0], &imageIn, &imageDims, &plhs[0], &imageOut);

		linearUnmixing(imageIn, imageDims, numImages, unmix, umixingDims, &imageOut, device);
	}
	else if (mxIsUint16(prhs[0]))
	{
		unsigned short* imageIn, *imageOut;
		setupImagePointers(prhs[0], &imageIn, &imageDims, &plhs[0], &imageOut);

		linearUnmixing(imageIn, imageDims, numImages, unmix, umixingDims, &imageOut, device);
	}
	else if (mxIsInt16(prhs[0]))
	{
		short* imageIn, *imageOut;
		setupImagePointers(prhs[0], &imageIn, &imageDims, &plhs[0], &imageOut);

		linearUnmixing(imageIn, imageDims, numImages, unmix, umixingDims, &imageOut, device);
	}
	else if (mxIsUint32(prhs[0]))
	{
		unsigned int* imageIn, *imageOut;
		setupImagePointers(prhs[0], &imageIn, &imageDims, &plhs[0], &imageOut);

		linearUnmixing(imageIn, imageDims, numImages, unmix, umixingDims, &imageOut, device);
	}
	else if (mxIsInt32(prhs[0]))
	{
		int* imageIn, *imageOut;
		setupImagePointers(prhs[0], &imageIn, &imageDims, &plhs[0], &imageOut);

		linearUnmixing(imageIn, imageDims, numImages, unmix, umixingDims, &imageOut, device);
	}
	else if (mxIsSingle(prhs[0]))
	{
		float* imageIn, *imageOut;
		setupImagePointers(prhs[0], &imageIn, &imageDims, &plhs[0], &imageOut);

		linearUnmixing(imageIn, imageDims, numImages, unmix, umixingDims, &imageOut, device);
	}
	else if (mxIsDouble(prhs[0]))
	{
		double* imageIn, *imageOut;
		setupImagePointers(prhs[0], &imageIn, &imageDims, &plhs[0], &imageOut);

		linearUnmixing(imageIn, imageDims, numImages, unmix, umixingDims, &imageOut, device);
	}
	else
	{
		delete[] unmix;
		mexErrMsgTxt("Image type not supported!");
	}

	delete[] unmix;
}

std::string MexLinearUnmixing::check(int nlhs, mxArray* plhs[], int nrhs, const mxArray* prhs[]) const
{
	if (nrhs < 2 || nrhs>3)
		return "Incorrect number of inputs!";

	if (nlhs != 1)
		return "Requires one output!";

	size_t numDims1 = int(mxGetNumberOfDimensions(prhs[0]));
	const mwSize* DIMS1 = mxGetDimensions(prhs[0]);
	size_t numDims2 = int(mxGetNumberOfDimensions(prhs[1]));
	const mwSize* DIMS2 = mxGetDimensions(prhs[1]);

	size_t numImages = DIMS1[numDims1 - 1];

	if (numDims1 > 4)
		return "Input images can be at most 3-D!";
	if (numDims2 != 2)
		return "Unmixing matrix should be 2-D!";
	if (DIMS2[0] != DIMS2[1] || numImages != DIMS2[0])
		return "Unmixing matrix needs to be NxN, where N is the number of images to unmix!";
	if (!mxIsDouble(prhs[1]))
		return "Unmixing matrix needs to be a doubles!";

	return "";
}

void MexLinearUnmixing::usage(std::vector<std::string>& outArgs,std::vector<std::string>& inArgs) const
{
	inArgs.push_back("mixedImages");
	inArgs.push_back("unmixMatrix");
	inArgs.push_back("device");

	outArgs.push_back("imageOut");
}

void MexLinearUnmixing::help(std::vector<std::string>& helpLines) const
{
//\	std::string msg = "\tLinear Unmixing takes an image that is one dimension larger than the\n";
//\	msg += "\tinput images. This can be done with the cat function: cat(ndims(im)+1,im,im2,..).\n";
//\	msg += "\tThe output image will have the same dimension as this input image and contains the\n";
//\	msg += "\tunmixed images as single precision floating point values.";
//\	msg += "\n";
//\	return msg;
}
