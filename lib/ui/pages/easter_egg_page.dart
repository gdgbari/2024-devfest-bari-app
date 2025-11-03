import 'package:devfest_bari_2025/logic.dart';
import 'package:devfest_bari_2025/ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class EasterEggPage extends StatelessWidget {
  const EasterEggPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: ColorPalette.black,
        title: const Text(
          'Easter Egg',
          style: PresetTextStyle.white21w500,
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            AspectRatio(
              aspectRatio: 36 / 27,
              child: Image.asset(
                'assets/images/genio.gif',
                fit: BoxFit.contain,
              ),
            ),
            BlocBuilder<EasterEggCubit, EasterEggState>(
              builder: (context, state) {
                return Padding(
                  padding: const EdgeInsets.all(20),
                  child: Text.rich(
                    TextSpan(
                      text: '🎉 CONGRATULATIONS 🎉\n\n',
                      style: PresetTextStyle.black23w700,
                      children: <InlineSpan>[
                        TextSpan(
                          text: 'You found the easter egg!',
                          style: PresetTextStyle.black21w400,
                        ),
                        TextSpan(text: '\n\n'),
                        TextSpan(
                          text: state.easterEggMessage,
                          style: PresetTextStyle.black21w400,
                        ),
                      ],
                    ),
                    textAlign: TextAlign.center,
                  ),
                );
              },
            ),
            Expanded(child: SizedBox()),
            SizedBox(
              width: MediaQuery.of(context).size.width - 40,
              child: TextButton(
                onPressed: () => context.pop(),
                style: TextButton.styleFrom(
                  backgroundColor: ColorPalette.black,
                  overlayColor: Colors.white,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  'SOUNDS GREAT!',
                  style: PresetTextStyle.white19w400,
                ),
              ),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
