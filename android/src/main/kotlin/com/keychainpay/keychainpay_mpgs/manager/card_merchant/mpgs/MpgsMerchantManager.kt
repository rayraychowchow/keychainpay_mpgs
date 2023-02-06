package com.keychainpay.keychainpay_mpgs.manager.card_merchant.mpgs

import android.content.Intent
import androidx.activity.ComponentActivity
import androidx.activity.result.ActivityResultLauncher
import com.keychainpay.keychainpay_mpgs.manager.method_channel.base.BaseMethodChannelManager
import com.keychainpay.keychainpay_mpgs.models.mpgs.Mpgs3dsResult
import com.keychainpay.keychainpay_mpgs.models.mpgs.MpgsTokeniseResult
import com.keychainpay.keychainpay_mpgs.service.mpgs.MpgsService
import io.reactivex.Observable
import io.reactivex.Single

class MpgsMerchantManager: BaseMethodChannelManager() {
    companion object {
        private var instance: MpgsMerchantManager? = null

        fun getInstance(): MpgsMerchantManager {
            if (instance == null) {
                instance = MpgsMerchantManager()
            }
            return instance!!
        }
    }

    fun tokeniseCreditCardWithMpgs(hashMap: HashMap<String, Any>): Single<MpgsTokeniseResult> {
        return MpgsService.getInstance().tokeniseCreditCardWithMpgs(hashMap).map {
            MpgsTokeniseResult(it)
        }
    }

    fun showMpgs3ds(
        hashMap: HashMap<String, Any>,
        mpgs3DSecureLauncher: ActivityResultLauncher<Intent>,
        activity: ComponentActivity
    ): Observable<Mpgs3dsResult> {
        return MpgsService.getInstance().showMpgs3ds(hashMap, mpgs3DSecureLauncher, activity)
    }

    fun handle3ds(resultCode: Int, data: Intent?) {
        MpgsService.getInstance().handle3ds(resultCode, data)
    }
}