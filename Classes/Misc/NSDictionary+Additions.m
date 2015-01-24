#import "NSDictionary+Additions.h"


@implementation NSDictionary (Additions)

- (BOOL)boolForKey:(NSString *)defaultName
{
  id value = [self valueForKey:defaultName];
  if (![value isKindOfClass:[NSNumber class]])
    return NO;
  return [value boolValue];
}

- (NSString *)stringForKey:(NSString *)defaultName
{
  id value = [self valueForKey:defaultName];
  if (![value isKindOfClass:[NSString class]])
    return nil;
  return value;
}

- (NSInteger)integerForKey:(NSString *)defaultName
{
  id value = [self valueForKey:defaultName];
  if (![value isKindOfClass:[NSString class]] && 
      ![value isKindOfClass:[NSNumber class]])
    return 0;
  return [value integerValue];
}

@end
