#import "SocialLoginPlugin.h"
#if __has_include(<social_login_plugin/social_login_plugin-Swift.h>)
#import <social_login_plugin/social_login_plugin-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "social_login_plugin-Swift.h"
#endif

@implementation SocialLoginPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftSocialLoginPlugin registerWithRegistrar:registrar];
}
@end
