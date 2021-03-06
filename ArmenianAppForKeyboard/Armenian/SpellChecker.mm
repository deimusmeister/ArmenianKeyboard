//
//  SpellChecker.h
//  Hunspell
//
//  Created by Aaron Signorelli on 11/05/2012.
//

#import "SpellChecker.h"
#import "HunspellBridge.h"


// Private character conversion helper
static char *createCharFromCFStringRef(CFStringRef cfstr);

@implementation SpellChecker


static char *createCharFromCFStringRef(CFStringRef cfstr)
{
//	int len = CFStringGetLength(cfstr);
//	char *resultStr = (char *)malloc(len * sizeof(UniChar));
//	CFStringGetCString(cfstr, resultStr, len * sizeof(UniChar), kCFStringEncodingUTF8);
//	return(resultStr);
    if (cfstr == NULL) {
        return NULL;
    }
    
    CFIndex length = CFStringGetLength(cfstr);
    CFIndex maxSize =
    CFStringGetMaximumSizeForEncoding(length, kCFStringEncodingUTF8) + 1;
    char *buffer = (char *)malloc(maxSize);
    if (CFStringGetCString(cfstr, buffer, maxSize, kCFStringEncodingUTF8)) {
        return buffer;
    }
    return NULL;
}

- (id)init
{
	self = [super init];
	currentLanguage = [NSMutableString stringWithCapacity:16];
	[currentLanguage setString: @""];
	return self;
}

- (void) dealloc
{
	releaseDictionary();
}

- (void)updateLanguage:(NSString *)language
{
	NSComparisonResult comparison = [language compare:currentLanguage];
	
	if (comparison != NSOrderedSame) {
		char *languageCode = createCharFromCFStringRef((__bridge CFStringRef)language);
		bool result = loadDictionary(languageCode);
		if (result) {
			[currentLanguage setString:language];
			NSLog(@"Language updated to [%@].", language);
		} else {
			NSLog(@"Failed to update language to [%@].", language);
		}
	}
}


-(NSArray *) getSuggestionsForWord:(NSString *) word {
    
    NSMutableArray *result;
	char **suggestionsList;
	char *currentWord;
    
	currentWord = createCharFromCFStringRef((__bridge CFStringRef)word);
	int suggestionCount = getSuggestions(currentWord, &suggestionsList);
	
	if (suggestionCount) {		
		result = [[NSMutableArray alloc] initWithCapacity:suggestionCount];
		for (int i = 0; i < suggestionCount; i++) {
			NSString *nsSuggestion = [[NSString alloc] initWithCString:*(suggestionsList + i) 
															   encoding:NSUTF8StringEncoding];
			if (nsSuggestion == NULL) {
				NSLog(@"Failed to convert [%s] to NSString", *(suggestionsList + i));
			}else{
//                NSLog(@"%@", nsSuggestion);
                [result addObject:nsSuggestion];
            }
		}
	} else {
		result = [NSMutableArray array];
	}
	
	free(currentWord);
	releaseSuggestions(suggestionCount, &suggestionsList);
	
	return result;
}

-(BOOL) isSpeltCorrectly:(NSString *) word {
    
	char *currentWord = createCharFromCFStringRef((__bridge CFStringRef)word);    
    BOOL isInDictionary = isSpeltCorrectly(currentWord);
	
    free(currentWord);
    
    return isInDictionary;    
}



@end

