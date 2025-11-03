import 'dart:async';

import 'package:devfest_bari_2025/ui/theme/color_palette.dart';
import 'package:flutter/material.dart';

class CustomLoader extends StatefulWidget {
  const CustomLoader({super.key});

  @override
  State<CustomLoader> createState() => _CustomLoaderState();
}

class _CustomLoaderState extends State<CustomLoader> {
  final _duration = const Duration(milliseconds: 1500);
  int _colorIndex = 0;
  late Timer _timer;
  final _colors = <Color>[
    ColorPalette.coreBlue,
    ColorPalette.coreGreen,
    ColorPalette.coreRed,
    ColorPalette.coreYellow,
  ];

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(
      _duration,
      (_) => setState(() => _colorIndex = (_colorIndex + 1) % _colors.length),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(90),
      ),
      child: CircularProgressIndicator(
        color: _colors[_colorIndex],
      ),
    );
  }
}
