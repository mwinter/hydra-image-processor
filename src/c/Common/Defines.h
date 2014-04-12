#pragma once

#define NUM_BINS (255)
#define MAX_KERNEL_DIM (25)

#define SQR(x) ((x)*(x))
#define MAX(x,y) (x>y)?(x):(y)
#define MIN(x,y) (x<y)?(x):(y)

#define mat_to_c(x) (x-1)
#define c_to_mat(x) (x+1)

typedef unsigned char HostPixelType;
typedef HostPixelType DevicePixelType;

//Percent of memory that can be used on the device
const double MAX_MEM_AVAIL = 0.95;