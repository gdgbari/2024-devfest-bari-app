import 'package:cloud_functions/cloud_functions.dart';
import 'package:devfest_bari_2024/data.dart';

class LeaderboardApi {
  Future<ServerResponse> getLeaderboard() async {
    final result = await FirebaseFunctions.instance
        .httpsCallable('getLeaderboard')
        .call<String>();

    return ServerResponse.fromJson(result.data);
  }
}