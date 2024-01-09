import 'package:connect_app/app/config/routes/my_named_routes.dart';
import 'package:connect_app/app/config/theme/my_colors.dart';
import 'package:connect_app/app/core/extensions/build_context_extension.dart';
import 'package:connect_app/app/features/auth/domain/providers/auth_providers.dart';
import 'package:connect_app/app/features/auth/widgets/my_login_forms_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class LoginScreen extends ConsumerWidget {
  LoginScreen({super.key});

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authProvider = ref.read(authControllerProvider.notifier);
    final fieldValues = ref.watch(authFormController);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          context.translate.login,
          style: context.theme.textTheme.titleMedium?.copyWith(
            color: MyColors.black,
          ),
        ),
        backgroundColor: Colors.orangeAccent,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          MyLoginAuthFormState(formKey: formKey),
          const SizedBox(
            height: 12,
          ),
          ElevatedButton(
              onPressed: () {
                if (formKey.currentState?.validate() == true) {
                  authProvider.login(
                      email: fieldValues.email,
                      userName: fieldValues.userName,
                      password: fieldValues.password);
                  context.pushNamed(MyNamedRoutes.home);
                }
              },
              child: Text(context.translate.login)),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Dont have an account?"),
              TextButton(
                  onPressed: () {
                    context.goNamed(MyNamedRoutes.register);
                  },
                  child: Text(
                    context.translate.register,
                    style: const TextStyle(color: Colors.lightBlue),
                  ))
            ],
          ),
          const SizedBox(
            height: 12,
          ),
          TextButton(
              onPressed: () {
                authProvider.signInWithGoogle();
                context.pushNamed(MyNamedRoutes.home);
              },
              child: Text(context.translate.googleSign)),
        ],
      ),
    );
  }
}
