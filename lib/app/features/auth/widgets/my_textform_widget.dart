import 'package:flutter/material.dart';

class MyTextFormField extends StatelessWidget {
  const MyTextFormField(
      {super.key,
      required this.textController,
      required this.myFocusNode,
      required this.myAction,
      required this.labelText,
      required this.prefixIcon,
      this.suffixIcon,
      this.togglePassword,
      required this.obscureText,
      required this.onChange,
      required this.validation});

// final TextEditingController? controller;
  final TextEditingController textController;
  final FocusNode myFocusNode;
  final TextInputAction myAction;
  final String labelText;
  final Icon prefixIcon;
  final Icon? suffixIcon;
  final Function()? togglePassword;
  final bool obscureText;
  final String? Function(String?)? onChange;
  final String? Function(String?)? validation;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: textController,
      focusNode: myFocusNode,
      textInputAction: myAction,
      decoration: InputDecoration(
        // Input with border outlined
        border: OutlineInputBorder(
          // Make border edge circular
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
        ),
        label: Text(labelText),
        prefix: prefixIcon,
        suffix: IconButton(
          icon: suffixIcon ?? SizedBox(),
          onPressed: togglePassword,
        ),
      ),
      obscureText: obscureText,
      onChanged: onChange,
      validator: validation,
    );
  }
}
