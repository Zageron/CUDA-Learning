// Homework 1
// Color to Greyscale Conversion

//A common way to represent color images is known as RGBA - the color
//is specified by how much Red, Grean and Blue is in it.
//The 'A' stands for Alpha and is used for transparency, it will be
//ignored in this homework.

//Each channel Red, Blue, Green and Alpha is represented by one byte.
//Since we are using one byte for each color there are 256 different
//possible values for each color.  This means we use 4 bytes per pixel.

//Greyscale images are represented by a single intensity value per pixel
//which is one byte in size.

//To convert an image from color to grayscale one simple method is to
//set the intensity to the average of the RGB channels.  But we will
//use a more sophisticated method that takes into account how the eye 
//perceives color and weights the channels unequally.

//The eye responds most strongly to green followed by red and then blue.
//The NTSC (National Television System Committee) recommends the following
//formula for color to greyscale conversion:

//I = .299f * R + .587f * G + .114f * B

//Notice the trailing f's on the numbers which indicate that they are 
//single precision floating point constants and not double precision
//constants.

//You should fill in the kernel as well as set the block and grid sizes
//so that the entire image is processed.

#include "utils.h"
#include <cuda.h>
#include <stdio.h>
#include <stdlib.h>
#include "device_launch_parameters.h"

typedef unsigned int uint;

__global__
void rgba_to_greyscale(const uchar4* const rgbaImage,
					   unsigned char* const greyImage,
					   int numRows, int numCols)
{
	uint i = (blockIdx.x * blockDim.x) + threadIdx.x;
	uint j = (blockIdx.y * blockDim.y) + threadIdx.y;
	greyImage[i * j] = rgbaImage[i * j].x * 0.299f + rgbaImage[i * j].y * 0.587f + rgbaImage[i * j].z * 0.114f;
}

void your_rgba_to_greyscale(const uchar4 * const h_rgbaImage, uchar4 * const d_rgbaImage,
							unsigned char* const d_greyImage, size_t numRows, size_t numCols)
{
	const dim3 threadsPerBlock(8, 8);
	const dim3 numBlocks(numCols / threadsPerBlock.x + (numCols % threadsPerBlock.x != 0),
						 numRows / threadsPerBlock.y + (numRows % threadsPerBlock.y != 0));

	rgba_to_greyscale << <numBlocks, threadsPerBlock >> > (d_rgbaImage, d_greyImage, numRows, numCols);

	cudaDeviceSynchronize(); checkCudaErrors(cudaGetLastError());

}