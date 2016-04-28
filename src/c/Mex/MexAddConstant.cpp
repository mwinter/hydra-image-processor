#include "MexCommand.h"
#include "CWrappers.h"
#include "Vec.h"

void MexAddConstant::execute(int nlhs, mxArray* plhs[], int nrhs, const mxArray* prhs[]) const
{
	int device = 0;

	if (nrhs>2)
		device = mat_to_c((int)mxGetScalar(prhs[2]));

	double additive = mxGetScalar(prhs[1]);

	Vec<size_t> imageDims;
	if (mxIsUint8(prhs[0]))
	{
		unsigned char* imageIn,* imageOut;
		setupImagePointers(prhs[0],&imageIn,&imageDims,&plhs[0],&imageOut);

		addConstant(imageIn,imageDims,additive,&imageOut,device);
	}
	else if (mxIsUint16(prhs[0]))
	{
		unsigned short* imageIn,* imageOut;
		setupImagePointers(prhs[0],&imageIn,&imageDims,&plhs[0],&imageOut);

		addConstant(imageIn,imageDims,additive,&imageOut,device);
	}
	else if (mxIsInt16(prhs[0]))
	{
		short* imageIn,* imageOut;
		setupImagePointers(prhs[0],&imageIn,&imageDims,&plhs[0],&imageOut);

		addConstant(imageIn,imageDims,additive,&imageOut,device);
	}
	else if (mxIsUint32(prhs[0]))
	{
		unsigned int* imageIn,* imageOut;
		setupImagePointers(prhs[0],&imageIn,&imageDims,&plhs[0],&imageOut);

		addConstant(imageIn,imageDims,additive,&imageOut,device);
	}
	else if (mxIsInt32(prhs[0]))
	{
		int* imageIn,* imageOut;
		setupImagePointers(prhs[0],&imageIn,&imageDims,&plhs[0],&imageOut);

		addConstant(imageIn,imageDims,additive,&imageOut,device);
	}
	else if (mxIsSingle(prhs[0]))
	{
		float* imageIn,* imageOut;
		setupImagePointers(prhs[0],&imageIn,&imageDims,&plhs[0],&imageOut);

		addConstant(imageIn,imageDims,additive,&imageOut,device);
	}
	else if (mxIsDouble(prhs[0]))
	{
		double* imageIn,* imageOut;
		setupImagePointers(prhs[0],&imageIn,&imageDims,&plhs[0],&imageOut);

		addConstant(imageIn,imageDims,additive,&imageOut,device);
	}
	else
	{
		mexErrMsgTxt("Image type not supported!");
	}
}

std::string MexAddConstant::check(int nlhs, mxArray* plhs[], int nrhs, const mxArray* prhs[]) const
{
	if (nrhs<2 || nrhs>3)
		return "Incorrect number of inputs!";

	if (nlhs!=1)
		return "Requires one output!";

	size_t numDims = mxGetNumberOfDimensions(prhs[0]);
	if (numDims>3)
		return "Image can have a maximum of three dimensions!";

	if (!mxIsDouble(prhs[1]))
		return "Additive needs to be a single double!";

	return "";
}

void MexAddConstant::usage(std::vector<std::string>& outArgs,std::vector<std::string>& inArgs) const
{
	inArgs.push_back("imageIn");
	inArgs.push_back("additive");
	inArgs.push_back("device");
	
	outArgs.push_back("imageOut");
}

void MexAddConstant::help(std::vector<std::string>& helpLines) const
{
	helpLines.push_back("This will add a constant value at every voxel location.");

	helpLines.push_back("\tImageIn -- can be an image up to three dimensions and of type (uint8,int8,uint16,int16,uint32,int32,single,double).");
	helpLines.push_back("\tAdditive -- must be a double and will be floored if input is an integer type.");
	helpLines.push_back("\tDevice -- this is an optional parameter that indicates which Cuda capable device to use.");

	helpLines.push_back("\tImageOut -- will have the same dimensions and type as imageIn. Values are clamped to the range of the image space.");
}