#import "../PS.h"
#import "../EmojiLibrary/PSEmojiUtilities.h"
#import "../EmojiLibrary/Header.h"

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
    return [PSEmojiUtilities skinToneVariants:emojiString withSelf:YES];
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

CFURLRef (*copyResourceURLFromFrameworkBundle)(CFStringRef const, CFStringRef const, CFLocaleRef const);
%hookf(CFURLRef, copyResourceURLFromFrameworkBundle, CFStringRef const resourceName, CFStringRef const resourceType, CFLocaleRef const locale) {
    CFURLRef url = NULL;
    if (resourceName && resourceType && (CFStringEqual(resourceType, CFSTR("dat")) || CFStringEqual(resourceType, CFSTR("bitmap")) || CFStringEqual(resourceType, CFSTR("strings")))) {
        CFStringRef newResourceName = CFStringEqual(resourceName, CFSTR("emojimeta")) ? CFSTR("emojimeta_legacy") : (__bridge CFStringRef)[(__bridge NSString *)resourceName stringByAppendingString:@"2"];
        url = %orig(newResourceName, resourceType, locale);
    }
    return url ? url : %orig;
}

%end

%ctor {
    dlopen(realPath2(@"/System/Library/PrivateFrameworks/EmojiFoundation.framework/EmojiFoundation"), RTLD_NOW);
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
    %init(CoreEmoji);
}