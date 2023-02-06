import 'dart:async';

import 'package:flutter/services.dart';
import 'package:keychainpay_mpgs/enums/method_channel/card_merchant/common/method_channel_card_merchant_method_key.dart';
import 'package:keychainpay_mpgs/enums/method_channel/card_merchant/mpgs/method_channel_mpgs_gateway_region.dart';
import 'package:keychainpay_mpgs/enums/method_channel/card_merchant/mpgs/method_channel_mpgs_request_key.dart';
import 'package:keychainpay_mpgs/exception/mpgs_native_exception.dart';
import 'package:keychainpay_mpgs/models/credit_card/credit_card_info.dart';
import 'package:keychainpay_mpgs/models/method_channel/method_channel_result_data.dart';
import 'package:keychainpay_mpgs/models/mpgs/mpgs_3d_secure_info.dart';
import 'package:keychainpay_mpgs/models/mpgs/mpgs_3d_secure_result.dart';
import 'package:keychainpay_mpgs/models/mpgs/mpgs_gateway_info.dart';
import 'package:keychainpay_mpgs/models/mpgs/tokenise_with_mpgs_result.dart';
import 'package:keychainpay_mpgs/extension/map_ext_data_package.dart';

class KeychainpayMpgs {
  static const MethodChannel _channel = MethodChannel('keychainpay_mpgs');

  /// Tokenise credit card with mpgs
  /// Params [cardInfo], [gatewayInfo]
  /// Return [sessionId]
  /// Throw [MpgsNativeException] when data is empty or error return from Method Channel
  // todo: param for mpgs gateway info
  static Future<TokeniseWithMpgsResult> tokeniseWithMpgs(
      MpgsCreditCardInfo cardInfo, MpgsGatewayInfo gatewayInfo) {
    try {
      return _channel
          .invokeMapMethod(
              MethodChannelMethodKey.tokeniseWithMpgs.getKeyName(),
              {
                MethodChannelMpgsRequestKey.cardInfo.getKeyName():
                    cardInfo.toJson(),
                MethodChannelMpgsRequestKey.mpgsGatewayInfo.getKeyName():
                    gatewayInfo.toJson()
              }.convetToDataPackage())
          .then((result) {
        MethodChannelResultData resultData =
            MethodChannelResultData.fromMap((result));

        if (resultData.data.isNotEmpty) {
          var tokeniseWithMpgsResult =
              TokeniseWithMpgsResult.fromMap(resultData.data);

          if (tokeniseWithMpgsResult.checkDataIsCompleted()) {
            return tokeniseWithMpgsResult;
          } else {
            throw throwError(-1, "Data is Empty");
          }
        } else {
          throw throwError(-1, "Data is Empty");
        }
      });
    } on PlatformException catch (e) {
      throw ArgumentError("Tokenise fail: ${e.message}");
    }
  }

  /// Show 3ds Page for mpgs
  /// Params [Mpgs3DSecureInfo]
  /// Return [Mpgs3DSecureResult]
  /// Throw [MpgsNativeException] when data is empty or error return from Method Channel
  static Stream<Mpgs3DSecureResult> showMpgs3ds(Mpgs3DSecureInfo mpgs3dsInfo) {
    return Stream.fromFuture(_channel.invokeMapMethod(
            MethodChannelMethodKey.showMpgs3DSecure.getKeyName(),
            mpgs3dsInfo.toJson().convetToDataPackage()))
        .map((result) {
      MethodChannelResultData resultData =
          MethodChannelResultData.fromMap((result));

      if (resultData.data.isNotEmpty) {
        var mpgs3dsResult = Mpgs3DSecureResult.fromMap(resultData.data);

        if (mpgs3dsResult.checkDataIsCompleted()) {
          return mpgs3dsResult;
        } else {
          throw throwError(-1, "Data is Empty");
        }
      } else {
        throw throwError(-1, "Data is Empty");
      }
    });
  }

  static MpgsNativeException throwError(int? code, String? reason) {
    return MpgsNativeException(code ?? -1, reason ?? "Unknown Error");
  }

  static MethodChannelMpgsGatewayRegion getMpgsRegion(bool isProd) {
    return isProd
        ? MethodChannelMpgsGatewayRegion.asiaPacific
        : MethodChannelMpgsGatewayRegion.mtf;
  }
}
