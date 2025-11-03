import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:devfest_bari_2025/logic.dart';

class DebugBloc extends BlocObserver {
  @override
  void onEvent(Bloc bloc, Object? event) {
    print(event);
    super.onEvent(bloc, event);
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    print(transition);
    super.onTransition(bloc, transition);
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) async {
    print(error);

    if (error is SocketException) {
      InternetCubit().sendInternetFailure();
    } else {
      throw await Future.error(error, stackTrace);
    }

    super.onError(bloc, error, stackTrace);
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    print(change);
    super.onChange(bloc, change);
  }
}
