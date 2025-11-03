import 'package:devfest_bari_2025/ui.dart';
import 'package:flutter/material.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';

class UserQrCode extends StatelessWidget {
  final QrImage qrImage;

  const UserQrCode({super.key, required this.qrImage});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SizedBox(
          height: 50,
          width: 50,
          child: InkWell(
            onTap: () => zoomQrCode(context, qrImage),
            child: Hero(
              tag: 'user_qr',
              child: Container(
                color: ColorPalette.white,
                padding: EdgeInsets.all(5),
                child: CustomQrView(qrImage: qrImage),
              ),
            ),
          ),
        ),
        Text(
          'Click to expand',
          style: PresetTextStyle.black15w500,
        ),
      ],
    );
  }
}
