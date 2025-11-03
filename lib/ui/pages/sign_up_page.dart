import 'package:devfest_bari_2025/logic.dart';
import 'package:devfest_bari_2025/ui.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class SignUpPage extends StatelessWidget {
  final nicknameController = TextEditingController();
  final nameController = TextEditingController();
  final surnameController = TextEditingController();
  final emailTextController = TextEditingController();
  final passwordTextController = TextEditingController();

  SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: ColorPalette.black,
        title: const Text(
          'Sign up',
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
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              const Text(
                'Join us at DevFest Bari 2025!',
                style: PresetTextStyle.black19w500,
              ),
              const SizedBox(height: 20),
              CustomTextField(
                hint: 'Nickname',
                controller: nicknameController,
                keyboardType: TextInputType.text,
              ),
              const SizedBox(height: 10),
              CustomTextField(
                hint: 'Name',
                controller: nameController,
                keyboardType: TextInputType.name,
              ),
              const SizedBox(height: 10),
              CustomTextField(
                hint: 'Surname',
                controller: surnameController,
                keyboardType: TextInputType.name,
              ),
              const SizedBox(height: 10),
              CustomTextField(
                hint: 'Email',
                controller: emailTextController,
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 10),
              CustomTextField(
                hint: 'Password',
                controller: passwordTextController,
                obscureText: true,
              ),
              const SizedBox(height: 5),
              Align(
                alignment: Alignment.centerLeft,
                child: const Text(
                  'Minimum 8 characters',
                  style: PresetTextStyle.black13w400,
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                height: 50,
                width: double.maxFinite,
                child: TextButton(
                  onPressed: () {
                    FocusManager.instance.primaryFocus?.unfocus();

                    context.read<AuthenticationCubit>().signUp(
                          nickname: nicknameController.text.trim(),
                          name: nameController.text.trim(),
                          surname: surnameController.text.trim(),
                          email: emailTextController.text.trim(),
                          password: passwordTextController.text,
                        );
                  },
                  style: TextButton.styleFrom(
                    backgroundColor: ColorPalette.black,
                    overlayColor: Colors.white,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    'SIGN UP',
                    style: PresetTextStyle.white21w400,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              RichText(
                text: TextSpan(
                  text: 'Already have an account? ',
                  style: PresetTextStyle.black17w400,
                  children: <InlineSpan>[
                    TextSpan(
                      text: 'Sign in',
                      style: const TextStyle(
                        color: ColorPalette.coreRed,
                        fontWeight: FontWeight.w500,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () => context.pushNamed(
                              RouteNames.loginRoute.name,
                            ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
