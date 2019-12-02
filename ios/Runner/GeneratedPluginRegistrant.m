//
//  Generated file. Do not edit.
//

#import "GeneratedPluginRegistrant.h"
#import <connectivity/ConnectivityPlugin.h>
#import <flutter_qq/FlutterQqPlugin.h>
#import <fluwx/FluwxPlugin.h>
#import <path_provider/PathProviderPlugin.h>
#import <shared_preferences/SharedPreferencesPlugin.h>
#import <sqflite/SqflitePlugin.h>

@implementation GeneratedPluginRegistrant

+ (void)registerWithRegistry:(NSObject<FlutterPluginRegistry>*)registry {
  [FLTConnectivityPlugin registerWithRegistrar:[registry registrarForPlugin:@"FLTConnectivityPlugin"]];
  [FlutterQqPlugin registerWithRegistrar:[registry registrarForPlugin:@"FlutterQqPlugin"]];
  [FluwxPlugin registerWithRegistrar:[registry registrarForPlugin:@"FluwxPlugin"]];
  [FLTPathProviderPlugin registerWithRegistrar:[registry registrarForPlugin:@"FLTPathProviderPlugin"]];
  [FLTSharedPreferencesPlugin registerWithRegistrar:[registry registrarForPlugin:@"FLTSharedPreferencesPlugin"]];
  [SqflitePlugin registerWithRegistrar:[registry registrarForPlugin:@"SqflitePlugin"]];
}

@end
