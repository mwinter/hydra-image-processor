% Variance - variance = Variance(imageIn,device) This will return the variance of an image.
function variance = Variance(imageIn,device)
    [variance] = Cuda.Mex('Variance',imageIn,device);
end
