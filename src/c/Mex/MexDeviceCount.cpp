#include "MexCommand.h"
#include "../Cuda/CWrappers.h"

void MexDeviceCount::execute(int nlhs, mxArray* plhs[], int nrhs, const mxArray* prhs[]) const
{
	if(nlhs==1)
	{
		plhs[0] = mxCreateDoubleScalar(deviceCount());
	}else if (nlhs>1)
	{
		std::size_t* memStats;
		mwSize numDevices = (mwSize)memoryStats(&memStats);
		plhs[0] = mxCreateDoubleScalar(numDevices);
		const char* fieldNames[] = {"total","available"};
		mwSize dims[2] ={1,numDevices};
		plhs[1] = mxCreateStructArray(2,dims,2,fieldNames);

		int total_field = mxGetFieldNumber(plhs[1],"total");
		int avail_field = mxGetFieldNumber(plhs[1],"available");

		for(int i=0; i<numDevices; ++i)
		{
			mxSetFieldByNumber(plhs[1],i,total_field,mxCreateDoubleScalar(double(memStats[i*2])));
			mxSetFieldByNumber(plhs[1],i,avail_field,mxCreateDoubleScalar(double(memStats[i*2+1])));
		}
	}
}

std::string MexDeviceCount::check(int nlhs, mxArray* plhs[], int nrhs, const mxArray* prhs[]) const
{
	if (nlhs < 1)
		return "Requires one output!";

	return "";
}

void MexDeviceCount::usage(std::vector<std::string>& outArgs,std::vector<std::string>& inArgs) const
{
	outArgs.push_back("numCudaDevices");
	outArgs.push_back("memoryStats");
}

void MexDeviceCount::help(std::vector<std::string>& helpLines) const
{
	helpLines.push_back("This will return the number of Cuda devices available, and their memory.");

	helpLines.push_back("\tNumCudaDevices -- this is the number of Cuda devices available.");
	helpLines.push_back("\tMemoryStats -- this is an array of structures where each entry corresponds to a Cuda device.");
	helpLines.push_back("\t\tThe memory structure contains the total memory on the device and the memory available for a Cuda call.");
}