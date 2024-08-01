import 'package:devfest_bari_2024/logic.dart';
import 'package:devfest_bari_2024/ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loader_overlay/loader_overlay.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: _topLevelProviders,
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        routerConfig: appRouter,
        title: 'DevFest Bari 2024',
        builder: (context, child) {
          return BlocListener<AuthenticationCubit, AuthenticationState>(
            listener: _authListener,
            child: LoaderOverlay(
              useDefaultLoading: false,
              overlayColor: Colors.black.withOpacity(.4),
              overlayWidgetBuilder: (_) {
                return const Center(
                  child: CustomLoader(),
                );
              },
              child: child!,
            ),
          );
        },
      ),
    );
  }
}

List<BlocProvider> _topLevelProviders = <BlocProvider>[
  BlocProvider<AuthenticationCubit>(
    lazy: false,
    create: (context) => AuthenticationCubit(),
  ),
  BlocProvider<QuizCubit>(
    lazy: false,
    create: (context) => QuizCubit(),
  ),
];

void _authListener(
  BuildContext context,
  AuthenticationState state,
) {
  switch (state.status) {
    case AuthenticationStatus.initial:
      break;
    case AuthenticationStatus.authenticationInProgress:
    case AuthenticationStatus.signOutInProgress:
      context.loaderOverlay.show();
      break;
    case AuthenticationStatus.authenticationSuccess:
      context.loaderOverlay.hide();
      appRouter.goNamed(RouteNames.dashboardRoute.name);
      break;
    case AuthenticationStatus.authenticationFailure:
      context.loaderOverlay.hide();
      break;
    // TODO: show error message
    case AuthenticationStatus.signOutSuccess:
      context.loaderOverlay.hide();
      appRouter.goNamed(RouteNames.loginRoute.name);
      break;
  }
}
