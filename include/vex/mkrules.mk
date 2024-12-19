# VEXcode mkrules.mk 2019_03_26_01

# Define source and object files
SRC = src/main.cpp src/other_file.cpp  # Add other files as needed
OBJ = $(SRC:.cpp=.o)

# compile C files
$(BUILD)/%.o: %.c $(SRC_H)
	$(Q)mkdir -p $(BUILD)
	$(ECHO) "CC  $<"
	$(Q)$(CC) $(CFLAGS) $(INC) -c -o $@ $<

# compile C++ files
$(BUILD)/%.o: %.cpp $(SRC_H) $(SRC_A)
	$(Q)mkdir -p $(BUILD)
	$(ECHO) "CXX $<"
	$(Q)$(CXX) $(CXX_FLAGS) $(INC) -c -o $@ $<

# create executable
$(BUILD)/$(PROJECT).elf: $(OBJ)
	$(ECHO) "LINK $@"
	$(Q)$(CXX) $(LNK_FLAGS) -o $@ $^ $(LIBS)

# create binary
$(BUILD)/$(PROJECT).bin: $(BUILD)/$(PROJECT).elf
	$(Q)$(OBJCOPY) -O binary $< $@

# create archive
$(BUILD)/$(PROJECTLIB).a: $(OBJ)
	$(Q)$(ARCH) $(ARCH_FLAGS) $@ $^

# clean project
clean:
	$(info clean project)
	$(Q)$(RMDIR) $(BUILD) 2> /dev/null || :


# upload the binary to VEX V5
upload: $(BUILD)/$(PROJECT).bin
	./vexcom --write $(BUILD)/$(PROJECT).bin --slot --name $(PROJECT)

test:
	./vexcom
# Default target for build
build:  clean $(BUILD)/$(PROJECT).bin
