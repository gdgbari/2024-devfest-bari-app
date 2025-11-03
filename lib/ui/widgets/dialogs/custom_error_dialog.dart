import 'package:devfest_bari_2025/ui.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

Future<void> showCustomErrorDialog(
  BuildContext context,
  String errorMessage,
) async {
  await showDialog(
    context: context,
    barrierDismissible: false,
    builder: (_) => CustomErrorDialog(
      onPressed: () => context.pop(),
      errorMessage: errorMessage,
    ),
  );
}

class CustomErrorDialog extends StatelessWidget {
  final void Function()? onPressed;
  final String errorMessage;

  const CustomErrorDialog({
    super.key,
    required this.onPressed,
    required this.errorMessage,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        'ERROR',
        style: PresetTextStyle.black23w500.copyWith(
          color: ColorPalette.coreRed,
        ),
      ),
      content: Text(
        errorMessage,
        style: PresetTextStyle.black19w400,
      ),
      actions: <Widget>[
        TextButton(
          onPressed: onPressed,
          style: TextButton.styleFrom(
            backgroundColor: ColorPalette.black,
            overlayColor: Colors.white,
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
          child: const SizedBox(
            height: 40,
            width: double.maxFinite,
            child: Center(
              child: Text(
                'OK',
                style: PresetTextStyle.white19w400,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
