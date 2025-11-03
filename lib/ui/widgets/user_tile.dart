import 'package:devfest_bari_2025/data.dart';
import 'package:devfest_bari_2025/ui.dart';
import 'package:flutter/material.dart';

class UserTile extends StatelessWidget {
  final LeaderboardUser user;

  const UserTile({
    super.key,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: user.groupColor),
        borderRadius: BorderRadius.circular(10),
      ),
      height: 50,
      width: double.maxFinite,
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Row(
        children: <Widget>[
          CircleAvatar(
            backgroundColor: user.groupColor,
            radius: 15,
            child: Text(
              '${user.position}°',
              style: PresetTextStyle.white13w400,
            ),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Text(
              user.nickname,
              overflow: TextOverflow.ellipsis,
              softWrap: false,
              maxLines: 1,
              style: PresetTextStyle.black17w400,
            ),
          ),
          const SizedBox(width: 15),
          RichText(
            text: TextSpan(
              text: '${user.score}',
              style: PresetTextStyle.black17w500,
              children: const <InlineSpan>[
                TextSpan(
                  text: ' points',
                  style: PresetTextStyle.black17w400,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
