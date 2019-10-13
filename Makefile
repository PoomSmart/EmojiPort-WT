PACKAGE_VERSION = 1.2.5~b2

ifeq ($(SIMULATOR),1)
	TARGET = simulator:clang:latest:10.0
	ARCHS = x86_64 i386
else
	TARGET = iphone:clang:latest:10.0
	ARCHS = armv7 arm64
endif

include $(THEOS)/makefiles/common.mk

LIBRARY_NAME = EmojiPortWTReal
EmojiPortWTReal_FILES = TweakReal.xm ../EmojiPort-PE/FamilyPicker.xm
EmojiPortWTReal_INSTALL_PATH = /Library/MobileSubstrate/DynamicLibraries/EmojiPortWT
EmojiPortWTReal_EXTRA_FRAMEWORKS = CydiaSubstrate
EmojiPortWTReal_LIBRARIES = EmojiLibrary Substitrate
EmojiPortWTReal_USE_SUBSTRATE = 1

include $(THEOS_MAKE_PATH)/library.mk

ifneq ($(SIMULATOR),1)
TWEAK_NAME = EmojiPortWT
EmojiPortWT_FILES = Tweak.xm

include $(THEOS_MAKE_PATH)/tweak.mk
endif

ifeq ($(SIMULATOR),1)
setup:: clean all
	@rm -f /opt/simject/EmojiPortWT.dylib
	@cp -v $(THEOS_OBJ_DIR)/$(LIBRARY_NAME).dylib /opt/simject/EmojiPortWT.dylib
	@cp -v $(PWD)/EmojiPortWT.plist /opt/simject
endif
