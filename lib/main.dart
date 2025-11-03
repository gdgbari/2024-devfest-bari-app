import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:devfest_bari_2025/app.dart';
import 'package:devfest_bari_2025/firebase_options.dart';
import 'package:devfest_bari_2025/logic.dart';
import 'package:devfest_bari_2025/ui.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_svg/svg.dart';

void main() async {
  runZonedGuarded(
    () async {
      await _initialization();
      Bloc.observer = DebugBloc();
      runApp(const App());
    },
    (error, stack) {
      if (kDebugMode) {
        print(error);
      }
    },
  );
}

Future<void> _initialization() async {
  final widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarBrightness: Brightness.dark,
      statusBarIconBrightness: Brightness.light,
      systemNavigationBarColor: ColorPalette.white,
      systemNavigationBarDividerColor: ColorPalette.transparent,
      systemNavigationBarIconBrightness: Brightness.dark,
    ),
  );
  await SystemChrome.setPreferredOrientations(
    <DeviceOrientation>[
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ],
  );
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await _precacheAllSvg();

  InternetCubit().monitorInternetConnection();
}

Future<void> _precacheAllSvg() async {
  final List<String> imageUrls = [
    'assets/images/dino.svg',
    'assets/images/devfest_logo.svg',
    'assets/images/qr_marker.svg',
    'assets/images/icons/email.svg',
    'assets/images/icons/google.svg',
    'assets/images/icons/apple.svg',
    'assets/images/icons/instagram_logo.svg',
    'assets/images/icons/linkedin_logo.svg',
    'assets/images/icons/x_logo.svg',
  ];
  for (var url in imageUrls) {
    _precacheSvg(url);
  }
}

Future<void> _precacheSvg(String path) async {
  final loader = SvgAssetLoader(path);
  svg.cache.putIfAbsent(loader.cacheKey(null), () => loader.loadBytes(null));
}
