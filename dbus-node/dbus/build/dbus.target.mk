# This file is generated by gyp; do not edit.

TOOLSET := target
TARGET := dbus
DEFS_Debug := \
	'-D_LARGEFILE_SOURCE' \
	'-D_FILE_OFFSET_BITS=64' \
	'-DLIB_EXPAT=expat' \
	'-DBUILDING_NODE_EXTENSION' \
	'-DDEBUG' \
	'-D_DEBUG'

# Flags passed to all source files.
CFLAGS_Debug := \
	-Wall \
	-Wextra \
	-Wno-unused-parameter \
	-pthread \
	-m32 \
	-std=gnu++0x \
	-I/usr/include/dbus-1.0 \
	-I/usr/lib/i386-linux-gnu/dbus-1.0/include \
	-g \
	-O0

# Flags passed to only C files.
CFLAGS_C_Debug :=

# Flags passed to only C++ files.
CFLAGS_CC_Debug := \
	-fno-rtti \
	-fno-exceptions

INCS_Debug := \
	-I/usr/include/nodejs/src \
	-I/usr/include/nodejs/deps/uv/include \
	-I/usr/include/nodejs/deps/v8/include

DEFS_Release := \
	'-D_LARGEFILE_SOURCE' \
	'-D_FILE_OFFSET_BITS=64' \
	'-DLIB_EXPAT=expat' \
	'-DBUILDING_NODE_EXTENSION'

# Flags passed to all source files.
CFLAGS_Release := \
	-Wall \
	-Wextra \
	-Wno-unused-parameter \
	-pthread \
	-m32 \
	-std=gnu++0x \
	-I/usr/include/dbus-1.0 \
	-I/usr/lib/i386-linux-gnu/dbus-1.0/include \
	-O2 \
	-fno-strict-aliasing \
	-fno-tree-vrp \
	-fno-omit-frame-pointer

# Flags passed to only C files.
CFLAGS_C_Release :=

# Flags passed to only C++ files.
CFLAGS_CC_Release := \
	-fno-rtti \
	-fno-exceptions

INCS_Release := \
	-I/usr/include/nodejs/src \
	-I/usr/include/nodejs/deps/uv/include \
	-I/usr/include/nodejs/deps/v8/include

OBJS := \
	$(obj).target/$(TARGET)/src/dbus.o \
	$(obj).target/$(TARGET)/src/connection.o \
	$(obj).target/$(TARGET)/src/signal.o \
	$(obj).target/$(TARGET)/src/encoder.o \
	$(obj).target/$(TARGET)/src/decoder.o \
	$(obj).target/$(TARGET)/src/introspect.o \
	$(obj).target/$(TARGET)/src/object_handler.o

# Add to the list of files we specially track dependencies for.
all_deps += $(OBJS)

# CFLAGS et al overrides must be target-local.
# See "Target-specific Variable Values" in the GNU Make manual.
$(OBJS): TOOLSET := $(TOOLSET)
$(OBJS): GYP_CFLAGS := $(DEFS_$(BUILDTYPE)) $(INCS_$(BUILDTYPE))  $(CFLAGS_$(BUILDTYPE)) $(CFLAGS_C_$(BUILDTYPE))
$(OBJS): GYP_CXXFLAGS := $(DEFS_$(BUILDTYPE)) $(INCS_$(BUILDTYPE))  $(CFLAGS_$(BUILDTYPE)) $(CFLAGS_CC_$(BUILDTYPE))

# Suffix rules, putting all outputs into $(obj).

$(obj).$(TOOLSET)/$(TARGET)/%.o: $(srcdir)/%.cc FORCE_DO_CMD
	@$(call do_cmd,cxx,1)

# Try building from generated source, too.

$(obj).$(TOOLSET)/$(TARGET)/%.o: $(obj).$(TOOLSET)/%.cc FORCE_DO_CMD
	@$(call do_cmd,cxx,1)

$(obj).$(TOOLSET)/$(TARGET)/%.o: $(obj)/%.cc FORCE_DO_CMD
	@$(call do_cmd,cxx,1)

# End of this set of suffix rules
### Rules for final target.
LDFLAGS_Debug := \
	-pthread \
	-rdynamic \
	-m32

LDFLAGS_Release := \
	-pthread \
	-rdynamic \
	-m32

LIBS := \
	-ldbus-1 \
	-lexpat

$(obj).target/dbus.node: GYP_LDFLAGS := $(LDFLAGS_$(BUILDTYPE))
$(obj).target/dbus.node: LIBS := $(LIBS)
$(obj).target/dbus.node: TOOLSET := $(TOOLSET)
$(obj).target/dbus.node: $(OBJS) FORCE_DO_CMD
	$(call do_cmd,solink_module)

all_deps += $(obj).target/dbus.node
# Add target alias
.PHONY: dbus
dbus: $(builddir)/dbus.node

# Copy this to the executable output path.
$(builddir)/dbus.node: TOOLSET := $(TOOLSET)
$(builddir)/dbus.node: $(obj).target/dbus.node FORCE_DO_CMD
	$(call do_cmd,copy)

all_deps += $(builddir)/dbus.node
# Short alias for building this executable.
.PHONY: dbus.node
dbus.node: $(obj).target/dbus.node $(builddir)/dbus.node

# Add executable to "all" target.
.PHONY: all
all: $(builddir)/dbus.node
