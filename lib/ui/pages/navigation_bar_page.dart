import 'package:devfest_bari_2025/logic.dart';
import 'package:devfest_bari_2025/ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class NavigationBarPage extends StatelessWidget {
  const NavigationBarPage({
    super.key,
    required this.navigationShell,
  });

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    return BlocListener<InternetCubit, InternetState>(
      listener: (context, state) {
        if (state is InternetConnected) {
          navigationShell.goBranch(0, initialLocation: true);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: ColorPalette.black,
          title: const Text(
            'DevFest Bari 2025',
            style: PresetTextStyle.white21w500,
          ),
          centerTitle: true,
          leading: Visibility(
            visible: navigationShell.currentIndex == 1,
            child: GestureDetector(
              onTap: () => context.pushNamed(RouteNames.easterEggRoute.name),
              child: Container(
                color: ColorPalette.black,
              ),
            ),
          ),
          actions: <Widget>[
            BlocBuilder<ContestRulesCubit, ContestRulesState>(
              builder: (context, state) {
                return Visibility(
                  visible: navigationShell.currentIndex == 0 &&
                      state.rules.showRules,
                  child: IconButton(
                    onPressed: () => showContestRulesDialog(
                      context,
                      state.rules.title,
                      state.rules.content,
                    ),
                    icon: Icon(
                      Icons.info_outline,
                      color: ColorPalette.white,
                    ),
                  ),
                );
              },
            ),
            Visibility(
              visible: navigationShell.currentIndex == 1,
              child: IconButton(
                onPressed: () => context.read<AuthenticationCubit>().signOut(),
                icon: const Icon(
                  Icons.logout,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
        body: navigationShell,
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            context.read<QrCodeCubit>().resetQrCode();
            context.read<QuizCubit>().resetQuiz();
            context.pushNamed(RouteNames.qrCodeRoute.name);
          },
          elevation: 1,
          backgroundColor: ColorPalette.coreRed,
          splashColor: ColorPalette.pastelRed,
          shape: const CircleBorder(),
          child: const Icon(
            Icons.qr_code_scanner_rounded,
            color: Colors.white,
            size: 26,
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: ColorPalette.gray,
          selectedItemColor: ColorPalette.coreRed,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.leaderboard),
              label: 'Leaderboard',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile',
            ),
          ],
          currentIndex: navigationShell.currentIndex,
          onTap: (int index) => _onTap(context, index),
        ),
      ),
    );
  }

  void _onTap(BuildContext context, int index) {
    navigationShell.goBranch(
      index,
      initialLocation: index == navigationShell.currentIndex,
    );
  }
}
