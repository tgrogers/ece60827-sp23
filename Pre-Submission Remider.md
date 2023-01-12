# Submission Reminders and Checks

1. Remember to change the prototype for `saxpy_gpu()` - changing `scale` from `int` to `float`.
 
    ```C++
    __global__  void saxpy_gpu (float* x, float* y, float scale, int size);
    ```
    For context, see @23
1. Make sure to vary the arguments to the functions 
    - `runGpuSaxpy`
    - `saxpy_gpu`
    - `runGpuMcPi`
    - `estimatePi`
    - `generatePoints`
    - `reduceCounts` (if you are using this)
    
    If you are using defined constants in the header files as arguments, **make sure you change them around and check**

    > The tester will check for a range of values within 
    > 32-bit int range &in; (2<sup>0</sup>, 2<sup>29</sup> -1).
    > 
    > Make sure your code doesn't fail or crash for these values.

1. You can query the device properties to find what are the limits of threadblock or grid dimensions
    > A quick look into the CUDA documentation (linked in Week 1 Assignment Readme) will tell you how

1. To ensure your code doesn't have improper (out-of-bounds) accesses use the cuda-memcheck tool
It will hep sanitize your code and avoid unpredictable behavior during runtime.

1. When profiling, make sure to prune unnecessary console IO within the code written by you. (Keep the menu in lab1)  
`printf()`, `std::cout` and other console activity is quite expensive and might affect your profiling results
If the prints are from the provided code libraries, you can easily get rid of them by setting the macro `DEBUG_PRINT_DISABLE`

1. When profiling using `nvprof` ensure that your kernel is actually getting executed
A message 
```bash
Profiling Result:
  No kernels were profiled
```
This means your kernel has not launched and probably encountered an error.

1. In case of any doubts regarding the contents of the report - post your questions on Piazza.

# Submitting your solutions

Here is a list of pre-submission checks:
- ensure all you source and header files are part of your repo and have been committed.
- **DO NOT** commit executables (including .a libraries and .o executables)
    - always run make clean before committing
- add your report in .pdf format to the repo
- push your commit to github classroom
- tag your commit as `submission`
    - if you are unfamiliar with git check [git documentation](https://git-scm.com/book/en/v2/Git-Basics-Tagging)
- push you tag to github classroom
- verify latest commit and tag have reached github classroom by checking the web page

#pin