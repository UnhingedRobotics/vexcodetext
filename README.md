# VEX Robotics Command Line Programming Environment  

This repository provides a lightweight, text-based environment for programming and building VEX robotics projects. It is designed as an alternative to the VEX VSCode Extension, allowing you to upload, build, and manage your VEX projects without the need for a full IDE.  

**Note**: This project is **not affiliated with VEX Robotics**. It utilizes files extracted from the official VEX VSCode extension and VEXcode application to enable functionality.  

**Note**: Great inspiration was taken from this [**article on Medium**](https://medium.com/@sw_47875/setting-up-command-line-c-tools-for-your-vex-v5-team-283277c8d79c).

**Note**: This is the [**Main Branch**](https://github.com/UnhingedRobotics/vexcodetext)  if you use Linux please go the [**Linux Branch**](https://github.com/UnhingedRobotics/vexcodetext/tree/linux).

---

## Features  
- Cross-platform support: Available for [**Windows**](https://github.com/UnhingedRobotics/vexcodetext) and [**Linux**](https://github.com/UnhingedRobotics/vexcodetext/tree/linux).  
- Fully text-based interface for streamlined workflows.  
- Supports building and uploading VEX Robotics programs using standard CLI tools.  

---

## Dependencies  

To build and upload your VEX programs, you need the following tools installed on your system:  
- **clang**  
- **arm-none-eabi-objcopy**  
- **arm-none-eabi-size**  
- **arm-none-eabi-ld**  
- **arm-none-eabi-ar**  

### Installing Dependencies  

#### **Windows**  
1. Download and install the **ARM GCC toolchain** from [ARM Developer](https://developer.arm.com/tools-and-software/open-source-software/developer-tools/gnu-toolchain/gnu-rm).  
   - Make sure to add the installation directory to your system `PATH`.  
2. Install **clang**:  
   - Download from [LLVM's website](https://releases.llvm.org/download.html).  
   - Add the `bin` folder from the installation directory to your `PATH`.  

---

## Making your project

1. Make a new folder named src
2. Put any cpp files you want to run in it (typically main.cpp)

## Running the project

- For building run 
```bash
make clean build
```
- For uploading run
```bash
make clean upload
```
