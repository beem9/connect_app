import 'package:connect_app/app/config/routes/router.dart';
import 'package:connect_app/app/config/theme/my_colors.dart';
import 'package:connect_app/app/core/extensions/build_context_extension.dart';
import 'package:connect_app/app/features/auth/domain/providers/auth_providers.dart';
import 'package:connect_app/app/features/auth/widgets/my_forms_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RegisterScreen extends ConsumerWidget {
  RegisterScreen({super.key});

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //add widgetref to convert from stateless widget to consumer widget
    final authController = ref.read(authControllerProvider.notifier);
    final formsProvider = ref.watch(authFormController);
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
            MyAuthFormState(formKey: formKey),
            ElevatedButton(
                onPressed: () {
                  if (formKey.currentState?.validate() == true) {
                    authController.register(
                        email: formsProvider.email,
                        userName: formsProvider.userName,
                        password: formsProvider.password);
                  }
                },
                child: Text(context.translate.register)),
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
