import 'package:connect_app/app/config/theme/my_colors.dart';
import 'package:connect_app/app/core/extensions/build_context_extension.dart';
import 'package:connect_app/app/features/auth/domain/providers/auth_providers.dart';
import 'package:connect_app/app/features/auth/widgets/my_login_forms_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginScreen extends ConsumerWidget {
  LoginScreen({Key? key});

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authController = ref.read(authControllerProvider.notifier);
    final formsProvider = ref.watch(authFormController);

    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Text(
          (context.translate.login),
          style: context.textTheme.headlineMedium?.copyWith(
            fontSize: 16,
            color: MyColors.black,
          ),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          MyLoginAuthFormState(formKey: formKey),
          ElevatedButton(
            onPressed: () {
              if (formKey.currentState?.validate() == true) {
                authController.googleSign(
                    // email: formsProvider.email,
                    // password: formsProvider.password,
                    );
              }
            },
            child: Text(context.translate.login),
          ),
        ],
      ),
    );
  }
}
