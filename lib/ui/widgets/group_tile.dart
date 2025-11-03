import 'package:devfest_bari_2025/data.dart';
import 'package:devfest_bari_2025/ui.dart';
import 'package:flutter/material.dart';

class GroupTile extends StatelessWidget {
  final LeaderboardGroup group;
  final int maxScore;

  const GroupTile({
    super.key,
    required this.group,
    required this.maxScore,
  });

  @override
  Widget build(BuildContext context) {
    final baseWidth = MediaQuery.of(context).size.width - 40;
    const minWidth = 30.0;
    final width =
        maxScore != 0 ? (baseWidth * group.score) / maxScore : minWidth;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Expanded(
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            color: group.color,
            width: width == 0 ? minWidth : width,
            child: Center(
              child: Text(
                '${group.position}°',
                softWrap: false,
                style: PresetTextStyle.white21w500,
              ),
            ),
          ),
        ),
        const SizedBox(height: 10),
        RichText(
          text: TextSpan(
            text: 'Team ${group.name.capitalize()}',
            style: PresetTextStyle.black17w700,
            children: <InlineSpan>[
              TextSpan(
                text: ': ${group.score} points',
                style: PresetTextStyle.black17w400,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
