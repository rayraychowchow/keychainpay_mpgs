package com.keychainpay.keychainpay_mpgs.activity


import android.annotation.SuppressLint
import android.app.Activity
import android.content.Intent
import android.net.Uri
import android.os.Bundle
import android.util.Base64
import android.util.Log
import android.webkit.*
import com.keychainpay.keychainpay_mpgs.R
import com.keychainpay.keychainpay_mpgs.extension.isNotNullOrEmpty
import kotlinx.android.synthetic.main.activity_mpgs_3d_secure.*

class JSInterface(val activity: MPGS3DSecureActivity) {
    @JavascriptInterface
    fun on3dsResult(result: String, isLast3ds: String) {
        val mpgs3DSResult = MPGS3DSecureActivity.MPGSParams()
        mpgs3DSResult.result = result
        mpgs3DSResult.isLast3ds = isLast3ds.lowercase() == "true"
        activity.complete(mpgs3DSResult)
    }
}

class MPGS3DSecureActivity: Activity() {
    var hasResult = false
    data class MPGSParams(
        var result: String? = null,
        var isLast3ds: Boolean? = null
    )

    @SuppressLint("SetJavaScriptEnabled")
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_mpgs_3d_secure)

        webViewMPGS.webChromeClient = WebChromeClient()
        webViewMPGS.webViewClient = WebViewClient()
        webViewMPGS.settings.domStorageEnabled = true
        webViewMPGS.settings.javaScriptEnabled = true
        webViewMPGS.addJavascriptInterface(JSInterface(this), "android")
//        val listener =
//            WebViewCompat.WebMessageListener { view, message, sourceOrigin, isMainFrame, replyProxy ->
//                Log.i("try", message.toString())
//            }
//        if (WebViewFeature.isFeatureSupported(WebViewFeature.WEB_MESSAGE_LISTENER)) {
//            WebViewCompat.addWebMessageListener(webViewMPGS, "android", setOf(),listener)
//        }

        init()
    }

    private fun init() {
        // init html
        val extraHtml = getExtraHtml()
        if (extraHtml == null) {
            onBackPressed()
            return
        } else {
            setWebViewHtml(extraHtml)
        }
    }

    private fun buildWebViewClient():  WebViewClient {

        return object : WebViewClient() {

//            override fun doUpdateVisitedHistory(view: WebView?, url: String?, isReload: Boolean) {
//                super.doUpdateVisitedHistory(view, url, isReload)
//                webViewUrlChanges(Uri.parse(url))
//            }
        }
    }

    private fun getExtraHtml(): String? {
        val extras = intent.extras
        return extras?.getString(EXTRA_HTML)
    }

    private fun setWebViewHtml(html: String) {
        val encoded = Base64.encodeToString(html.toByteArray(), Base64.NO_PADDING or Base64.NO_WRAP)
        webViewMPGS.loadData(encoded, "text/html", "base64")
    }

    private fun webViewUrlChanges(uri: Uri) : Boolean {

        val host = uri.host
        val scheme = uri.scheme

        if (REDIRECT_SCHEME.equals(scheme, ignoreCase = true) && host != null) {
            val acsResult = getACSResultFromUri(uri)
            if (acsResult.result.isNotNullOrEmpty()) {
                complete(acsResult)
                return false
            }
        }
        return true
    }

    private fun getACSResultFromUri(uri: Uri): MPGSParams {
        val result = MPGSParams()
        val params = uri.queryParameterNames
        for (param in params) {
            Log.i("getACSResultFromUri", uri.getQueryParameter(param).toString())

            if (PARAM_RESULT.equals(param, ignoreCase = true)) {
                result.result = uri.getQueryParameter(param)
            }

            if (PARAM_LAST_3DS.equals(param, ignoreCase = true)) {
                result.isLast3ds = uri.getQueryParameter(param).equals("true", ignoreCase = true)
            }
        }
        return result
    }

     fun complete(acsResult: MPGSParams) {
         if (hasResult) {
             return
         }
         hasResult = true
         val intent = Intent()
         intent.putExtra(EXTRA_ACS_RESULT, acsResult.result)
         intent.putExtra(EXTRA_ACS_IS_LAST_3DS, acsResult.isLast3ds)

         setResult(Activity.RESULT_OK, intent)
         finish()
    }

    companion object {
        const val EXTRA_HTML = "com.mastercard.gateway.android.HTML"

        const val EXTRA_ACS_RESULT = "com.mastercard.gateway.android.ACS_RESULT"
        const val EXTRA_ACS_IS_LAST_3DS = "com.mastercard.gateway.android.ACS_IS_LAST_3DS"
        const val REDIRECT_SCHEME = "https"
        const val MPGS_ACTIVITY_REQUEST_CODE = 101

        const val PARAM_RESULT = "result"
        const val PARAM_LAST_3DS = "isLast3ds"
    }
}