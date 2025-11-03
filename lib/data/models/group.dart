import 'dart:convert';

import 'package:devfest_bari_2025/ui.dart';
import 'package:equatable/equatable.dart';

class Group extends Equatable {
  final String groupId;
  final String name;
  final String imageUrl;
  final GroupColors colors;
  final int position;
  final int score;

  const Group({
    this.groupId = '',
    this.name = '',
    this.imageUrl = '',
    this.colors = GroupColors.red,
    this.position = 0,
    this.score = 0,
  });

  Group copyWith({
    String? groupId,
    String? name,
    String? imageUrl,
    GroupColors? colors,
    int? position,
    int? score,
  }) {
    return Group(
      groupId: groupId ?? this.groupId,
      name: name ?? this.name,
      imageUrl: imageUrl ?? this.imageUrl,
      colors: colors ?? this.colors,
      position: position ?? this.position,
      score: score ?? this.score,
    );
  }

  factory Group.fromMap(Map<String, dynamic> map) {
    return Group(
      groupId: map['groupId'] as String? ?? '',
      name: map['name'] as String? ?? '',
      imageUrl: map['imageUrl'] as String? ?? '',
      colors: GroupColors.values.singleWhere(
        (element) => element.name == (map['color'] ?? 'black'),
      ),
      position: map['position'] as int? ?? 0,
      score: map['score'] as int? ?? 0,
    );
  }

  factory Group.fromJson(String source) =>
      Group.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      groupId,
      name,
      imageUrl,
      colors,
      position,
      score,
    ];
  }
}
