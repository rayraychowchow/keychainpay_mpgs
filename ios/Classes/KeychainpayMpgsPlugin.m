#import "KeychainpayMpgsPlugin.h"
#if __has_include(<keychainpay_mpgs/keychainpay_mpgs-Swift.h>)
#import <keychainpay_mpgs/keychainpay_mpgs-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "keychainpay_mpgs-Swift.h"
#endif

@implementation KeychainpayMpgsPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftKeychainpayMpgsPlugin registerWithRegistrar:registrar];
}
@end
