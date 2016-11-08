#include "cuda_runtime.h"
#include "device_launch_parameters.h"

#include <stdio.h>
#include <Windows.h>

__global__ void hello()
{
	printf("Hello World! I am thread number %d\n", blockIdx.x);
}

int main()
{
	hello << <16, 1 >> > ();

	cudaDeviceSynchronize();

	printf("That's all folks.\n");

	system("pause");
    return 0;
}
