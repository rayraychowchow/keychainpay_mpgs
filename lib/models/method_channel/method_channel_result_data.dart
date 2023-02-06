import 'package:keychainpay_mpgs/enums/method_channel/method_channel_result_key.dart';

class MethodChannelResultData {
  Map data;

  MethodChannelResultData(this.data);

  static MethodChannelResultData fromMap(Map<dynamic, dynamic>? data) {
    Map _data = data?[MethodChannelResultKey.data.getKeyName()] ?? {};
    return MethodChannelResultData(_data);
  }
}
