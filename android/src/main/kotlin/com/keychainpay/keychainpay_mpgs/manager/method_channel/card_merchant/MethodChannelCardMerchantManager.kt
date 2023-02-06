package com.keychainpay.keychainpay_mpgs.manager.method_channel.card_merchant

import android.content.Intent
import androidx.activity.result.ActivityResultLauncher
import androidx.annotation.NonNull
import com.keychainpay.keychainpay_mpgs.enums.method_channel.card_merchant.common.method_key.MethodChannelCardMerchantMethodKey
import com.keychainpay.keychainpay_mpgs.enums.method_channel.common.MethodChannelRequestKey
import com.keychainpay.keychainpay_mpgs.extension.disposedBy
import com.keychainpay.keychainpay_mpgs.extension.runInBackground
import com.keychainpay.keychainpay_mpgs.manager.card_merchant.mpgs.MpgsMerchantManager
import com.keychainpay.keychainpay_mpgs.manager.method_channel.base.BaseMethodChannelManager
import io.flutter.embedding.android.FlutterFragmentActivity
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel.Result
import io.reactivex.disposables.CompositeDisposable

class MethodChannelCardMerchantManager: BaseMethodChannelManager() {
    val disposeBag = CompositeDisposable()
    companion object {
        private var instance: MethodChannelCardMerchantManager? = null

        fun getInstance(): MethodChannelCardMerchantManager {
            if (instance == null) {
                instance = MethodChannelCardMerchantManager()
            }
            return instance!!
        }
    }

    fun handleMethod(@NonNull call: MethodCall, @NonNull result: Result, activity: FlutterFragmentActivity, mpgs3DSecureLauncher: ActivityResultLauncher<Intent>) {
        val method = MethodChannelCardMerchantMethodKey.values()
            .firstOrNull { methodKey -> methodKey.key == call.method }?: run {
                result.notImplemented()
                return
            }
        val data: HashMap<String, Any> = call.argument(MethodChannelRequestKey.DATA.key)?: run {
            result.error("-1", "Cannot find object with key - data", null)
            return
        }

        when (method) {
            //MPGS
            MethodChannelCardMerchantMethodKey.TOKENISE_WITH_MPGS -> {
                MpgsMerchantManager.getInstance().tokeniseCreditCardWithMpgs(data)
                    .runInBackground()
                    .subscribe({
                        result.success(mapToMethodChannelDataMap(it.convertToHashMap()))
                    }, {
                        result.error("-1", it.localizedMessage, null)
                    }).disposedBy(disposeBag)
            }
            MethodChannelCardMerchantMethodKey.SHOW_MPGS_3DS -> {
                MpgsMerchantManager.getInstance().showMpgs3ds(data, mpgs3DSecureLauncher, activity)
                    .subscribe({
                        result.success(mapToMethodChannelDataMap(it.convertToHashMap()))
                    },{
                        result.error("-1", it.localizedMessage, null)
                    })
                    .disposedBy(disposeBag)
            }
            else -> result.notImplemented()
        }
    }
}