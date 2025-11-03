import 'dart:convert';
import 'dart:ui';

import 'package:devfest_bari_2025/ui.dart';
import 'package:equatable/equatable.dart';

class LeaderboardUser extends Equatable {
  final String nickname;
  final int score;
  final int position;
  final Color groupColor;
  final int timestamp;

  const LeaderboardUser({
    this.nickname = '',
    this.score = 0,
    this.position = 999,
    this.groupColor = ColorPalette.black,
    this.timestamp = 0,
  });

  LeaderboardUser copyWith({
    String? nickname,
    int? score,
    int? position,
    Color? groupColor,
    int? timestamp,
  }) {
    return LeaderboardUser(
      nickname: nickname ?? this.nickname,
      score: score ?? this.score,
      position: position ?? this.position,
      groupColor: groupColor ?? this.groupColor,
      timestamp: timestamp ?? this.timestamp,
    );
  }

  factory LeaderboardUser.fromMap(Map<String, dynamic> map) {
    final groupColors = GroupColors.values.singleWhere(
      (element) => element.name == (map['groupColor'] ?? 'black'),
    );
    return LeaderboardUser(
      nickname: map['nickname'] as String? ?? '',
      score: map['score'] as int? ?? 0,
      position: map['position'] as int? ?? 999,
      groupColor: groupColors.primaryColor,
      timestamp: map['timestamp'] as int? ?? 0,
    );
  }

  factory LeaderboardUser.fromJson(String source) =>
      LeaderboardUser.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [nickname, score, position, groupColor, timestamp];
}
