cmake_minimum_required(VERSION 3.5)
message(STATUS "CMake version: ${CMAKE_VERSION}")

cmake_policy(SET CMP0074 NEW)

set(CMAKE_BUILD_TYPE Debug)

# enable C++11 standard
set(CMAKE_CXX_STANDARD 11)  

# Project name and a few useful settings. Other commands can pick up the results
project(
  Lab1
  VERSION 0.1
  DESCRIPTION "An simple project with CUDA"
  LANGUAGES CXX CUDA)

set_property(GLOBAL PROPERTY USE_FOLDERS ON)

find_package(CUDA REQUIRED)

list(APPEND CUDA_NVCC_FLAGS "-std=c++11")

option(USE_CUDA "Use CUDA" ON)

file(GLOB cpu_header_files "${CMAKE_SOURCE_DIR}/include/*.h")
file(GLOB cpu_source_files "${CMAKE_SOURCE_DIR}/src/*.cpp")
file(GLOB gpu_header_files "${CMAKE_SOURCE_DIR}/include/*.cuh")
file(GLOB gpu_source_files "${CMAKE_SOURCE_DIR}/src/*.cu")

if( ("${CMAKE_VERSION}" VERSION_EQUAL 3.8) OR
        ("${CMAKE_VERSION}" VERSION_GREATER 3.8) )
    # Modern CMake
    if(USE_CUDA)
        enable_language("CUDA")

        # The compiled library code is here
        add_subdirectory(src)
        set(LIBRARY_OUTPUT_PATH ${PROJECT_SOURCE_DIR}/lib)

        # The executable code is here
        # add_subdirectory(apps)

        include_directories("${CMAKE_SOURCE_DIR}")
        include_directories("${CMAKE_SOURCE_DIR}/include")

        # I assume you want to use LibProject as a library in MainProject.
        #include_directories(${MyProject_SOURCE_DIR}/LibProject/inc)
        
        link_directories(${CMAKE_SOURCE_DIR}/src)
        
        # add_executable(saxpy_cpu "${CMAKE_SOURCE_DIR}/src/saxpy_cpu.cpp")
        # add_executable(saxpy_gpu "${CMAKE_SOURCE_DIR}/src/saxpy_gpu.cu")
        add_executable(lab1 "${CMAKE_SOURCE_DIR}/lab1.cu" "${CMAKE_SOURCE_DIR}/lab1.cuh")
        target_link_libraries(lab1 cudaLib)
        target_link_libraries(lab1 cpuLib)
     
        # add_executable(AlexNet ${cpu_header_files} ${cpu_source_files} ${gpu_header_files} ${gpu_source_files})
    else(USE_CUDA)
        add_executable(saxpy ${cpu_header_files} ${cpu_source_files})
    endif()
else()
    # Old CMake
    add_executable(Lab1 ${cpu_header_files} ${cpu_source_files})
    if(USE_CUDA)
        find_package(CUDA 10.0)
        if(NOT CUDA_FOUND)
            message(STATUS "CUDA not found")
            set(USE_CUDA OFF)
        else()
            CUDA_ADD_LIBRARY(AlexNet_gpu ${gpu_header_files} ${gpu_source_files})
            target_link_libraries(AlexNet AlexNet_gpu)
        endif()
    endif()
endif()

message(STATUS "USE_CUDA: ${USE_CUDA}")
if(USE_CUDA)
    add_definitions(-DUSE_CUDA)
endif()