import 'package:devfest_bari_2025/ui.dart';
import 'package:flutter/cupertino.dart';

class CustomSegmentedButton extends StatelessWidget {
  final int index;
  final void Function(int) onValueChanged;

  const CustomSegmentedButton({
    super.key,
    required this.index,
    required this.onValueChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      child: CupertinoSegmentedControl(
        borderColor: ColorPalette.black,
        pressedColor: ColorPalette.gray,
        selectedColor: ColorPalette.black,
        unselectedColor: ColorPalette.white,
        padding: const EdgeInsets.all(0),
        groupValue: index,
        children: <int, Widget>{
          0: SizedBox(
            height: 35,
            child: Center(
              child: Text(
                'Users',
                style: index == 0
                    ? PresetTextStyle.white15w500
                    : PresetTextStyle.black15w400,
              ),
            ),
          ),
          1: SizedBox(
            height: 35,
            child: Center(
              child: Text(
                'Teams',
                style: index == 1
                    ? PresetTextStyle.white15w500
                    : PresetTextStyle.black15w400,
              ),
            ),
          ),
        },
        onValueChanged: onValueChanged,
      ),
    );
  }
}
