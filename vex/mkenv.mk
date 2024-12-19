# VEXcode mkenv.mk 2022_06_26_01 - Modified to remove SDK folder requirements

# macros to help with paths that include spaces
sp = $() $()
qs = $(subst ?, ,$1)
sq = $(subst $(sp),?,$1)

# default platform and build location
PLATFORM  = vexv5
BUILD     = build

# Project name passed from app
ifeq ("$(origin P)", "command line")
PROJECT  := $(P)
else
PROJECT  := $(call qs,$(notdir $(call sq,${CURDIR})))
endif

# check if the PROJECT name contains any whitespace
ifneq (1,$(words $(PROJECT)))
$(error Project name cannot contain whitespace: $(PROJECT))
endif

# printf_float flag name passed from app (not used in this version)
ifeq ("$(origin PRINTF_FLOAT)", "command line")
PRINTF_FLAG = -u_printf_float
endif

# Verbose flag passed from app
ifeq ("$(origin V)", "command line")
BUILD_VERBOSE=$(V)
endif

# allow verbose to be set by makefile if not set by app
ifndef VERBOSE
BUILD_VERBOSE ?= 0
else
BUILD_VERBOSE ?= $(VERBOSE)
endif

# use verbose flag
ifeq ($(BUILD_VERBOSE),0)
Q = @
else
Q =
endif

# compile and link tools
CC      = arm-none-eabi-gcc
CXX     = arm-none-eabi-g++
OBJCOPY = arm-none-eabi-objcopy
SIZE    = arm-none-eabi-size
LINK    = arm-none-eabi-ld
ARCH    = arm-none-eabi-ar
ECHO    = @echo
DEFINES = -DVexV5

# platform specific macros
ifeq ($(OS),Windows_NT)
$(info windows build for platform $(PLATFORM))
SHELL = cmd.exe
MKDIR = md "$(@D)" 2> nul || :
RMDIR = rmdir /S /Q
CLEAN = $(RMDIR) $(BUILD) 2> nul || :
else
# which flavor of linux
UNAME := $(shell sh -c 'uname -sm 2>/dev/null || Unknown')
$(info unix build for platform $(PLATFORM) on $(UNAME))
MKDIR = mkdir -p "$(@D)" 2> /dev/null || :
RMDIR = rm -rf
CLEAN = $(RMDIR) $(BUILD) 2> /dev/null || :
endif

# toolchain include and lib locations (using system-installed ARM GCC toolchain)
TOOL_INC  = -I"/usr/include" -I"/usr/include/arm-none-eabi" -I"/usr/include/c++/4.9.3"
TOOL_LIB  = -L"/usr/lib/arm-none-eabi"

# compiler flags
CFLAGS_CL = -mcpu=cortex-m4 -mthumb -fshort-enums -Wno-unknown-attributes -U__INT32_TYPE__ -U__UINT32_TYPE__ -D__INT32_TYPE__=long -D__UINT32_TYPE__='unsigned long'
CFLAGS_V7 = -march=armv7-a -mfpu=neon -mfloat-abi=softfp
CFLAGS    = ${CFLAGS_CL} ${CFLAGS_V7} -Os -Wall -Werror=return-type -ansi -std=gnu99 $(DEFINES)
CXX_FLAGS = ${CFLAGS_CL} ${CFLAGS_V7} -Os -Wall -Werror=return-type -fno-rtti -fno-threadsafe-statics -fno-exceptions -std=gnu++11 $(DEFINES)

# linker flags
LNK_FLAGS = -nostdlib -T"/usr/lib/ldscripts/arm.ld" --gc-sections -Map="$(BUILD)/$(PROJECT).map" ${TOOL_LIB}

# future static library
PROJECTLIB = lib$(PROJECT)
ARCH_FLAGS = rcs

# libraries
LIBS = --start-group -lv5rt -lstdc++ -lc -lm -lgcc --end-group

# include file paths
INC += $(addprefix -I, ${INC_F})
INC += ${TOOL_INC}


# print build info
info:
	@echo "Project: $(PROJECT)"
	@echo "Platform: $(PLATFORM)"
	@echo "Compiler: $(CC)"

VEXCOM = vexcom
