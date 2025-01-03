# VEXcode makefile 2019_03_26_01 (Windows Compatible)

# show compiler output
VERBOSE = 1

# include toolchain options
include vex/mkenv.mk

# location of the project source cpp and c files
SRC_C  = $(wildcard src/*.cpp) 
SRC_C += $(wildcard src/*.c)
SRC_C += $(wildcard src/*/*.cpp) 
SRC_C += $(wildcard src/*/*.c)

OBJ = $(addprefix $(BUILD)/, $(addsuffix .o, $(basename $(SRC_C))) )

# location of include files that c and cpp files depend on
SRC_H  = $(wildcard include/*.h)

# additional dependencies
SRC_A  = makefile

# project header file locations
INC_F  = include
# Use the -C flag to invoke make in the 'getvexsdk' directory
HOME := $(CURDIR)
MAKE_GETVEXSDK := $(MAKE) -C $(abspath external/getvexsdk)

# build targets
all: build_getvexsdk move_sdk $(MAKE) $(BUILD)/$(PROJECT).bin

# dependencies ensure order
build_getvexsdk:
	$(MAKE_GETVEXSDK) all

move_sdk:
	# Use Windows-specific 'move' command
	if exist "$(CURDIR)\sdk" rmdir /S /Q "$(CURDIR)\sdk"
	move "$(CURDIR)\external\getvexsdk\sdk\V5_20240802_15_00_00" "$(CURDIR)\sdk"

# include build rules
include vex/mkrules.mk
