

#ifndef CUDA_LIB_H
#define CUDA_LIB_H

	#include "cpuLib.h"

	#include <cuda.h>
	#include <curand_kernel.h>

	// Uncomment this to suppress console output
	// #define DEBUG_PRINT_DISABLE

	#define gpuErrchk(ans) { gpuAssert((ans), __FILE__, __LINE__); }
	extern inline void gpuAssert(cudaError_t code, const char *file, int line, bool abort=true);

	/**
	 * @brief GPU kernel to generate sampleSize points in the 2D plane and 
	 *			evaluate the number of points that lie wihtin the unit quarter circle
	 * 
	 * @param pSums 		uint64_t	pointer to vector to store partial sum
	 *									of the number of points within unit circle
	 * @param pSumSize 		uint64_t	size of the pSum vector 
	 * @param sampleSize	uint64_t 	size of the set of random points evaluated by each GPU thread
	 * @return void 
	 */
	extern __global__ void generatePoints (uint64_t * pSums, uint64_t pSumSize, 
		uint64_t sampleSize);

	/**
	 * @brief Optional GPU kernel to reduce a set of partial sums into a smaller set
	 *			by summing a subset into a single value
	 * 
	 * @param pSums 		pointer to memory location to store partial counts
	 * @param totals 		pointer to memory location to store reduced counts
	 * @param pSumSize 		size of pSums array
	 * @param reduceSize 	size of reduced totals array
	 * @return void 
	 */
	extern __global__ void reduceCounts (uint64_t * pSums, uint64_t * totals, 
		uint64_t pSumSize, uint64_t reduceSize);

	/**
	 * @brief Entrypoint for GPU SAXPY application
	 *			- Must generate vectors of the appropriate size
	 *			- Perform GPU SAXPY
	 *			- Verify using CPU and report errors if any
	 * 
	 * @param vectorSize int	size of vector 
	 * @return int 
	 */
	extern int runGpuSaxpy(int vectorSize);

	/**
	 * @brief GPU Kernel for performing SAXPY (Y += Scale * X)
	 * 
	 * @param x 	float*		pointer to vector X
	 * @param y 	float*		pointer to vector Y
	 * @param scale float		scale factor (A of SAXPY)
	 * @param size 	uint64_t 	size of the vector Y
	 * @return void 
	 */
	extern __global__ void saxpy_gpu (float* x, float* y, float scale, int size);

	/**
	 * @brief Entrypoint for GPU Monte-Carlo estimation of Pi
	 * 
	 * @param generateThreadCount 	uint64_t	total number of generate threads	
	 * @param sampleSize 			uint64_t	sample of points evaluated by each thread
	 * @param reduceThreadCount 	uint64_t	number of reduction threads
	 * @param reduceSize 			uint64_t	number of pSums summed by each reduce thread
	 * @return int 	success or failure status
	 */
	extern int runGpuMCPi(uint64_t generateThreadCount, uint64_t sampleSize, 
		uint64_t reduceThreadCount, uint64_t reduceSize);

	/**
	 * @brief main body for Monte-Carlo Pi estimation
	 * 
	 * @param generateThreadCount 	uint64_t	total number of generate threads	
	 * @param sampleSize 			uint64_t	sample of points evaluated by each thread
	 * @param reduceThreadCount 	uint64_t	number of reduction threads
	 * @param reduceSize 			uint64_t	number of pSums summed by each reduce thread
	 * @return double 	approx value of pi
	 */
	extern double estimatePi(uint64_t generateThreadCount, uint64_t sampleSize, 
		uint64_t reduceThreadCount, uint64_t reduceSize);

#endif
