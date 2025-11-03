import 'package:devfest_bari_2025/ui.dart';
import 'package:flutter/material.dart';

class SocialInfo extends StatelessWidget {
  const SocialInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 240,
        child: const Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              'Follow us on our social media',
              style: PresetTextStyle.black17w500,
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                SocialMediaButton(
                  name: 'instagram',
                  url: 'https://www.instagram.com/gdgbari/',
                ),
                SocialMediaButton(
                  name: 'x',
                  url: 'https://x.com/gdgbari/',
                ),
                SocialMediaButton(
                  name: 'linkedin',
                  url: 'https://www.linkedin.com/company/gdgbari/',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
