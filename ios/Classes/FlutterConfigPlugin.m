#import "FlutterConfigPlugin.h"
#import <flutter_config/flutter_config-Swift.h>

@implementation FlutterConfigPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftFlutterConfigPlugin registerWithRegistrar:registrar];
}
@end
