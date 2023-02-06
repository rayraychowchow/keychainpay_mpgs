//
//  MpgsService.swift
//  Runner
//
//  Created by Ray Chow on 25/4/2022.
//

import Foundation
import RxSwift

class MpgsService {
    static let shared = MpgsService()
    private var mpgs3DSecureResult: PublishSubject<Mpgs3DSecureResult>?
    
    /// Returns an observable of MpgsTokeniseResult when tokenise credit card with mpgs success
    ///
    /// - Parameters:
    ///   - data: The data Dictionary should include a MpgsGatewayInfo and a Mpgs Card(Card Info)
    /// - Returns: Returns an observable of MpgsTokeniseResult
    /// - Error: Return an observable error
    func tokeniseCreditCardWithMpgs(data: [String: Any]) -> Observable<MpgsTokeniseResult> {
        //mpgs
        guard let mpgsDict: [String: Any] = data[MethodChannelMpgsRequestKey.mpgsGatewayInfo.rawValue] as? [String: Any],
              let mpgs = MpgsGatewayInfo.mapFromDict(dict: mpgsDict) else {
            return Observable.error(NSError(domain: "Mpgs tokeniseCreditCardWithMpgs", code: -1, userInfo: [NSLocalizedDescriptionKey: "Cannot find object with key - mpgs"]))
        }
        
        //cardInfo
        guard let cardDict: [String: Any] = data[MethodChannelMpgsRequestKey.cardInfo.rawValue] as? [String: Any],
              let card = MpgsCard.mapFromDict(dict: cardDict) else {
            return Observable.error(NSError(domain: "Mpgs tokeniseCreditCardWithMpgs", code: -1, userInfo: [NSLocalizedDescriptionKey: "Cannot find object with key - cardInfo"]))
        }
        
        
        let gateway = Gateway(region: mpgs.region.convertToMpgsGatewayRegion(), merchantId: mpgs.merchantId)
        
        var request = GatewayMap()
        request[at: "sourceOfFunds.provided.card.nameOnCard"] = card.name
        request[at: "sourceOfFunds.provided.card.number"] = card.number
        request[at: "sourceOfFunds.provided.card.securityCode"] = card.cvc
        request[at: "sourceOfFunds.provided.card.expiry.month"] = "\(card.expirationMonth)"
        request[at: "sourceOfFunds.provided.card.expiry.year"] = "\(card.expirationYear)"
        
        return Observable.create({ observer in
            gateway.updateSession(mpgs.sessionId, apiVersion: mpgs.apiVersion, payload: request) { result in
                switch result {
                    case .success(_):
                    observer.onNext(MpgsTokeniseResult(sessionId: mpgs.sessionId))
                        observer.onCompleted()
                    case .error(let error):
                        observer.onError(error)
                }
            }
            return Disposables.create()
        })
    }
    
    /// Returns an observable of Mpgs3dsResult when 3ds Result from Mpgs
    ///
    /// - Parameters:
    ///   - data: The data Dictionary should include a Mpgs3dsInfo
    /// - Returns: Returns an observable of Mpgs3dsResult
    /// - Error: Return an observable error
    func showMpgs3DSecure(data: [String: Any]) -> PublishSubject<Mpgs3DSecureResult> {
        mpgs3DSecureResult?.onCompleted()
        mpgs3DSecureResult = PublishSubject()
        present3DSecurePopup(data: data)
        return mpgs3DSecureResult!
    }
    
    private func present3DSecurePopup(data: [String: Any]) {
        guard let mpgs3dsInfoDict: [String: Any] = data[MethodChannelMpgsRequestKey.mpgs3dsInfo.rawValue] as? [String: Any],
                  let mpgs3dsInfo = Mpgs3DSecureInfo.mapFromDict(dict: mpgs3dsInfoDict) else {
            mpgs3DSecureResult?.onError(NSError(domain: "showMpgs3ds", code: -1, userInfo: [NSLocalizedDescriptionKey: "Cannot find data with key - mpgs_3ds_info"]))
            return
        }
        
        guard let rootVC = AppDelegateUtils.getRootViewController() else {
            mpgs3DSecureResult?.onError(NSError(domain: "showMpgs3ds", code: -1, userInfo: [NSLocalizedDescriptionKey: "Root Contronller not found"]))
            return
        }
        
        let gateway3DSecureViewController = Gateway3DSecureViewController(nibName: nil, bundle: nil)
        gateway3DSecureViewController.modalPresentationStyle = .fullScreen
        rootVC.present(gateway3DSecureViewController, animated: true)
            
            // Optionally customize the presentation
        gateway3DSecureViewController.title = mpgs3dsInfo.title
        gateway3DSecureViewController.navBar.tintColor = UIColor.kpLandlordBlue2
            
            // Start 3D Secure authentication by providing the view with the HTML content provided by the check enrollment step
        gateway3DSecureViewController.authenticatePayer(htmlBodyContent: mpgs3dsInfo.htmlContent, handler: handle3DS(authView:result:))
    }
        
    private func handle3DS(authView: Gateway3DSecureViewController, result: Gateway3DSecureResult) {
        // dismiss the 3DSecureViewController
        authView.dismiss(animated: true, completion: { [weak self] in
            guard let this = self else { return }
            switch result {
            case .completedWithLast3ds(gatewayMap: let gatewayMap):
                this.mpgs3DSecureResult?.onNext(Mpgs3DSecureResult(result: (gatewayMap[Gateway3DSecureViewController.GatewayMapResultKey] as? String) ?? "", isLast3DS: (gatewayMap[Gateway3DSecureViewController.GatewayMapIsLast3dsKey] as? Bool) ?? false))
                break
            case .completed(gatewayResult: let response, let isLast3DS):
                // check for version 46 and earlier api authentication failures and then version 47+ failures
                if let status = response[at: "response.gatewayRecommendation"] as? String, status == "DO_NOT_PROCEED"  {
                    this.mpgs3DSecureResult?.onError(NSError(domain: "handle3DS mpgs", code: -1, userInfo: [NSLocalizedDescriptionKey: "Auth fail"]))
                } else {
                    this.mpgs3DSecureResult?.onNext(Mpgs3DSecureResult(result: "success", isLast3DS: isLast3DS));
                }
                break
            case .error(let error):
                this.mpgs3DSecureResult?.onError(error)
               break
            case .cancelled:
                this.mpgs3DSecureResult?.onNext(Mpgs3DSecureResult(result: "not_authenticated", isLast3DS: false));
                break
            }
        })
    }
}
