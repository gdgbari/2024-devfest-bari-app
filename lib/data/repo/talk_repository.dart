import 'dart:convert';

import 'package:devfest_bari_2024/data.dart';

class TalkRepository {
  TalkRepository._internal();

  static final TalkRepository _instance = TalkRepository._internal();

  factory TalkRepository() => _instance;

  final _talkApi = TalkApi();

  Future<List<Talk>> getTalkList() async {
    try {
      final response = await _talkApi.getTalkList();

      if (response.error.code.isNotEmpty) {
        // TODO: handle errors
        throw UnknownTalkError();
      }

      final List<dynamic> rawTalkList = jsonDecode(response.data);

      return List<Talk>.from(
        rawTalkList.map((rawTalk) => Talk.fromMap(rawTalk)),
      );
    } on Exception {
      throw UnknownTalkError();
    }
  }
}
