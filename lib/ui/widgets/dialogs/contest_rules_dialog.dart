import 'package:devfest_bari_2025/ui.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

Future<void> showContestRulesDialog(
  BuildContext context,
  String title,
  String content,
) async {
  await showDialog(
    context: context,
    builder: (_) => ContestRulesDialog(
      onPressed: () => context.pop(),
      title: title,
      content: content,
    ),
  );
}

class ContestRulesDialog extends StatelessWidget {
  final void Function()? onPressed;
  final String title;
  final String content;

  const ContestRulesDialog({
    super.key,
    required this.onPressed,
    required this.title,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        title.isNotEmpty ? title.toUpperCase() : 'Loading...',
        style: PresetTextStyle.black23w500,
        textAlign: TextAlign.center,
      ),
      content: title.isEmpty && content.isEmpty
          ? SizedBox(
              height: 80,
              child: Center(child: CustomLoader()),
            )
          : Text(
              content,
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
