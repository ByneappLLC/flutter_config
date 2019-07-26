#import <Flutter/Flutter.h>

@interface FlutterConfigPlugin : NSObject<FlutterPlugin>
+ (NSDictionary *)env;
+ (NSString *)envFor: (NSString *)key;
@end
