import 'package:devfest_bari_2025/ui.dart';
import 'package:flutter/material.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';

class CustomQrView extends StatelessWidget {
  final QrImage qrImage;

  const CustomQrView({super.key, required this.qrImage});

  @override
  Widget build(BuildContext context) {
    return PrettyQrView(
      qrImage: qrImage,
      decoration: const PrettyQrDecoration(
        shape: PrettyQrSmoothSymbol(
          color: ColorPalette.black,
          roundFactor: 0,
        ),
        image: PrettyQrDecorationImage(
          image: AssetImage('assets/images/user.png'),
          scale: 0.3,
        ),
      ),
    );
  }
}
