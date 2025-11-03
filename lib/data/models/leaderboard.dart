import 'dart:convert';

import 'package:devfest_bari_2025/data.dart';
import 'package:equatable/equatable.dart';

class Leaderboard extends Equatable {
  final LeaderboardUser currentUser;
  final List<LeaderboardUser> users;
  final List<LeaderboardGroup> groups;
  final bool isOpen;
  final String winnerRoom;
  final String winnerTime;

  const Leaderboard({
    this.currentUser = const LeaderboardUser(),
    this.users = const [],
    this.groups = const [],
    this.isOpen = true,
    this.winnerRoom = '',
    this.winnerTime = '',
  });

  Leaderboard copyWith({
    LeaderboardUser? currentUser,
    List<LeaderboardUser>? users,
    List<LeaderboardGroup>? groups,
    bool? isOpen,
    String? winnerRoom,
    String? winnerTime,
  }) {
    return Leaderboard(
      currentUser: currentUser ?? this.currentUser,
      users: users ?? this.users,
      groups: groups ?? this.groups,
      isOpen: isOpen ?? this.isOpen,
      winnerRoom: winnerRoom ?? this.winnerRoom,
      winnerTime: winnerTime ?? this.winnerTime,
    );
  }

  factory Leaderboard.fromMap(Map<String, dynamic> map) {
    return Leaderboard(
      currentUser: LeaderboardUser(),
      users: List<LeaderboardUser>.from(
        List<Map<String, dynamic>>.from(map['users'] ?? []).map(
          (x) => LeaderboardUser.fromMap(x),
        ),
      ),
      groups: List<LeaderboardGroup>.from(
        List<Map<String, dynamic>>.from(map['groups'] ?? []).map(
          (x) => LeaderboardGroup.fromMap(x),
        ),
      ),
      isOpen: map['isOpen'] as bool? ?? true,
      winnerRoom: map['winnerRoom'] as String? ?? '',
      winnerTime: map['winnerTime'] as String? ?? '',
    );
  }

  factory Leaderboard.fromJson(String source) =>
      Leaderboard.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [
        currentUser,
        users,
        groups,
        isOpen,
        winnerRoom,
        winnerTime,
      ];
}
