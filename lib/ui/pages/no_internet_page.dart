import 'package:devfest_bari_2025/ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class NoInternetPage extends StatelessWidget {
  const NoInternetPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorPalette.white,
        toolbarHeight: 0,
      ),
      backgroundColor: ColorPalette.white,
      body: SafeArea(
        child: Container(
          width: double.maxFinite,
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SvgPicture.asset(
                'assets/images/dino.svg',
                width: MediaQuery.of(context).size.width / 2,
              ),
              SizedBox(height: 20),
              Text(
                'Lost connection',
                style: PresetTextStyle.black23w500,
              ),
              SizedBox(height: 10),
              Text(
                'Please check your internet connection',
                style: PresetTextStyle.black17w400,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
