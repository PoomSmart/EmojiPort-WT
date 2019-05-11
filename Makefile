PACKAGE_VERSION = 1.2.4-3

ifeq ($(SIMULATOR),1)
	TARGET = simulator:clang:latest:10.0
	ARCHS = x86_64 i386
else
	TARGET = iphone:clang:latest:10.0
	ARCHS = armv7 arm64
endif

include $(THEOS)/makefiles/common.mk

LIBRARY_NAME = Emoji10WTReal
Emoji10WTReal_FILES = TweakReal.xm
Emoji10WTReal_INSTALL_PATH = /Library/MobileSubstrate/DynamicLibraries/Emoji10WT
Emoji10WTReal_EXTRA_FRAMEWORKS = CydiaSubstrate
Emoji10WTReal_LIBRARIES = EmojiLibrary
Emoji10WTReal_USE_SUBSTRATE = 1

include $(THEOS_MAKE_PATH)/library.mk

ifneq ($(SIMULATOR),1)
TWEAK_NAME = Emoji10WT
Emoji10WT_FILES = Tweak.xm

include $(THEOS_MAKE_PATH)/tweak.mk
endif

ifeq ($(SIMULATOR),1)
setup:: clean all
	@rm -f /opt/simject/Emoji10WT.dylib
	@cp -v $(THEOS_OBJ_DIR)/$(LIBRARY_NAME).dylib /opt/simject/Emoji10WT.dylib
	@cp -v $(PWD)/Emoji10WT.plist /opt/simject
endif
