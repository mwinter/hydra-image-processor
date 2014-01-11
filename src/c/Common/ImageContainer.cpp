#include "ImageContainer.h"

ImageContainer::ImageContainer(size_t width, size_t height, size_t depth, bool isColumnMajor/*=false*/)
{
	defaults();
	imageDims.x = width;
	imageDims.y = height;
	imageDims.z = depth;

	columnMajor = isColumnMajor;

	image = new HostPixelType[imageDims.product()];
}

ImageContainer::ImageContainer(Vec<size_t> dimsIn, bool isColumnMajor/*=false*/)
{
	defaults();
	imageDims = dimsIn;

	columnMajor = isColumnMajor;

	image = new HostPixelType[imageDims.product()];
}

ImageContainer::ImageContainer(HostPixelType* imageIn, Vec<size_t> dims, bool isColumnMajor/*=false*/, bool preallocatedMemory/*=false*/)
{
	defaults();

	if (preallocatedMemory)
	{
		image = imageIn;

		columnMajor = isColumnMajor;
		preallocated = true;
		imageDims = dims;
	}
	else
	{
		loadImage(imageIn,dims,isColumnMajor);
	}
}

void ImageContainer::copy(const ImageContainer& im)
{
	clear();

	image = new HostPixelType[imageDims.product()];
	memcpy((void*)image,(void*)(im.getConstMemoryPointer()),sizeof(HostPixelType)*imageDims.product());
}

void ImageContainer::clear()
{
	if (image!=NULL && !preallocated)
	{
		delete[] image;
		image = NULL;
	}

	defaults();
}

HostPixelType ImageContainer::getPixelValue(size_t x, size_t y, size_t z) const
{
	return getPixelValue(Vec<size_t>(x,y,z));
}

HostPixelType ImageContainer::getPixelValue(Vec<size_t> coordinate) const
{
	return image[imageDims.linearAddressAt(coordinate,columnMajor)];
}

void ImageContainer::setPixelValue(size_t x, size_t y, size_t z, unsigned char val)
{
	setPixelValue(Vec<size_t>(x,y,z),val);
}

void ImageContainer::setPixelValue(Vec<size_t> coordinate, unsigned char val)
{
	image[imageDims.linearAddressAt(coordinate,columnMajor)] = val;
}

const HostPixelType* ImageContainer::getConstROIData (size_t minX, size_t sizeX, size_t minY,
													  size_t sizeY, size_t minZ, size_t sizeZ) const
{
	return getConstROIData(Vec<size_t>(minX,minY,minZ), Vec<size_t>(sizeX,sizeY,sizeZ));
}

const HostPixelType* ImageContainer::getConstROIData(Vec<size_t> startIndex, Vec<size_t> size) const
{
	HostPixelType* imageOut = new HostPixelType[size.product()];

	size_t i=0;
	Vec<size_t> curIdx(startIndex);
	Vec<size_t> outIdx(0,0,0);
	for (curIdx.z=startIndex.z, outIdx.z=0; curIdx.z-startIndex.z<size.z && curIdx.z<imageDims.z; ++curIdx.z, ++outIdx.z)
	{
		if (!columnMajor)
		{
			for (curIdx.y=startIndex.y, outIdx.y=0; curIdx.y-startIndex.y<size.y && curIdx.y<imageDims.y; ++curIdx.y, ++outIdx.y)
			{
				for (curIdx.x=startIndex.x, outIdx.x=0; curIdx.x-startIndex.x<size.x && curIdx.x<imageDims.x; ++curIdx.x, ++outIdx.x)		
				{
					imageOut[size.linearAddressAt(outIdx)] = getPixelValue(curIdx);
				}
			}
		}
		else
		{
			for (curIdx.x=startIndex.x, outIdx.x=0; curIdx.x-startIndex.x<size.x && curIdx.x<imageDims.x; ++curIdx.x, ++outIdx.x)
			{
				for (curIdx.y=startIndex.y, outIdx.y=0; curIdx.y-startIndex.y<size.y && curIdx.y<imageDims.y; ++curIdx.y, ++outIdx.y)
				{
					imageOut[size.linearAddressAt(outIdx)] = getPixelValue(curIdx);
				}
			}
		}
	}

	return imageOut;
}

void ImageContainer::loadImage( const HostPixelType* imageIn, Vec<size_t> dims, bool isColumnMajor/*=false*/ )
{
	if (dims!=imageDims)
	{
		if (image!=NULL)
		{
			delete[] image;
		}
		image = new HostPixelType[dims.product()];
		imageDims = dims;
	}

	memcpy(image,imageIn,sizeof(HostPixelType)*imageDims.product());
	columnMajor = isColumnMajor;
}

void ImageContainer::loadImage( const HostPixelType* imageIn, size_t width, size_t height, size_t depth, bool isColumnMajor/*=false*/ )
{
	loadImage(imageIn,Vec<size_t>(width,height,depth),isColumnMajor);
}

HostPixelType& ImageContainer::operator[]( Vec<size_t> coordinate )
{
	return image[imageDims.linearAddressAt(coordinate,columnMajor)];
}

const HostPixelType& ImageContainer::operator[]( Vec<size_t> coordinate ) const
{
	return image[imageDims.linearAddressAt(coordinate,columnMajor)];
}

HostPixelType& ImageContainer::at( Vec<size_t> coordinate )
{
	return image[imageDims.linearAddressAt(coordinate,columnMajor)];
}

void ImageContainer::setROIData( HostPixelType* imageIn, Vec<size_t> startIndex, Vec<size_t> sizeIn, bool isColumnMajor)
{
	Vec<size_t> curIdx(0,0,0);
	for (curIdx.z=0; curIdx.z<sizeIn.z && curIdx.z+startIndex.z<imageDims.z; ++curIdx.z)
	{
		for (curIdx.y=0; curIdx.y<sizeIn.y && curIdx.y+startIndex.y<imageDims.y; ++curIdx.y)
		{
			for (curIdx.x=0; curIdx.x<sizeIn.x && curIdx.x+startIndex.x<imageDims.x; ++curIdx.x)		
			{
				unsigned int val = imageIn[sizeIn.linearAddressAt(curIdx,isColumnMajor)];
				setPixelValue(curIdx+startIndex,imageIn[sizeIn.linearAddressAt(curIdx,isColumnMajor)]);
			}
		}
	}
}