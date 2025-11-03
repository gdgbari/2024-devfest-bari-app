import 'package:devfest_bari_2025/data.dart';

class LeaderboardRepository {
  LeaderboardRepository._internal();

  static final LeaderboardRepository _instance =
      LeaderboardRepository._internal();

  factory LeaderboardRepository() => _instance;

  final LeaderboardApi _leaderboardApi = LeaderboardApi();

  Stream<Leaderboard> leaderboardStream(String userId) async* {
    await for (final event in _leaderboardApi.leaderboardStream) {
      int currentUserIndex = -1;
      var currentUser = LeaderboardUser();
      List<LeaderboardUser> leaderboardUsers = [];
      List<LeaderboardGroup> leaderboardGroups = [];
      bool isOpen = true;
      String winnerRoom = '';
      String winnerTime = '';

      for (final child in event.snapshot.children) {
        if (child.value == null) {
          continue;
        }
        switch (child.key) {
          case 'isOpen':
            isOpen = child.value as bool;
            break;
          case 'winnerRoom':
            winnerRoom = child.value as String;
            break;
          case 'winnerTime':
            winnerTime = child.value as String;
            break;
          case 'users':
            final map = child.value as Map;

            final keys = List<String>.from(map.keys);
            final values = List<LeaderboardUser>.from(
              map.values.map(
                (user) => LeaderboardUser.fromMap(
                  Map.from(user),
                ),
              ),
            );

            final temp = Map.fromIterables(keys, values).entries.toList();

            temp.sort(
              (a, b) => b.value.score != a.value.score
                  ? b.value.score.compareTo(a.value.score)
                  : b.value.timestamp != a.value.timestamp
                      ? a.value.timestamp.compareTo(b.value.timestamp)
                      : a.value.nickname.toLowerCase().compareTo(
                            b.value.nickname.toLowerCase(),
                          ),
            );

            final users = Map.fromEntries(temp);

            currentUserIndex = users.keys.toList().indexOf(userId);
            leaderboardUsers = users.values.toList();
            break;
          case 'groups':
            final map = child.value as Map;

            final keys = List<String>.from(map.keys);
            final values = List<LeaderboardGroup>.from(
              map.values.map(
                (group) => LeaderboardGroup.fromMap(
                  Map.from(group),
                ),
              ),
            );

            final temp = Map.fromIterables(keys, values).entries.toList();

            temp.sort(
              (a, b) => b.value.score != a.value.score
                  ? b.value.score.compareTo(a.value.score)
                  : b.value.timestamp != a.value.timestamp
                      ? a.value.timestamp.compareTo(b.value.timestamp)
                      : a.value.name.toLowerCase().compareTo(
                            b.value.name.toLowerCase(),
                          ),
            );

            final groups = Map.fromEntries(temp);

            leaderboardGroups = groups.values.toList();
            break;
          default:
            break;
        }
      }

      for (var i = 0; i < leaderboardUsers.length; i++) {
        leaderboardUsers[i] = leaderboardUsers[i].copyWith(
          position: i + 1,
        );
      }

      for (var i = 0; i < leaderboardGroups.length; i++) {
        leaderboardGroups[i] = leaderboardGroups[i].copyWith(
          position: i + 1,
        );
      }

      currentUser = leaderboardUsers[currentUserIndex];

      final upperLimit = leaderboardUsers.length < 20 ? leaderboardUsers.length : 20;

      yield Leaderboard(
        currentUser: currentUser,
        users: leaderboardUsers.sublist(0, upperLimit),
        groups: leaderboardGroups,
        isOpen: isOpen,
        winnerRoom: winnerRoom,
        winnerTime: winnerTime,
      );
    }
  }
}
