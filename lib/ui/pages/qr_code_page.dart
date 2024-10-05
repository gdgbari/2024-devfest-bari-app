import 'package:devfest_bari_2024/logic.dart';
import 'package:devfest_bari_2024/ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class QrCodePage extends StatelessWidget {
  QrCodePage({super.key});

  final controller = MobileScannerController();

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: <BlocListener>[
        BlocListener<QuizCubit, QuizState>(
          listener: _quizListener,
        ),
        BlocListener<QrCodeCubit, QrCodeState>(
          listener: _qrCodeListener,
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: ColorPalette.black,
          title: const Text(
            'QR code',
            style: PresetTextStyle.white21w500,
          ),
          centerTitle: true,
          leading: IconButton(
            onPressed: () => context.pop(),
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {
                context.read<QrCodeCubit>().validateQrCode(
                      'quiz:JEVjQGRtfo7pDyZntRSR',
                      QrCodeType.quiz,
                    );
              },
              icon: const Icon(
                Icons.abc_sharp,
                color: Colors.white,
              ),
            ),
          ],
        ),
        body: SafeArea(
          bottom: false,
          child: Stack(
            children: <Widget>[
              MobileScanner(
                controller: controller,
                onDetect: (barcodes) {
                  final qrData = barcodes.barcodes.first;
                  if (qrData.type == BarcodeType.text) {
                    context.read<QrCodeCubit>().validateQrCode(
                          qrData.rawValue,
                          QrCodeType.quiz,
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
      ),
    );
  }
}

void _qrCodeListener(
  BuildContext context,
  QrCodeState state,
) {
  switch (state.status) {
    case QrCodeStatus.validationInProgress:
      context.loaderOverlay.show();
      break;
    case QrCodeStatus.validationSuccess:
      context.loaderOverlay.hide();
      context.read<QuizCubit>().getQuiz(state.value);
      break;
    case QrCodeStatus.validationFailure:
      context.loaderOverlay.hide();
      showCustomErrorDialog(
        context,
        'Hey, this QR code doesn\'t work.\nPlease try with another one.',
      );
      break;
    default:
      break;
  }
}

void _quizListener(
  BuildContext context,
  QuizState state,
) {
  switch (state.status) {
    case QuizStatus.fetchInProgress:
      context.loaderOverlay.show();
      break;
    case QuizStatus.fetchSuccess:
      context.loaderOverlay.hide();
      context.pushReplacementNamed(RouteNames.quizRoute.name);
      break;
    case QuizStatus.fetchFailure:
      context.loaderOverlay.hide();
      late String errorMessage;
      switch (state.error) {
        case QuizError.quizNotFound:
          errorMessage = 'Quiz not found.\nPlease try onother one.';
          break;
        case QuizError.quizNotOpen:
          errorMessage = 'Quiz not open.\nPlease scan the right one.';
          break;
        case QuizError.quizTimeIsUp:
          errorMessage = 'Oops, you ran out of time.\n'
              'We can\'t consider your answers.';
          break;
        case QuizError.quizAlreadySubmitted:
          errorMessage = 'You have already answered to this quiz.\n'
              'There are a lot of them, go and find another one!';
          break;
        case QuizError.unknown:
          errorMessage = 'An unknown error occurred.\nPlease try again later.';
          break;
        default:
          break;
      }
      showCustomErrorDialog(context, errorMessage);
      break;
    default:
  }
}
