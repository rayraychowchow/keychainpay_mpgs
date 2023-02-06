package com.keychainpay.keychainpay_mpgs.extension

import io.reactivex.disposables.CompositeDisposable
import io.reactivex.disposables.Disposable

fun Disposable.disposedBy(disposeBag: CompositeDisposable) {
    disposeBag.add(this)
}