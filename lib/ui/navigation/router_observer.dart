import 'package:devfest_bari_2025/ui.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

class RouterObserver extends NavigatorObserver {
  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    print(
      'RouterObserver: didPush PREVIOUS ROUTE: ${previousRoute?.settings.name} CURRENT ROUTE: ${route.settings.name}',
    );
    Future.delayed(
      const Duration(milliseconds: 0),
      () => _setSystemUIColor(route.settings.name),
    );
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    print(
      'RouterObserver: didPop PREVIOUS ROUTE: ${route.settings.name} CURRENT ROUTE: ${previousRoute?.settings.name}',
    );
    Future.delayed(
      const Duration(milliseconds: 0),
      () {
        if (route.settings.name == 'signUpRoute') {
          SystemChrome.setSystemUIOverlayStyle(
            const SystemUiOverlayStyle(
              systemNavigationBarColor: ColorPalette.seaBlue,
            ),
          );
        }
        if (route.settings.name == 'qrCodeRoute') {
          SystemChrome.setSystemUIOverlayStyle(
            const SystemUiOverlayStyle(
              systemNavigationBarColor: ColorPalette.gray,
            ),
          );
        }
        if (route.settings.name == 'quizRoute') {
          SystemChrome.setSystemUIOverlayStyle(
            const SystemUiOverlayStyle(
              systemNavigationBarColor: ColorPalette.gray,
            ),
          );
        }
      },
    );
  }

  @override
  void didRemove(Route<dynamic> route, Route<dynamic>? previousRoute) {
    print(
      'RouterObserver: didRemove PREVIOUS ROUTE: ${previousRoute?.settings.name} CURRENT ROUTE: ${route.settings.name}',
    );
  }

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    print(
      'RouterObserver: didReplace OLD ROUTE: ${oldRoute?.settings.name} NEW ROUTE: ${newRoute?.settings.name}',
    );
  }
}

void _setSystemUIColor(String? routeName) {
  switch (routeName) {
    case 'noInternetRoute':
      SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(
          systemNavigationBarColor: ColorPalette.white,
        ),
      );
      break;
    case 'welcomeRoute':
      SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(
          systemNavigationBarColor: ColorPalette.seaBlue,
        ),
      );
      break;
    case 'signUpRoute':
      SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(
          systemNavigationBarColor: ColorPalette.white,
        ),
      );
      break;
    case 'checkInRoute':
      SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(
          systemNavigationBarColor: ColorPalette.white,
        ),
      );
      break;
    case 'leaderboardRoute':
      SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(
          systemNavigationBarColor: ColorPalette.gray,
        ),
      );
      break;
    case 'qrCodeRoute':
      SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(
          systemNavigationBarColor: ColorPalette.black,
        ),
      );
      break;
    case 'quizRoute':
      SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(
          systemNavigationBarColor: ColorPalette.white,
        ),
      );
      break;
    default:
      break;
  }
}
