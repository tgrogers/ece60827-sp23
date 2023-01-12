include_directories(${CMAKE_SOURCE_DIR} ${CMAKE_SOURCE_DIR}/include)

#add_library(GpuLibs saxpy_cpu.cpp saxpy_gpu.cu) 

# CUDA Libaraies
cuda_add_library(cudaLib cudaLib.cu)
target_link_libraries(cudaLib ${CUDA_LIBRARIES})

# GCC (CPU) Libraries
add_library(cpuLib cpuLib.cpp )

