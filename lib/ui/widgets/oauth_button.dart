import 'package:devfest_bari_2025/ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class OAuthButton extends StatelessWidget {
  final String method;
  final void Function()? onPressed;

  const OAuthButton({
    super.key,
    required this.method,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 65,
      child: TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          backgroundColor: ColorPalette.black,
          overlayColor: Colors.white,
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const SizedBox(width: 30),
              SvgPicture.asset(
                'assets/images/icons/$method.svg',
                width: 30,
              ),
              const SizedBox(width: 30),
              Text(
                'Sign in with ${method.capitalize()}',
                style: PresetTextStyle.white19w400,
              ),
              const SizedBox(width: 30),
            ],
          ),
        ),
      ),
    );
  }
}
