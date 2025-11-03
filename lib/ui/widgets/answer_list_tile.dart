import 'package:devfest_bari_2025/ui/theme/color_palette.dart';
import 'package:flutter/material.dart';

class AnswerListTile extends StatelessWidget {
  final String value;
  final String? groupValue;
  final void Function(String?)? onChanged;
  final String title;
  final Color color;
  final Color selectionColor;

  const AnswerListTile({
    super.key,
    required this.value,
    required this.groupValue,
    required this.onChanged,
    required this.title,
    this.color = ColorPalette.black,
    this.selectionColor = ColorPalette.coreRed,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(10),
      onTap: () => onChanged?.call(value),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: color),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: <Widget>[
            Radio<String?>(
              value: value,
              groupValue: groupValue,
              onChanged: onChanged,
              activeColor: selectionColor,
            ),
            Expanded(child: Text(title)),
            SizedBox(width: 10),
          ],
        ),
      ),
    );
  }
}
