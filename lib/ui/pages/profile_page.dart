import 'package:devfest_bari_2025/logic.dart';
import 'package:devfest_bari_2025/ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<AuthenticationCubit, AuthenticationState>(
          builder: (context, state) {
            final qrImage = QrImage(
              QrCode.fromData(
                data: 'user:${state.userProfile.userId}',
                errorCorrectLevel: QrErrorCorrectLevel.H,
              ),
            );

            return Column(
              children: <Widget>[
                GroupInfo(group: state.userProfile.group),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    width: double.maxFinite,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        UserInfo(userProfile: state.userProfile),
                        SizedBox(height: 5),
                        GestureDetector(
                          onTap: () => launchUrl(
                            Uri.parse(
                              'https://forms.gle/yAhTRZv6JKAYA3BY7',
                            ),
                          ),
                          child: Text(
                            'Request data deletion',
                            style: PresetTextStyle.black13w500.copyWith(
                              color: ColorPalette.coreRed,
                            ),
                          ),
                        ),
                        Expanded(child: SizedBox()),
                        Center(child: UserQrCode(qrImage: qrImage)),
                        Expanded(child: SizedBox()),
                        const SocialInfo(),
                        const SizedBox(height: 40),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
