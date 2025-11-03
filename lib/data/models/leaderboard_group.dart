import 'dart:convert';
import 'dart:ui';

import 'package:devfest_bari_2025/ui.dart';
import 'package:equatable/equatable.dart';

class LeaderboardGroup extends Equatable {
  final String name;
  final int score;
  final int position;
  final Color color;
  final int timestamp;

  const LeaderboardGroup({
    this.name = '',
    this.score = 0,
    this.position = 999,
    this.color = ColorPalette.black,
    this.timestamp = 0,
  });

  LeaderboardGroup copyWith({
    String? name,
    int? score,
    int? position,
    Color? color,
    int? timestamp,
  }) {
    return LeaderboardGroup(
      name: name ?? this.name,
      score: score ?? this.score,
      position: position ?? this.position,
      color: color ?? this.color,
      timestamp: timestamp ?? this.timestamp,
    );
  }

  factory LeaderboardGroup.fromMap(Map<String, dynamic> map) {
    final groupColors = GroupColors.values.singleWhere(
      (element) => element.name == (map['color'] ?? 'black'),
    );
    return LeaderboardGroup(
      name: map['name'] as String? ?? '',
      score: map['score'] as int? ?? 0,
      position: map['position'] as int? ?? 999,
      color: groupColors.primaryColor,
      timestamp: map['timestamp'] as int? ?? 0,
    );
  }

  factory LeaderboardGroup.fromJson(String source) =>
      LeaderboardGroup.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [name, score, position, color, timestamp];
}
