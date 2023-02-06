import 'package:keychainpay_mpgs/enums/method_channel/method_channel_request_key.dart';

extension DataPackage on Map {
  Map convetToDataPackage() {
    return {MethodChannelRequestKey.data.getKeyName(): this};
  }
}
