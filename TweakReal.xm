#import "../PS.h"
#import "../EmojiLibrary/PSEmojiUtilities.h"
#import "../EmojiLibrary/Header.h"
#import "../EmojiLibrary/Emojis.h"

%config(generator=MobileSubstrate)

@interface EMFEmojiToken (EmojiPort)
@property(assign) int ep_supportsSkinToneVariants;
@end

%group UIKit_Common

%hook UIKeyboardEmojiCategory

+ (NSArray <NSString *> *)DingbatVariantsEmoji {
    return [PSEmojiUtilities DingbatVariantsEmoji];
}

+ (NSArray <NSString *> *)NoneVariantEmoji {
    return [PSEmojiUtilities NoneVariantEmoji];
}

+ (NSArray <NSString *> *)SkinToneEmoji {
    return [PSEmojiUtilities SkinToneEmoji];
}

+ (NSArray <NSString *> *)GenderEmoji {
    return [PSEmojiUtilities GenderEmoji];
}

+ (BOOL)emojiString:(NSString *)emojiString inGroup:(NSArray <NSString *> *)group {
    return [PSEmojiUtilities emojiString:emojiString inGroup:group];
}

+ (NSUInteger)hasVariantsForEmoji:(NSString *)emojiString {
    return [PSEmojiUtilities hasVariantsForEmoji:emojiString];
}

%end

%hook UIKeyboardEmojiCollectionInputView

- (NSString *)emojiBaseString:(NSString *)emojiString {
    return [PSEmojiUtilities emojiBaseString:emojiString];
}

- (BOOL)genderEmojiBaseStringNeedVariantSelector:(NSString *)emojiBaseString {
    return [PSEmojiUtilities genderEmojiBaseStringNeedVariantSelector:emojiBaseString];
}

%end

%end

%group UIKit_iOS10_2Up

%hook UIKeyboardEmojiCategory

+ (NSArray <NSString *> *)ProfessionEmoji {
    return [PSEmojiUtilities ProfessionEmoji];
}

+ (NSString *)professionSkinToneEmojiBaseKey:(NSString *)emojiString {
    return [PSEmojiUtilities professionSkinToneEmojiBaseKey:emojiString];
}

%end

%end

%group EMF_iOS10_2Up

%hook EMFEmojiCategory

+ (NSArray <NSString *> *)PeopleEmoji {
    return [PSEmojiUtilities PeopleEmoji];
}

+ (NSArray <NSString *> *)NatureEmoji {
    return [PSEmojiUtilities NatureEmoji];
}

+ (NSArray <NSString *> *)FoodAndDrinkEmoji {
    return [PSEmojiUtilities FoodAndDrinkEmoji];
}

+ (NSArray <NSString *> *)ActivityEmoji {
    return [PSEmojiUtilities ActivityEmoji];
}

+ (NSArray <NSString *> *)CelebrationEmoji {
    return [PSEmojiUtilities CelebrationEmoji];
}

+ (NSArray <NSString *> *)TravelAndPlacesEmoji {
    return [PSEmojiUtilities TravelAndPlacesEmoji];
}

+ (NSArray <NSString *> *)ObjectsEmoji {
    return [PSEmojiUtilities ObjectsEmoji];
}

+ (NSArray <NSString *> *)SymbolsEmoji {
    return [PSEmojiUtilities SymbolsEmoji];
}

+ (NSArray <NSString *> *)DingbatsVariantEmoji {
    return [PSEmojiUtilities DingbatVariantsEmoji];
}

+ (NSArray <NSString *> *)NoneVariantEmoji {
    return [PSEmojiUtilities NoneVariantEmoji];
}

+ (NSArray <NSString *> *)SkinToneEmoji {
    return [PSEmojiUtilities SkinToneEmoji];
}

+ (NSArray <NSString *> *)GenderEmoji {
    return [PSEmojiUtilities GenderEmoji];
}

+ (NSArray <NSString *> *)ProfessionEmoji {
    return [PSEmojiUtilities ProfessionEmoji];
}

+ (NSArray <NSString *> *)computeEmojiFlagsSortedByLanguage {
    return [PSEmojiUtilities FlagsEmoji];
}

%end

%hook EMFEmojiPreferences

+ (NSArray <NSString *> *)_cachedFlagCategoryEmoji:(id)arg1 {
    return [PSEmojiUtilities FlagsEmoji];
}

%end

%hook EMFStringUtilities

+ (NSString *)_baseStringForEmojiString:(NSString *)emojiString {
    return [PSEmojiUtilities emojiBaseString:emojiString];
}

%end

%end

%group EMF_Common

%hook EMFEmojiCategory

- (NSMutableArray <EMFEmojiToken *> *)emojiTokensForLocaleData:(EMFEmojiLocaleData *)localeData {
    NSString *identifier = self.identifier;
    NSMutableArray <EMFEmojiToken *> *tokens = [NSMutableArray array];
    NSArray <NSString *> *emojis = nil;
    if (stringEqual(identifier, @"EMFEmojiCategoryPrepopulated"))
        emojis = [PSEmojiUtilities PrepolulatedEmoji];
    else if (stringEqual(identifier, @"EMFEmojiCategoryPeople"))
        emojis = [PSEmojiUtilities PeopleEmoji];
    else if (stringEqual(identifier, @"EMFEmojiCategoryNature"))
        emojis = [PSEmojiUtilities NatureEmoji];
    else if (stringEqual(identifier, @"EMFEmojiCategoryFoodAndDrink"))
        emojis = [PSEmojiUtilities FoodAndDrinkEmoji];
    else if (stringEqual(identifier, @"EMFEmojiCategoryActivity"))
        emojis = [PSEmojiUtilities ActivityEmoji];
    else if (stringEqual(identifier, @"EMFEmojiCategoryTravelAndPlaces"))
        emojis = [PSEmojiUtilities TravelAndPlacesEmoji];
    else if (stringEqual(identifier, @"EMFEmojiCategoryObjects"))
        emojis = [PSEmojiUtilities ObjectsEmoji];
    else if (stringEqual(identifier, @"EMFEmojiCategorySymbols"))
        emojis = [PSEmojiUtilities SymbolsEmoji];
    for (NSString *emoji in emojis)
        [tokens addObject:[NSClassFromString(@"EMFEmojiToken") emojiTokenWithString:emoji localeData:localeData]];
    return tokens;
}

%end

%hook EMFEmojiToken

%property(assign) int ep_supportsSkinToneVariants;

- (id)initWithCEMEmojiToken:(void *)arg0 {
    self = %orig;
    self.ep_supportsSkinToneVariants = -1;
    return self;
}

- (id)initWithString:(NSString *)string localeIdentifier:(NSString *)localeIdentifier {
    self = %orig;
    self.ep_supportsSkinToneVariants = -1;
    return self;
}

- (BOOL)supportsSkinToneVariants {
    if (self.ep_supportsSkinToneVariants == -1)
        self.ep_supportsSkinToneVariants = ![[PSEmojiUtilities NoneVariantEmoji] containsObject:self.string] && [PSEmojiUtilities emojiString:[PSEmojiUtilities emojiBaseFirstCharacterString:self.string] inGroup:[PSEmojiUtilities SkinToneEmoji]] ? 1 : 0;
    return self.ep_supportsSkinToneVariants == 1;
}

%end

%end

%group UIKit_iOS10_1

%hook UIKeyboardEmojiCategory

+ (NSArray <NSString *> *)PeopleEmoji {
    return [PSEmojiUtilities PeopleEmoji];
}

+ (NSArray <NSString *> *)NatureEmoji {
    return [PSEmojiUtilities NatureEmoji];
}

+ (NSArray <NSString *> *)FoodAndDrinkEmoji {
    return [PSEmojiUtilities FoodAndDrinkEmoji];
}

+ (NSArray <NSString *> *)ActivityEmoji {
    return [PSEmojiUtilities ActivityEmoji];
}

+ (NSArray <NSString *> *)CelebrationEmoji {
    return [PSEmojiUtilities CelebrationEmoji];
}

+ (NSArray <NSString *> *)TravelAndPlacesEmoji {
    return [PSEmojiUtilities TravelAndPlacesEmoji];
}

+ (NSArray <NSString *> *)ObjectsEmoji {
    return [PSEmojiUtilities ObjectsEmoji];
}

+ (NSArray <NSString *> *)SymbolsEmoji {
    return [PSEmojiUtilities SymbolsEmoji];
}

+ (NSArray <NSString *> *)loadPrecomputedEmojiFlagCategory {
    return [PSEmojiUtilities FlagsEmoji];
}

%new
+ (NSArray <NSString *> *)ProfessionEmoji {
    return [PSEmojiUtilities ProfessionEmoji];
}

%new
+ (NSString *)professionSkinToneEmojiBaseKey:(NSString *)emojiString {
    return [PSEmojiUtilities professionSkinToneEmojiBaseKey:emojiString];
}

%end

BOOL preventFirst = NO;
BOOL overrideNewVariant = NO;

%hook UIKeyboardEmojiCollectionInputView

- (NSString *)emojiBaseFirstCharacterString:(NSString *)emojiString {
    NSString *baseEmoji = nil;
    return preventFirst && emojiString.length >= 4 && [[PSEmojiUtilities ProfessionEmoji] containsObject:baseEmoji = [PSEmojiUtilities professionSkinToneEmojiBaseKey:emojiString]] ? baseEmoji : %orig;
}

- (NSString *)emojiBaseString:(NSString *)emojiString {
    return [PSEmojiUtilities emojiBaseString:emojiString];
}

- (id)subTreeHitTest:(CGPoint)point {
    preventFirst = overrideNewVariant = YES;
    id r = %orig;
    preventFirst = overrideNewVariant = NO;
    return r;
}

%end

%hook UIKBTree

- (void)setRepresentedString:(NSString *)string {
    %orig(overrideNewVariant ? [PSEmojiUtilities overrideKBTreeEmoji:string] : string);
}

%end

%end

%group CoreEmoji

void *(*EmojiData)(void *, CFURLRef const, CFURLRef const);
%hookf(void *, EmojiData, void *arg0, CFURLRef const datPath, CFURLRef const metaDatPath) {
    void *orig = %orig(arg0, datPath, metaDatPath);
#if __LP64__
    CFMutableArrayRef *data = (CFMutableArrayRef *)((uintptr_t)arg0 + 0x28);
    int *count = (int *)((uintptr_t)arg0 + 0x32);
#else
    CFMutableArrayRef *data = (CFMutableArrayRef *)((uintptr_t)arg0 + 0x14);
    int *count = (int *)((uintptr_t)arg0 + 0x1A);
#endif
    CFArrayRemoveAllValues(*data);
    for (NSString *emoji in Emoji_Data) {
        CFStringRef cfEmoji = CFStringCreateWithCString(kCFAllocatorDefault, [emoji UTF8String], kCFStringEncodingUTF8);
        if (cfEmoji != NULL) {
            CFArrayAppendValue(*data, cfEmoji);
            CFRelease(cfEmoji);
        }
    }
    [Emoji_Data autorelease];
    *count = CFArrayGetCount(*data);
    return orig;
}

CFURLRef (*copyResourceURLFromFrameworkBundle)(CFStringRef const, CFStringRef const, CFLocaleRef const);
%hookf(CFURLRef, copyResourceURLFromFrameworkBundle, CFStringRef const resourceName, CFStringRef const resourceType, CFLocaleRef const locale) {
    CFURLRef url = NULL;
    if (resourceName && resourceType && (CFStringEqual(resourceType, CFSTR("dat")) || CFStringEqual(resourceType, CFSTR("bitmap")) || CFStringEqual(resourceType, CFSTR("strings")) || (CFStringEqual(resourceName, CFSTR("emojimeta")) && !isiOS11Up)))
        url = %orig((__bridge CFStringRef)[(__bridge NSString *)resourceName stringByAppendingString:@"2"], resourceType, locale);
    return url ? url : %orig;
}

%end

%ctor {
    dlopen(realPath2(@"/System/Library/PrivateFrameworks/EmojiFoundation.framework/EmojiFoundation"), RTLD_NOW);
#if TARGET_OS_SIMULATOR
    dlopen("/opt/simject/EmojiAttributes.dylib", RTLD_LAZY);
#endif
    MSImageRef ref = MSGetImageByName(realPath2(@"/System/Library/PrivateFrameworks/CoreEmoji.framework/CoreEmoji"));
    copyResourceURLFromFrameworkBundle = (CFURLRef (*)(CFStringRef const, CFStringRef const, CFLocaleRef const))MSFindSymbol(ref, "__ZN3CEM34copyResourceURLFromFrameworkBundleEPK10__CFStringS2_PK10__CFLocale");
    NSString *processName = [[NSProcessInfo processInfo] processName];
    BOOL kbd = stringEqual(processName, @"kbd");
    if (!kbd) {
        %init(UIKit_Common);
        if (isiOS10_2Up) {
            %init(UIKit_iOS10_2Up);
        } else {
            %init(UIKit_iOS10_1);
        }
    }
    if (isiOS10_2Up) {
        %init(EMF_iOS10_2Up);
    }
    %init(EMF_Common);
    if (isiOS11Up)
        EmojiData = (void *(*)(void *, CFURLRef const, CFURLRef const))MSFindSymbol(ref, "__ZN3CEM9EmojiDataC1EPK7__CFURLS3_");
    else
        EmojiData = (void *(*)(void *, CFURLRef const, CFURLRef const))MSFindSymbol(ref, "__ZN3CEM9EmojiDataC2EPK7__CFURLS3_");
    %init(CoreEmoji);
}