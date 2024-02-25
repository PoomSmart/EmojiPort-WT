#import <PSHeader/PS.h>
#import <EmojiLibrary/PSEmojiUtilities.h>
#import <EmojiLibrary/Header.h>
#import <dlfcn.h>
#import <HBLog.h>
#import <version.h>

%config(generator=MobileSubstrate)

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

+ (BOOL)_genderEmojiBaseStringNeedVariantSelector:(NSString *)emojiBaseString {
    return [PSEmojiUtilities genderEmojiBaseStringNeedVariantSelector:emojiBaseString];
}

+ (BOOL)_hasSkinToneVariantsForString:(NSString *)emojiString {
    return [PSEmojiUtilities hasSkinToneVariants:emojiString];
}

+ (NSArray <NSString *> *)_skinToneVariantsForString:(NSString *)emojiString {
    return [PSEmojiUtilities skinToneVariantsForString:emojiString];
}

%end

%end

%group EMF_Common

%hook EMFEmojiCategory

- (NSMutableArray <EMFEmojiToken *> *)emojiTokensForLocaleData:(EMFEmojiLocaleData *)localeData {
    NSString *identifier = self.identifier;
    NSMutableArray <EMFEmojiToken *> *tokens = [NSMutableArray array];
    NSArray <NSString *> *emojis = nil;
    if ([identifier isEqualToString:@"EMFEmojiCategoryPrepopulated"])
        emojis = [PSEmojiUtilities PrepolulatedEmoji];
    else if ([identifier isEqualToString:@"EMFEmojiCategoryPeople"])
        emojis = [PSEmojiUtilities PeopleEmoji];
    else if ([identifier isEqualToString:@"EMFEmojiCategoryNature"])
        emojis = [PSEmojiUtilities NatureEmoji];
    else if ([identifier isEqualToString:@"EMFEmojiCategoryFoodAndDrink"])
        emojis = [PSEmojiUtilities FoodAndDrinkEmoji];
    else if ([identifier isEqualToString:@"EMFEmojiCategoryActivity"])
        emojis = [PSEmojiUtilities ActivityEmoji];
    else if ([identifier isEqualToString:@"EMFEmojiCategoryTravelAndPlaces"])
        emojis = [PSEmojiUtilities TravelAndPlacesEmoji];
    else if ([identifier isEqualToString:@"EMFEmojiCategoryObjects"])
        emojis = [PSEmojiUtilities ObjectsEmoji];
    else if ([identifier isEqualToString:@"EMFEmojiCategorySymbols"])
        emojis = [PSEmojiUtilities SymbolsEmoji];
    for (NSString *emoji in emojis)
        [tokens addObject:[%c(EMFEmojiToken) emojiTokenWithString:emoji localeData:localeData]];
    return tokens;
}

%end

%hook EMFEmojiToken

- (BOOL)supportsSkinToneVariants {
    return [PSEmojiUtilities hasSkinToneVariants:[self valueForKey:@"_string"]];
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
    return preventFirst && emojiString.length >= 4 && [PSEmojiUtilities isProfessionEmoji:baseEmoji = [PSEmojiUtilities professionSkinToneEmojiBaseKey:emojiString]] ? baseEmoji : %orig;
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

%hookf(CFURLRef, copyResourceURLFromFrameworkBundle, CFStringRef const resourceName, CFStringRef const resourceType, CFLocaleRef const locale) {
    CFURLRef url = NULL;
    if (resourceName && resourceType && (CFStringEqual(resourceType, CFSTR("dat")) || CFStringEqual(resourceType, CFSTR("bitmap")) || CFStringEqual(resourceType, CFSTR("strings")))) {
        CFMutableStringRef newResourceName = NULL;
        if (!CFStringEqual(resourceName, CFSTR("emojimeta")) && !CFStringEqual(resourceName, CFSTR("Emoticons"))) {
            newResourceName = CFStringCreateMutableCopy(kCFAllocatorDefault, CFStringGetLength(resourceName), resourceName);
            if (CFStringEqual(resourceName, CFSTR("FindReplace")) || CFStringEqual(resourceName, CFSTR("FindReplace-en")) || CFStringEqual(resourceName, CFSTR("CharacterPicker")))
                CFStringAppend(newResourceName, CFSTR("_16"));
            else
                CFStringAppend(newResourceName, CFSTR("2"));
        }
        url = %orig(newResourceName ? newResourceName : (IS_IOS_OR_NEWER(iOS_10_2) ? CFSTR("emojimeta_1") : CFSTR("emojimeta_0")), resourceType, locale);
        if (newResourceName)
            CFRelease(newResourceName);
    }
    return url ? url : %orig;
}

%end

%group CoreEmoji_10_1_1

void read_str(FILE *fp, char *str) {
    char b;
    size_t n = 0;
    while ((b = fgetc(fp)) != EOF && b != '\0')
        str[n++] = (unsigned char)b;
    str[n] = '\0';
}

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
    FILE *newmeta = fopen(realPath2(@"/System/Library/PrivateFrameworks/CoreEmoji.framework/emojimeta_2.dat"), "rb");
    if (newmeta == NULL) {
        HBLogError(@"Error: Cannot open emojimeta_2.dat");
        return orig;
    }
    int totalCount = 0;
    fread(&totalCount, 2, 1, newmeta);
    uint32_t metaptr = 8 + (3206 * 16);
    uint32_t metadata[4];
    char emoji[64];
    for (int index = 3206; index <= totalCount; ++index) {
        fseek(newmeta, metaptr, SEEK_SET);
        fread(metadata, sizeof(uint32_t), 4, newmeta);
        fseek(newmeta, metadata[2], SEEK_SET);
        read_str(newmeta, emoji);
        CFStringRef cfEmoji = CFStringCreateWithCString(kCFAllocatorDefault, emoji, kCFStringEncodingUTF8);
        if (cfEmoji != NULL) {
            CFArrayAppendValue(*data, cfEmoji);
            CFRelease(cfEmoji);
        }
        metaptr += 16;
    }
    fclose(newmeta);
    *count = CFArrayGetCount(*data);
    return orig;
}

%end

%ctor {
    dlopen(realPath2(@"/System/Library/PrivateFrameworks/EmojiFoundation.framework/EmojiFoundation"), RTLD_NOW);
    MSImageRef ref = MSGetImageByName(realPath2(@"/System/Library/PrivateFrameworks/CoreEmoji.framework/CoreEmoji"));
    CFURLRef (*copyResourceURLFromFrameworkBundle_p)(CFStringRef const, CFStringRef const, CFLocaleRef const) = NULL;
    copyResourceURLFromFrameworkBundle_p = (typeof(copyResourceURLFromFrameworkBundle_p))MSFindSymbol(ref, "__ZN3CEM34copyResourceURLFromFrameworkBundleEPK10__CFStringS2_PK10__CFLocale");
    NSString *processName = [[NSProcessInfo processInfo] processName];
    BOOL kbd = [processName isEqualToString:@"kbd"];
    if (!kbd) {
        %init(UIKit_Common);
        if (IS_IOS_OR_NEWER(iOS_10_2)) {
            %init(UIKit_iOS10_2Up);
        } else {
            %init(UIKit_iOS10_1);
        }
    }
    if (IS_IOS_OR_NEWER(iOS_10_2)) {
        %init(EMF_iOS10_2Up);
    } else {
        %init(CoreEmoji_10_1_1);
    }
    %init(EMF_Common);
    %init(CoreEmoji, copyResourceURLFromFrameworkBundle = (void *)copyResourceURLFromFrameworkBundle_p);
}