package com.keychainpay.keychainpay_mpgs.extension

import io.reactivex.Observable
import io.reactivex.Single
import io.reactivex.android.schedulers.AndroidSchedulers
import io.reactivex.schedulers.Schedulers

/**
 *   Useful Extensions for RxJava
 **/

/**
 * An extension for the clumsy background & main thread
 */
fun <T> Single<T>.runInBackground(): Single<T> {
    return this.subscribeOn(Schedulers.io())
        .observeOn(AndroidSchedulers.mainThread())
        .onTerminateDetach()
}

fun <T> Single<T>.onMainThread(): Single<T> {
    return this.observeOn(AndroidSchedulers.mainThread())
}
