import 'package:devfest_bari_2025/ui.dart';
import 'package:flutter/material.dart';

Future<void> showQuizResultsDialog({
  required BuildContext context,
  required void Function()? onPressed,
  required int score,
  required int maxScore,
}) async {
  await showDialog(
    context: context,
    barrierDismissible: false,
    builder: (_) => QuizResultsDialog(
      onPressed: onPressed,
      score: score,
      maxScore: maxScore,
    ),
  );
}

class QuizResultsDialog extends StatelessWidget {
  final void Function()? onPressed;
  final int score;
  final int maxScore;

  const QuizResultsDialog({
    super.key,
    required this.onPressed,
    required this.score,
    required this.maxScore,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        'QUIZ RESULTS',
        style: PresetTextStyle.black23w500,
        textAlign: TextAlign.center,
      ),
      content: Text(
        '$score/$maxScore',
        style: PresetTextStyle.black23w400.copyWith(
          fontSize: 40,
        ),
        textAlign: TextAlign.center,
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
