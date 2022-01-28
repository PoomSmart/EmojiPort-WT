PACKAGE_VERSION = 1.3.5

ifeq ($(SIMULATOR),1)
	TARGET = simulator:clang:latest:10.0
	ARCHS = x86_64 i386
else
	TARGET = iphone:clang:latest:10.0
	ARCHS = armv7 arm64
endif

include $(THEOS)/makefiles/common.mk

LIBRARY_NAME = EmojiPortWTReal
$(LIBRARY_NAME)_FILES = TweakReal.x ../EmojiPort-PE/FamilyPicker.x
$(LIBRARY_NAME)_CFLAGS = -fobjc-arc
$(LIBRARY_NAME)_INSTALL_PATH = /Library/MobileSubstrate/DynamicLibraries/EmojiPort
$(LIBRARY_NAME)_EXTRA_FRAMEWORKS = CydiaSubstrate
$(LIBRARY_NAME)_LIBRARIES = EmojiLibrary
$(LIBRARY_NAME)_USE_SUBSTRATE = 1

include $(THEOS_MAKE_PATH)/library.mk

ifneq ($(SIMULATOR),1)
TWEAK_NAME = EmojiPortWT
$(TWEAK_NAME)_FILES = Tweak.x
$(TWEAK_NAME)_CFLAGS = -fobjc-arc

include $(THEOS_MAKE_PATH)/tweak.mk
endif

ifeq ($(SIMULATOR),1)
setup:: clean all
	@rm -f /opt/simject/EmojiPortWT.dylib
	@cp -v $(THEOS_OBJ_DIR)/$(LIBRARY_NAME).dylib /opt/simject/EmojiPortWT.dylib
	@cp -v $(PWD)/EmojiPortWT.plist /opt/simject
endif
