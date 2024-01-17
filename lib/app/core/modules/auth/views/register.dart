import 'package:connect_app/app/config/routes/my_named_routes.dart';
import 'package:connect_app/app/config/theme/my_colors.dart';
import 'package:connect_app/app/core/extensions/build_context_extension.dart';
import 'package:connect_app/app/core/modules/auth/domain/providers/auth_providers.dart';
import 'package:connect_app/app/core/modules/auth/widgets/my_forms_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class RegisterScreen extends ConsumerWidget {
  RegisterScreen({super.key});

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authProvider = ref.read(authControllerProvider.notifier);
    final fieldValues = ref.watch(authFormController);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          context.translate.register,
          style: context.theme.textTheme.titleMedium?.copyWith(
            color: MyColors.black,
          ),
        ),
        backgroundColor: Colors.orangeAccent,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          MyAuthFormState(formKey: formKey),
          const SizedBox(
            height: 12,
          ),
          ElevatedButton(
              onPressed: () {
                if (formKey.currentState?.validate() == true) {
                  authProvider.register(
                      email: fieldValues.email,
                      userName: fieldValues.userName,
                      password: fieldValues.password);
                  context.pushNamed(MyNamedRoutes.login);
                }
              },
              child: Text(context.translate.register)),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Registered?"),
              TextButton(
                  onPressed: () {
                    context.pushNamed(MyNamedRoutes.login);
                  },
                  child: const Text(
                    "Sign in here!",
                    style: TextStyle(color: Colors.lightBlue),
                  ))
            ],
          ),
          const SizedBox(
            height: 12,
          ),
          TextButton(
              onPressed: () {
                authProvider.signInWithGoogle();
              },
              child: Text(context.translate.googleSign)),
        ],
      ),
    );
  }
}
