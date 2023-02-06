package com.keychainpay.keychainpay_mpgs.service.mpgs

import android.app.Activity
import android.content.Intent
import androidx.activity.ComponentActivity
import androidx.activity.result.ActivityResultLauncher
import com.keychainpay.keychainpay_mpgs.activity.MPGS3DSecureActivity
import com.keychainpay.keychainpay_mpgs.enums.method_channel.card_merchant.mpgs.MethodChannelMpgsRequestKey
import com.keychainpay.keychainpay_mpgs.enums.method_channel.card_merchant.mpgs.convertToMpgsGateInfo
import com.keychainpay.keychainpay_mpgs.models.mpgs.Mpgs3dsInfo
import com.keychainpay.keychainpay_mpgs.models.mpgs.Mpgs3dsResult
import com.keychainpay.keychainpay_mpgs.models.mpgs.MpgsCard
import com.keychainpay.keychainpay_mpgs.models.mpgs.MpgsGatewayInfo
import com.keychainpay.keychainpay_mpgs.utils.safeLet
import com.mastercard.gateway.android.sdk.Gateway
import com.mastercard.gateway.android.sdk.GatewayMap
import io.reactivex.Observable
import io.reactivex.Single
import io.reactivex.subjects.PublishSubject

class MpgsService {
    companion object {
        private var instance: MpgsService? = null

        fun getInstance(): MpgsService {
            if (instance == null) {
                instance = MpgsService()
            }
            return instance!!
        }
    }

    private var on3DSeucreResult: PublishSubject<Mpgs3dsResult>? = PublishSubject.create()

    /**
     * Return a Single of (session ID) when tokenise credit card with mpgs success
     * @param hashMap The hashmap should include mpgs gateway info and card info for
     *                  tokenising with mpgs
     * @return Single of session ID
     */
    fun tokeniseCreditCardWithMpgs(hashMap: HashMap<String, Any>): Single<String> {
        @Suppress("UNCHECKED_CAST")
        return safeLet(hashMap[MethodChannelMpgsRequestKey.MPGS_GATEWAY_INFO.key] as? HashMap<String, Any>,
            hashMap[MethodChannelMpgsRequestKey.CARD_INFO.key] as? HashMap<String, Any>) { mpgsHashMap, cardInfoHashMap ->
            safeLet(MpgsGatewayInfo.mapFromHashMap(mpgsHashMap), MpgsCard.mapFromHashMap(cardInfoHashMap)) { mpgsGatewayInfo, card ->

                val request = GatewayMap().set("sourceOfFunds.provided.card.nameOnCard", card.name)
                    .set("sourceOfFunds.provided.card.number", card.number)
                    .set("sourceOfFunds.provided.card.securityCode", card.cvc)
                    .set("sourceOfFunds.provided.card.expiry.month", card.expirationMonth)
                    .set("sourceOfFunds.provided.card.expiry.year", card.expirationYear)

                val gateway = Gateway()
                gateway.region = mpgsGatewayInfo.region.convertToMpgsGateInfo()
                gateway.merchantId = mpgsGatewayInfo.merchantId
                gateway.updateSession(mpgsGatewayInfo.sessionId, mpgsGatewayInfo.apiVersion, request)
                    .map {
                    mpgsGatewayInfo.sessionId
                }.doOnSuccess {
                    print(it)
                }.doOnError {
                    print(it)
                }
            }?: Single.error(Exception("Mpgs-card_info missing"))
        }?: Single.error(Exception("Mpgs-card_info missing"))
    }

    /**
     * Return an Observable of (Mpgs3dsResult) when tokenise credit card with mpgs success
     * @param data The hashmap should include mpgs 3ds info
     * @param mpgs3DSecureLauncher
     * @param activity
     * @return Observable of Mpgs3dsResult
     */
    fun showMpgs3ds(
        data: HashMap<String, Any>,
        mpgs3DSecureLauncher: ActivityResultLauncher<Intent>,
        activity: ComponentActivity
    ): Observable<Mpgs3dsResult> {

        @Suppress("UNCHECKED_CAST")
        (data[MethodChannelMpgsRequestKey.MPGS_3DS_INFO.key] as? HashMap<String, Any>)?.let { mpgsData ->
            Mpgs3dsInfo.mapFromHashMap(mpgsData)?.let { it ->
                on3DSeucreResult?.onComplete()
                on3DSeucreResult = PublishSubject.create()

                val intent = Intent(activity.applicationContext, MPGS3DSecureActivity::class.java)
                intent.putExtra(MPGS3DSecureActivity.EXTRA_HTML, it.htmlContent)
                mpgs3DSecureLauncher.launch(intent)

                return on3DSeucreResult!!
            } ?: run {
                return Observable.error(Exception("showMpgs3ds Problem with mpgs_3ds_info"))
            }
        } ?: run {
            return Observable.error(Exception("showMpgs3ds Cannot find object with key - mpgs_3ds_info"))
        }
    }

    /**
     * Handle Mpgs 3DSecure Launcher result and emit appropriate result on on3DSeucreResult
     * @param resultCode
     * @param data
     */
    fun handle3ds(resultCode: Int, data: Intent?) {
        if (resultCode == Activity.RESULT_OK) {

            val result = data?.extras?.getString(MPGS3DSecureActivity.EXTRA_ACS_RESULT)
            val isLast3ds = data?.extras?.getBoolean(MPGS3DSecureActivity.EXTRA_ACS_IS_LAST_3DS)

            if (result == null) {
                on3DSeucreResult?.onNext(Mpgs3dsResult("not_authenticated", isLast3ds?: false))
            } else {
                on3DSeucreResult?.onNext(Mpgs3dsResult(result, isLast3ds?: false))
            }
        } else {
            on3DSeucreResult?.onNext(Mpgs3dsResult("not_authenticated", false))
        }
    }
}