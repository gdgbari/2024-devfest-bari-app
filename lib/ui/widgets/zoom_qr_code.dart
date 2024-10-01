import 'package:devfest_bari_2024/ui.dart';
import 'package:flutter/material.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';

Future<void> zoomQrCode(
  BuildContext context,
  QrImage qrImage,
) async {
  Navigator.of(context, rootNavigator: true).push(
    PageRouteBuilder(
      fullscreenDialog: true,
      opaque: false,
      barrierColor: Colors.black.withOpacity(0.4),
      barrierDismissible: true,
      pageBuilder: (BuildContext context, _, __) {
        return Center(
          child: Hero(
            tag: 'user_qr',
            child: Container(
              color: ColorPalette.white,
              padding: EdgeInsets.all(20),
              width: MediaQuery.of(context).size.width * 0.6,
              child: PrettyQrView(
                qrImage: qrImage,
                decoration: const PrettyQrDecoration(
                  shape: PrettyQrSmoothSymbol(
                    color: ColorPalette.black,
                    roundFactor: 0,
                  ),
                  image: PrettyQrDecorationImage(
                    image: AssetImage(
                      'assets/images/user.png',
                    ),
                    scale: 0.3,
                  ),
                ),
              ),
            ),
          ),
        );
      },
    ),
  );
}
