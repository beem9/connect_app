import 'package:connect_app/app/config/theme/my_colors.dart';
import 'package:connect_app/app/core/extensions/build_context_extension.dart';
import 'package:connect_app/app/features/auth/widgets/my_forms_widget.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({super.key});

  final GlobalKey<FormState> formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          title: Text(
            (context.translate.register),
            style: context.textTheme.headlineMedium
                ?.copyWith(fontSize: 16, color: MyColors.black),
          ),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            MyAuthFormState(formKey: formkey),
            ElevatedButton(
                onPressed: () {}, child: Text(context.translate.register)),
            TextButton(
              onPressed: () {},
              child: Text(
                (context.translate.googleSign),
                style: context.textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.bold, color: MyColors.primary_500),
              ),
            )
          ],
        ));
  }
}
