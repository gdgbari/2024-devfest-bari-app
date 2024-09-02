import 'package:cloud_functions/cloud_functions.dart';
import 'package:devfest_bari_2024/data.dart';

class TalkApi {
  Future<ServerResponse> getTalkList() async {
    final result = await FirebaseFunctions.instance
        .httpsCallable('getTalkList')
        .call<String>();

    return ServerResponse.fromJson(result.data);
  }
}
