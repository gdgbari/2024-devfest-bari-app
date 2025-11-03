import 'package:devfest_bari_2025/logic.dart';
import 'package:devfest_bari_2025/ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class LoginPage extends StatelessWidget {
  final emailTextController = TextEditingController();
  final passwordTextController = TextEditingController();

  LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: ColorPalette.black,
        title: const Text(
          'Sign in with Email',
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
              const SizedBox(height: 20),
              SizedBox(
                height: 50,
                width: double.maxFinite,
                child: TextButton(
                  onPressed: () {
                    FocusManager.instance.primaryFocus?.unfocus();
                    context
                        .read<AuthenticationCubit>()
                        .signInWithEmailAndPassword(
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
                    'SIGN IN',
                    style: PresetTextStyle.white19w400,
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
