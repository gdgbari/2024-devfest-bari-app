import 'package:devfest_bari_2025/data.dart';
import 'package:devfest_bari_2025/ui.dart';
import 'package:flutter/material.dart';

class UserInfo extends StatelessWidget {
  final UserProfile userProfile;

  const UserInfo({super.key, required this.userProfile});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          '@${userProfile.nickname}',
          style: PresetTextStyle.black23w500,
        ),
        const SizedBox(height: 10),
        Text(
          '${userProfile.name} ${userProfile.surname}',
          style: PresetTextStyle.black15w400,
          overflow: TextOverflow.ellipsis,
          maxLines: 2,
        ),
        Text(
          userProfile.email,
          style: PresetTextStyle.black15w400,
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
        ),
      ],
    );
  }
}
