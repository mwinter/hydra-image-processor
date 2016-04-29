% GaussianFilter - Smooths image using a Gaussian kernel.
%    imageOut = Cuda.GaussianFilter(imageIn,sigma,device)
%    	ImageIn -- can be an image up to three dimensions and of type (uint8,int8,uint16,int16,uint32,int32,single,double).
%    	Sigma -- these values will create a n-dimensional Gaussian kernel to get a smoothed image that will be subtracted of the original.
%    	Device -- this is an optional parameter that indicates which Cuda capable device to use.
%    	ImageOut -- will have the same dimensions and type as imageIn. Values are clamped to the range of the image space.
function imageOut = GaussianFilter(imageIn,sigma,device)
    [imageOut] = Cuda.Mex('GaussianFilter',imageIn,sigma,device);
end