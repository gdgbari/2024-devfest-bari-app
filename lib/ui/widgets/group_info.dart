import 'package:cached_network_image/cached_network_image.dart';
import 'package:devfest_bari_2025/data.dart';
import 'package:devfest_bari_2025/ui/theme/color_palette.dart';
import 'package:devfest_bari_2025/ui/widgets.dart';
import 'package:flutter/material.dart';

class GroupInfo extends StatelessWidget {
  final Group group;

  const GroupInfo({super.key, required this.group});

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 21 / 9,
      child: CachedNetworkImage(
        imageUrl: group.imageUrl,
        placeholder: (context, url) {
          return Container(
            color: ColorPalette.black,
            width: MediaQuery.of(context).size.width,
            child: const Center(
              child: SizedBox(
                height: 50,
                width: 50,
                child: CustomLoader(),
              ),
            ),
          );
        },
        errorWidget: (context, url, error) {
          return Image.asset('assets/images/team_null.png');
        },
      ),
    );
  }
}
