# VEX Robotics Command Line Programming Environment  

This repository provides a lightweight, text-based environment for programming and building VEX robotics projects. It is designed as an alternative to the VEX VSCode Extension, allowing you to upload, build, and manage your VEX projects without the need for a full IDE.  

**Note**: This project is **not affiliated with VEX Robotics**. It utilizes files extracted from the official VEX VSCode extension and VEXcode application to enable functionality.

**Note**: Great inspiration was taken from this [**article on Medium**](https://medium.com/@sw_47875/setting-up-command-line-c-tools-for-your-vex-v5-team-283277c8d79c).

**Note**: This is the [**Linux Branch**](https://github.com/UnhingedRobotics/vexcodetext/tree/linux) if you use windows please go the [**Main Branch**](https://github.com/UnhingedRobotics/vexcodetext).

---

## Features  
- Cross-platform support: Available for [**Windows**](https://github.com/UnhingedRobotics/vexcodetext) and [**Linux**](https://github.com/UnhingedRobotics/vexcodetext/tree/linux).  
- Fully text-based interface for streamlined workflows.  
- Supports building and uploading VEX Robotics programs using standard CLI tools.  

---

## Dependencies and Initial Necessary Steps for Linux 

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


### **Configuring Serial Connections with udev Rules**

To enable proper communication with the VEX Robotics hardware over a serial connection, you need to configure udev rules. This ensures that the device (e.g., /dev/ttyACM0) has the correct permissions for access.

#### Steps to Configure udev Rules:

1. Create a new udev rules file in the /etc/udev/rules.d/ directory:
    ```bash
    sudo nano /etc/udev/rules.d/01-vex-v5.rules
    ```
2. Add the following line to the file to set permissions for VEX devices:

    ```bash
    KERNEL=="ttyACM[0-9]*", MODE="0666", ATTRS{idVendor}=="2888", ATTRS{idProduct}=="0503"
    ```

   - **Explanation**:
    - `KERNEL=="ttyACM[0-9]*"`: Matches any device with the name pattern `/dev/ttyACM*`.
    - `MODE="0666"`: Sets read and write permissions for all users.
    - `ATTRS{idVendor}=="2888"`: Matches the VEX Robotics Vendor ID.
    - `ATTRS{idProduct}=="0503"`: Matches the VEX Robotics V5 Controller Product ID.

3. Save and close the file.  
   - In `nano`, press `Ctrl+O` to save, then `Enter` to confirm, and `Ctrl+X` to exit.

4. Reload the `udev` rules:

    ```bash
    sudo udevadm control --reload-rules
    ```
5. Unplug and reconnect the VEX Robotics device.

6. Verify the device is accessible:

    ```bash
    ls /dev/ttyACM*
    ```
#### Troubleshooting

- If the device is not recognized or permissions are incorrect, double-check the Vendor ID and Product ID using the lsusb command:
  ``` bash
  lsusb
  ```

Look for a line like:

  ``` bash
  Bus 003 Device 015: ID 2888:0503 VEX Robotics, Inc VEX Robotics V5 Controller
  ```

- Update the idVendor and idProduct values in the udev rules file if necessary.

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
