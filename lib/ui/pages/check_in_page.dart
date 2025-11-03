import 'package:devfest_bari_2025/logic.dart';
import 'package:devfest_bari_2025/ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class CheckInPage extends StatelessWidget {
  CheckInPage({super.key});

  final controller = MobileScannerController();

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: <BlocListener>[
        BlocListener<QrCodeCubit, QrCodeState>(
          listener: (context, state) async {
            switch (state.status) {
              case QrCodeStatus.validationInProgress:
                context.loaderOverlay.show();
                break;
              case QrCodeStatus.validationSuccess:
                context.loaderOverlay.hide();
                context.read<AuthenticationCubit>().checkIn(state.value);
                break;
              case QrCodeStatus.validationFailure:
                context.loaderOverlay.hide();
                await showCustomErrorDialog(
                  context,
                  'Hey, this QR code doesn\'t work.\nPlease try with another one.',
                );
                controller.start();
                break;
              default:
                break;
            }
          },
        ),
        BlocListener<AuthenticationCubit, AuthenticationState>(
          listenWhen: (previous, current) =>
              previous.status == AuthenticationStatus.checkInInProgress &&
              current.status == AuthenticationStatus.checkInFailure,
          listener: (context, state) async {
            context.loaderOverlay.hide();
            String errorMessage = '';
            switch (state.error) {
              case AuthenticationError.checkInCodeExpired:
                errorMessage =
                    'Check-in code has expired.\nPlease request a new code.';
                break;
              case AuthenticationError.checkInCodeNotFound:
                errorMessage =
                    'Check-in code not found.\nPlease verify and scan again.';
                break;
              case AuthenticationError.unknown:
                errorMessage =
                    'An unknown error occurred.\nPlease try again later.';
                break;
              default:
                break;
            }
            await showCustomErrorDialog(context, errorMessage);
            controller.start();
          },
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: ColorPalette.black,
          title: const Text(
            'Check-in',
            style: PresetTextStyle.white21w500,
          ),
          centerTitle: true,
        ),
        body: SafeArea(
          child: Column(
            children: <Widget>[
              Expanded(
                child: Stack(
                  children: <Widget>[
                    MobileScanner(
                      controller: controller,
                      onDetect: (barcodes) {
                        final qrData = barcodes.barcodes.first;
                        if (qrData.type == BarcodeType.text) {
                          controller.stop();
                          context.read<QrCodeCubit>().validateQrCode(
                                qrData.rawValue,
                                QrCodeType.checkin,
                              );
                        }
                      },
                    ),
                    const QRCodeBackground(),
                    Center(
                      child: SvgPicture.asset(
                        'assets/images/qr_marker.svg',
                        width: MediaQuery.of(context).size.width / 1.75,
                        colorFilter: const ColorFilter.mode(
                          Colors.white,
                          BlendMode.srcIn,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Text(
                  'Please scan the QR code that you\nreceived during the check-in',
                  style: PresetTextStyle.black17w400,
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
