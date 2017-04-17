% MinFilterEllipsoid - imageOut = MinFilterEllipsoid(imageIn,radius,device) 
function imageOut = MinFilterEllipsoid(imageIn,radius)
    % check for Cuda capable devices
    [devCount,m] = ImProc.Cuda.DeviceCount();
    n = length(devCount);
    
    % if there are devices find the availble one and grab the mutex
    if (n>0)
       [~,I] = max([m.available]);
       try
            imageOut = ImProc.Cuda.MinFilterEllipsoid(imageIn,radius,I);
        catch errMsg
        	throw(errMsg);
        end
        
    else
        imageOut = lclMinFilterEllipsoid(imageIn,radius);
    end
end

function imageOut = lclMinFilterEllipsoid(imageIn,radius)

end

