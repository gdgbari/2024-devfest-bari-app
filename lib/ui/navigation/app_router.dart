import 'package:devfest_bari_2024/ui.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorKey = GlobalKey<NavigatorState>();

final appRouter = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: RouteNames.welcomeRoute.path,
  routes: <RouteBase>[
    GoRoute(
      name: RouteNames.welcomeRoute.name,
      path: RouteNames.welcomeRoute.path,
      builder: (context, state) => const WelcomePage(),
    ),
    GoRoute(
      name: RouteNames.loginRoute.name,
      path: RouteNames.loginRoute.path,
      builder: (context, state) => LoginPage(),
    ),
    GoRoute(
      name: RouteNames.signUpRoute.name,
      path: RouteNames.signUpRoute.path,
      builder: (context, state) => SignUpPage(),
    ),
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return NavigationBarPage(navigationShell: navigationShell);
      },
      branches: <StatefulShellBranch>[
        StatefulShellBranch(
          navigatorKey: _shellNavigatorKey,
          initialLocation: RouteNames.leaderboardRoute.path,
          routes: <RouteBase>[
            GoRoute(
              name: RouteNames.leaderboardRoute.name,
              path: RouteNames.leaderboardRoute.path,
              builder: (context, state) => const LeaderboardPage(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: <RouteBase>[
            GoRoute(
              name: RouteNames.profileRoute.name,
              path: RouteNames.profileRoute.path,
              builder: (context, state) => const ProfilePage(),
            ),
          ],
        ),
      ],
    ),
    GoRoute(
      name: RouteNames.qrCodeRoute.name,
      path: RouteNames.qrCodeRoute.path,
      builder: (context, state) => QrCodePage(),
    ),
    GoRoute(
      name: RouteNames.quizRoute.name,
      path: RouteNames.quizRoute.path,
      builder: (context, state) => QuizPage(),
    ),
  ],
);
