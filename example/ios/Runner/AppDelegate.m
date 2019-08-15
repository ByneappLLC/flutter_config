#include "AppDelegate.h"
#include "GeneratedPluginRegistrant.h"

// import the plugin
// #import "FlutterConfigPlugin.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application
    didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    // then read individual keys like:
     // NSString *apiUrl = [FlutterConfigPlugin envFor:@"API_URL"];
  [GeneratedPluginRegistrant registerWithRegistry:self];
  // Override point for customization after application launch.
  return [super application:application didFinishLaunchingWithOptions:launchOptions];
}

@end
