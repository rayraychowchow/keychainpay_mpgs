import Flutter
import UIKit

public class SwiftKeychainpayMpgsPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "keychainpay_mpgs", binaryMessenger: registrar.messenger())
    let instance = SwiftKeychainpayMpgsPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    MethodChannelCardMerchantManager.shared.handleMethod(call: call, result: result)
  }
}
