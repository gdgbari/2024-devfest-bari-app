import 'dart:convert';

import 'package:devfest_bari_2025/data.dart';
import 'package:equatable/equatable.dart';

class UserProfile extends Equatable {
  final String userId;
  final String nickname;
  final String name;
  final String surname;
  final String email;
  final Group group;
  final int score;

  const UserProfile({
    this.userId = '',
    this.nickname = '',
    this.name = '',
    this.surname = '',
    this.email = '',
    this.group = const Group(),
    this.score = 0,
  });

  UserProfile copyWith({
    String? userId,
    String? nickname,
    String? name,
    String? surname,
    String? email,
    Group? group,
    int? score,
  }) {
    return UserProfile(
      userId: userId ?? this.userId,
      nickname: nickname ?? this.nickname,
      name: name ?? this.name,
      surname: surname ?? this.surname,
      email: email ?? this.email,
      group: group ?? this.group,
      score: score ?? this.score,
    );
  }

  factory UserProfile.fromMap(Map<String, dynamic> map) {
    return UserProfile(
      userId: map['userId'] as String? ?? '',
      nickname: map['nickname'] as String? ?? '',
      name: map['name'] as String? ?? '',
      surname: map['surname'] as String? ?? '',
      email: map['email'] as String? ?? '',
      group: Group.fromMap(Map<String, dynamic>.from(map['group'] ?? {})),
      score: map['score'] as int? ?? 0,
    );
  }

  factory UserProfile.fromJson(String source) =>
      UserProfile.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      userId,
      nickname,
      name,
      surname,
      email,
      group,
      score,
    ];
  }
}
