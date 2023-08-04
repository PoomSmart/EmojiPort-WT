#define CHECK_TARGET
#define CHECK_WHITELIST
#import <dlfcn.h>
#import <PSHeader/PS.h>

%ctor {
    if (_isTarget(TargetTypeApps | TargetTypeGenericExtensions, @[@"com.apple.WebKit.WebContent", @"kbd"], nil)) {
        dlopen("/Library/MobileSubstrate/DynamicLibraries/EmojiPort/EmojiAttributes.dylib", RTLD_LAZY);
        dlopen("/Library/MobileSubstrate/DynamicLibraries/EmojiPort/EmojiPortWTReal.dylib", RTLD_LAZY);
    }
}
