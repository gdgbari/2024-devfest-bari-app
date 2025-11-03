import 'package:devfest_bari_2025/logic.dart';
import 'package:devfest_bari_2025/ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LeaderboardPage extends StatelessWidget {
  final pageController = PageController();

  LeaderboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20).copyWith(bottom: 0),
          child: BlocConsumer<LeaderboardCubit, LeaderboardState>(
            listenWhen: (previous, current) =>
                previous.pageIndex != current.pageIndex,
            listener: (context, state) {
              pageController.jumpToPage(state.pageIndex);
            },
            builder: (context, state) {
              switch (state.status) {
                case LeaderboardStatus.initial:
                case LeaderboardStatus.fetchInProgress:
                  return Center(child: CustomLoader());
                case LeaderboardStatus.fetchFailure:
                  return Center(
                    child: Text(
                      'The leaderboard\nis not available',
                      style: PresetTextStyle.black23w400,
                      textAlign: TextAlign.center,
                    ),
                  );
                case LeaderboardStatus.fetchSuccess:
                  return state.leaderboard.isOpen
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            CustomSegmentedButton(
                              index: state.pageIndex,
                              onValueChanged: (value) => context
                                  .read<LeaderboardCubit>()
                                  .changeLeaderboard(value),
                            ),
                            const SizedBox(height: 20),
                            Expanded(
                              child: PageView(
                                controller: pageController,
                                physics: const NeverScrollableScrollPhysics(),
                                children: const <Widget>[
                                  UserLeaderboard(),
                                  TeamLeaderboard(),
                                ],
                              ),
                            ),
                          ],
                        )
                      : _LeaderboardClosed(state);
              }
            },
          ),
        ),
      ),
    );
  }
}

class UserLeaderboard extends StatelessWidget {
  const UserLeaderboard({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LeaderboardCubit, LeaderboardState>(
      builder: (context, state) {
        final users = state.leaderboard.users;

        return AnimatedContainer(
          duration: Duration(milliseconds: 100),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Your score',
                style: PresetTextStyle.black23w500,
              ),
              SizedBox(height: 10),
              UserTile(user: state.leaderboard.currentUser),
              SizedBox(height: 20),
              Text(
                'Top users',
                style: PresetTextStyle.black23w500,
              ),
              SizedBox(height: 10),
              Expanded(
                child: ListView.separated(
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.only(
                        bottom: index == users.length - 1 ? 40 : 0,
                      ),
                      child: UserTile(user: users[index]),
                    );
                  },
                  separatorBuilder: (context, index) => SizedBox(height: 10),
                  itemCount: users.length,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class TeamLeaderboard extends StatelessWidget {
  const TeamLeaderboard({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LeaderboardCubit, LeaderboardState>(
      builder: (context, state) {
        final groups = state.leaderboard.groups;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Team rankings',
              style: PresetTextStyle.black23w500,
            ),
            SizedBox(height: 10),
            Expanded(
              child: Column(
                children: <Widget>[
                  ...List<Widget>.generate(
                    groups.length,
                    (index) {
                      return Expanded(
                        child: Container(
                          width: double.maxFinite,
                          margin: EdgeInsets.only(
                            bottom: index != groups.length ? 10 : 0,
                          ),
                          child: GroupTile(
                            group: groups[index],
                            maxScore: state.groupMaxScore,
                          ),
                        ),
                      );
                    },
                  ),
                  SizedBox(height: 40),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}

class _LeaderboardClosed extends StatelessWidget {
  final LeaderboardState state;

  const _LeaderboardClosed(this.state);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text.rich(
        TextSpan(
          text: '🏆 ANNOUNCEMENT 🏆\n\n',
          style: PresetTextStyle.black23w700,
          children: <InlineSpan>[
            TextSpan(
              text: 'The final leaderboard will be shown in ',
              style: PresetTextStyle.black21w400,
              children: <InlineSpan>[
                TextSpan(
                  text: state.leaderboard.winnerRoom,
                  style: PresetTextStyle.black21w700,
                ),
                TextSpan(
                  text: ' at ',
                  style: PresetTextStyle.black21w400,
                ),
                TextSpan(
                  text: state.leaderboard.winnerTime,
                  style: PresetTextStyle.black21w700,
                ),
              ],
            ),
            TextSpan(text: '\n\n'),
            TextSpan(
              text:
                  'Join us to discover the winners and get amazing prizes! 🏅',
              style: PresetTextStyle.black21w400,
            ),
          ],
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
