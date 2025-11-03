import 'package:devfest_bari_2025/ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorPalette.pastelRed,
        toolbarHeight: 0,
      ),
      backgroundColor: ColorPalette.pastelRed,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Container(
                color: ColorPalette.pastelRed,
              ),
            ),
            SvgPicture.asset(
              'assets/images/welcome.svg',
              width: MediaQuery.of(context).size.width,
            ),
            Expanded(
              flex: 2,
              child: Container(
                color: ColorPalette.seaBlue,
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Center(
                  child: OAuthButton(
                    method: 'email',
                    onPressed: () =>
                        context.pushNamed(RouteNames.signUpRoute.name),
                  ),
                ),
              ),
            ),
            Container(
              color: ColorPalette.seaBlue,
              height: 20 + MediaQuery.of(context).padding.bottom,
            ),
          ],
        ),
      ),
    );
  }
}
