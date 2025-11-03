import 'package:devfest_bari_2025/ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatelessWidget {
  final bool autofocus;
  final Color borderColor;
  final double borderRadius;
  final TextEditingController? controller;
  final Color cursorColor;
  final bool enabled;
  final bool errorBool;
  final Color errorColor;
  final Color fillColor;
  final FocusNode? focusNode;
  final double height;
  final double horizPad;
  final String? initialValue;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputType keyboardType;
  final int? maxLines;
  final bool obscureText;
  final void Function(String)? onChanged;
  final void Function()? onTap;
  final String hint;
  final TextStyle hintStyle;
  final bool showCursor;
  final TextStyle style;
  final Widget suffix;
  final double suffixPadding;
  final TextAlignVertical textAlignVertical;
  final TextInputAction textInputAction;
  final double? width;

  const CustomTextField({
    super.key,
    this.autofocus = false,
    this.borderColor = Colors.grey,
    this.borderRadius = 10,
    this.controller,
    this.cursorColor = ColorPalette.black,
    this.enabled = true,
    this.errorBool = false,
    this.errorColor = ColorPalette.coreRed,
    this.fillColor = Colors.white,
    this.focusNode,
    this.height = 50,
    this.horizPad = 12,
    this.initialValue,
    this.inputFormatters,
    this.keyboardType = TextInputType.text,
    this.maxLines = 1,
    this.obscureText = false,
    this.onChanged,
    this.onTap,
    this.hint = 'Hint',
    this.hintStyle = PresetTextStyle.grey17w400,
    this.showCursor = true,
    this.style = PresetTextStyle.black17w400,
    this.suffix = const SizedBox(),
    this.suffixPadding = 12,
    this.textAlignVertical = TextAlignVertical.center,
    this.textInputAction = TextInputAction.done,
    this.width,
  }) : assert(initialValue == null || controller == null);

  @override
  Widget build(BuildContext context) {
    final vertPad = ((height - style.fontSize!) / 2) - 2;

    return Material(
      color: Colors.transparent,
      child: SizedBox(
        width: width,
        child: Stack(
          children: <Widget>[
            TextFormField(
              onTapOutside: (_) =>
                  FocusManager.instance.primaryFocus?.unfocus(),
              autofocus: autofocus,
              controller: controller,
              cursorColor: cursorColor,
              decoration: InputDecoration(
                constraints: BoxConstraints(minHeight: height),
                contentPadding: EdgeInsets.symmetric(
                  horizontal: horizPad,
                  vertical: vertPad,
                ).copyWith(
                  right: suffixPadding,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
                  borderSide: BorderSide(color: borderColor),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
                  borderSide: BorderSide(color: errorColor),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
                  borderSide: BorderSide(color: cursorColor, width: 1.5),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
                  borderSide: BorderSide(color: errorColor),
                ),
                errorText: errorBool ? '' : null,
                errorStyle: const TextStyle(
                  fontSize: 0,
                  height: 0,
                ),
                fillColor: fillColor,
                filled: true,
                hintStyle: hintStyle,
                hintText: hint,
              ),
              enabled: enabled,
              focusNode: focusNode,
              initialValue: initialValue,
              inputFormatters: inputFormatters,
              keyboardType: keyboardType,
              maxLines: maxLines,
              obscureText: obscureText,
              onChanged: onChanged,
              onTap: onTap,
              showCursor: showCursor,
              style: style,
              textAlignVertical: textAlignVertical,
              textInputAction: textInputAction,
            ),
            suffix,
          ],
        ),
      ),
    );
  }
}
