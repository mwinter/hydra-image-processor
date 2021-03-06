#include "KernelGenerators.h"

#include <float.h>
#include <functional>


float* createGaussianKernel(Vec<double> sigmas, Vec<std::size_t>& dimsOut)
{
	dimsOut.x = (std::size_t)MAX(1.0f, (5 * sigmas.x));
	dimsOut.y = (std::size_t)MAX(1.0f, (5 * sigmas.y));
	dimsOut.z = (std::size_t)MAX(1.0f, (5 * sigmas.z));

	dimsOut.x = (dimsOut.x % 2 == 0) ? (dimsOut.x + 1) : (dimsOut.x);
	dimsOut.y = (dimsOut.y % 2 == 0) ? (dimsOut.y + 1) : (dimsOut.y);
	dimsOut.z = (dimsOut.z % 2 == 0) ? (dimsOut.z + 1) : (dimsOut.z);

	Vec<double> mid = Vec<double>(dimsOut) / 2.0 - 0.5;

	float* kernelOut = new float[dimsOut.sum()];
	for (int i = 0; i < 3; ++i)
	{
		std::size_t startOffset = 0;
		if (i > 0)
			startOffset += dimsOut.x;

		if (i > 1)
			startOffset += dimsOut.y;

		double curSigma = sigmas.e[i];

		if (curSigma == 0)
		{
			kernelOut[startOffset] = 1.0f;
			continue;
		}

		double total = 0.0;
		for (int j = 0; j < dimsOut.e[i]; ++j)
		{
			double expVal = -floor(SQR(mid.e[i] - (double)j));
			expVal /= (2 * SQR(sigmas.e[i]));
			double kernVal = exp(expVal);
			kernelOut[startOffset + j] = kernVal;
			total += kernVal;
		}

		float fTotal = (float)total;
		for (int j = 0; j < dimsOut.e[i]; ++j)
			kernelOut[startOffset + j] /= fTotal;

	}

	return kernelOut;
}
