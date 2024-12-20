# VEX Robotics Command Line Programming Environment  

This repository provides a lightweight, text-based environment for programming and building VEX robotics projects. It is designed as an alternative to the VEX VSCode Extension, allowing you to upload, build, and manage your VEX projects without the need for a full IDE.  

**Note**: This project is **not affiliated with VEX Robotics**. It utilizes files extracted from the official VEX VSCode extension and VEXcode application to enable functionality.  

**Note**: This is the [**Linux Branch**](https://github.com/UnhingedRobotics/vexcodetext/tree/linux) if you use windows please go the [**Main Branch**](https://github.com/UnhingedRobotics/vexcodetext).

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

#### **Linux**  
1. Install the **ARM GCC toolchain**:  
   - On Debian-based systems (e.g., Ubuntu):  
     ```bash
     sudo apt update  
     sudo apt install gcc-arm-none-eabi binutils-arm-none-eabi  
     ```  
   - On Arch Linux:  
     ```bash
     sudo pacman -S arm-none-eabi-gcc arm-none-eabi-binutils  
     ```  
2. Install **clang**:  
   - On Debian-based systems:  
     ```bash
     sudo apt install clang  
     ```  
   - On Arch Linux:  
     ```bash
     sudo pacman -S clang  
     ```  

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
