package com.keychainpay.keychainpay_mpgs

import android.annotation.SuppressLint
import android.content.Intent
import androidx.activity.result.ActivityResultLauncher
import androidx.activity.result.contract.ActivityResultContracts
import androidx.annotation.NonNull
import com.keychainpay.keychainpay_mpgs.manager.card_merchant.mpgs.MpgsMerchantManager
import com.keychainpay.keychainpay_mpgs.manager.method_channel.card_merchant.MethodChannelCardMerchantManager
import io.flutter.embedding.android.FlutterFragmentActivity
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result

/** KeychainpayMpgsPlugin */
class KeychainpayMpgsPlugin: FlutterPlugin, MethodCallHandler, ActivityAware {
  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  private lateinit var channel : MethodChannel
  private lateinit var mpgs3DSecureLauncher: ActivityResultLauncher<Intent>
  private var initializationError: String? = null
  private lateinit var flutterFragmentActivity: FlutterFragmentActivity

  override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    channel = MethodChannel(flutterPluginBinding.binaryMessenger, "keychainpay_mpgs")
    channel.setMethodCallHandler(this)
  }

  override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
    initializationError?.let{
      result.error(
                "flutter_stripe initialization failed",
                "The plugin failed to initialize: $initializationError",
                null
            )
            return
    }
    MethodChannelCardMerchantManager.getInstance().handleMethod(call, result, flutterFragmentActivity, mpgs3DSecureLauncher)
  }

  override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
  }

  private fun createMpgs3DSecureLauncher(): ActivityResultLauncher<Intent> {
    return flutterFragmentActivity.registerForActivityResult(ActivityResultContracts.StartActivityForResult()) { result ->
        MpgsMerchantManager.getInstance().handle3ds(result.resultCode, result.data)
    }
  }

  @SuppressLint("RestrictedApi")
  override fun onAttachedToActivity(binding: ActivityPluginBinding) {
    when (binding.activity) {
        !is FlutterFragmentActivity -> {
          initializationError =
            "Your Main Activity ${binding.activity.javaClass} is not a subclass FlutterFragmentActivity."
        }
      else -> {
        binding.activity.let {
          if(it is FlutterFragmentActivity) {
            flutterFragmentActivity = it
            mpgs3DSecureLauncher = createMpgs3DSecureLauncher()
          }
        }
      }
    }
  }

  override fun onDetachedFromActivityForConfigChanges() {
  }

  override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
  }

  override fun onDetachedFromActivity() {
  }
}
