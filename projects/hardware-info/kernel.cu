
#include "cuda_runtime.h"
#include "device_launch_parameters.h"

#include <iostream>

#include "thrust\host_vector.h"
#include "thrust\device_vector.h"

cudaError_t addWithCuda(int *c, const int *a, const int *b, unsigned int size);

__global__ void addKernel(int *c, const int *a, const int *b)
{
	int i = threadIdx.x;
	c[i] = a[i] + b[i];
}

int main()
{
	int computeCompatabilityMajor;
	int computeCompatabilityMinor;
	cudaDeviceGetAttribute(&computeCompatabilityMajor, cudaDevAttrComputeCapabilityMajor, 0);
	cudaDeviceGetAttribute(&computeCompatabilityMinor, cudaDevAttrComputeCapabilityMinor, 0);
	printf("Compute Version: %d.%d\n", computeCompatabilityMajor, computeCompatabilityMinor);


	int maxGridDimX;
	int maxGridDimY;
	int maxGridDimZ;
	cudaDeviceGetAttribute(&maxGridDimX, cudaDevAttrMaxGridDimX, 0);
	cudaDeviceGetAttribute(&maxGridDimY, cudaDevAttrMaxGridDimY, 0);
	cudaDeviceGetAttribute(&maxGridDimZ, cudaDevAttrMaxGridDimZ, 0);
	printf("Max Grid Dimensions: (%d, %d, %d)\n", maxGridDimX, maxGridDimY, maxGridDimZ);


	int maxBlockDimX;
	int maxBlockDimY;
	int maxBlockDimZ;
	cudaDeviceGetAttribute(&maxBlockDimX, cudaDevAttrMaxBlockDimX, 0);
	cudaDeviceGetAttribute(&maxBlockDimY, cudaDevAttrMaxBlockDimY, 0);
	cudaDeviceGetAttribute(&maxBlockDimZ, cudaDevAttrMaxBlockDimZ, 0);
	printf("Max Block Dimensions: (%d, %d, %d)\n", maxBlockDimX, maxBlockDimY, maxBlockDimZ);


	int maxThreads;
	cudaDeviceGetAttribute(&maxThreads, cudaDevAttrMaxThreadsPerBlock, 0);
	printf("Max Threads per Block: %d\n", maxThreads);


	system("pause");
}
