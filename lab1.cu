/**
 * @file lab1.cpp
 * @author Abhishek Bhaumick (abhaumic@purdue.edu)
 * @brief 
 * @version 0.1
 * @date 2021-01-11
 * 
 * @copyright Copyright (c) 2021
 * 
 */

#include <iostream>
#include "lab1.cuh"
#include "cpuLib.h"
#include "cudaLib.cuh"

int main(int argc, char** argv) {
	std::string str;
	int choice;

	std::cout << "ECE 695 - Lab 1 \n";
	std::cout << "Select application: \n";
	std::cout << "  1 - CPU SAXPY \n";
	std::cout << "  2 - GPU SAXPY \n";
	std::cout << "  3 - CPU Monte-Carlo Pi \n";
	std::cout << "  4 - GPU Monte-Carlo Pi \n";

	std::cin >> choice;

	std::cout << "\n";
	std::cout << "Choice selected - " << choice << "\n\n";

	switch (choice) {
		//  CPU only SAXPY
		case 1:
			std::cout << "Running SAXPY CPU! \n\n";
			runCpuSaxpy(VECTOR_SIZE);
			std::cout << "\n\n ... Done!\n";
			break;

		//  CUDA + GPU SAXPY
		case 2:
			std::cout << "Running SAXPY GPU! \n\n";
			runGpuSaxpy(VECTOR_SIZE);
			std::cout << "\n\n ... Done!\n";
			break;

		case 3:
			std::cout << "Running Monte-Carlo Pi Estimation on CPU! \n\n";
			runCpuMCPi(MC_ITER_COUNT, MC_SAMPLE_SIZE);
			std::cout << "\n\n ... Done!\n";
			break;

		case 4:
			std::cout << "Running Monte-Carlo Pi Estimation on GPU! \n\n";
			runGpuMCPi(GENERATE_BLOCKS, SAMPLE_SIZE, REDUCE_BLOCKS, REDUCE_SIZE);
			std::cout << "\n\n ... Done!\n";
			break;

		default:
			std::cout << "Hmm ... Devious, you are!\n";
			std::cout << " Choose correctly, you must.\n";
			break;
	}

	return 0;
}


