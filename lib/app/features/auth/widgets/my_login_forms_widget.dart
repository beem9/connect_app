import 'package:connect_app/app/core/extensions/build_context_extension.dart';
import 'package:connect_app/app/features/auth/domain/helper/auth_validators.dart';
import 'package:connect_app/app/features/auth/domain/providers/auth_providers.dart';
import 'package:connect_app/app/features/auth/widgets/my_textform_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MyLoginAuthFormState extends ConsumerStatefulWidget {
  const MyLoginAuthFormState({super.key, required this.formKey});
  final GlobalKey<FormState> formKey;

  @override
  /*add consumer*/ ConsumerState<MyLoginAuthFormState> createState() =>
      _MyLoginAuthFormState();
}

class _MyLoginAuthFormState
    extends ConsumerState<MyLoginAuthFormState> /*add consumer*/ {
  final _authValidators = AuthValidators();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final FocusNode emailNode = FocusNode();
  final FocusNode passwordNode = FocusNode();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    emailNode.dispose();
    passwordNode.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final formProvider = ref.watch(authFormController);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Form(
          key: widget.formKey,
          child: Column(
            children: [
              MyTextFormField(
                  textController: emailController,
                  myFocusNode: emailNode,
                  myAction: TextInputAction.next,
                  labelText: context.translate.email,
                  prefixIcon: const Icon(Icons.email),
                  obscureText: false,
                  onChange: (value) {
                    if (value != null) {
                      formProvider.setEmailField(value);
                    }
                    return null;
                  },
                  validation: (value) {
                    return _authValidators.emailValidator(value);
                  }),
              SizedBox(
                height: 10,
              ),
              SizedBox(
                height: 10,
              ),
              MyTextFormField(
                textController: passwordController,
                myFocusNode: passwordNode,
                myAction: TextInputAction.next,
                labelText: context.translate.password,
                prefixIcon: const Icon(Icons.password),
                obscureText: formProvider.togglePassword ? true : false,
                onChange: (value) {
                  if (value != null) {
                    formProvider.setPasswordField(value);
                  }
                  return null;
                },
                validation: (value) {
                  return _authValidators.passwordValidator(value);
                },
                togglePassword: () {
                  formProvider.togglePasswordIcon();
                },
                suffixIcon: Icon(
                  formProvider.togglePassword
                      ? Icons.remove_red_eye_outlined
                      : Icons.remove_red_eye_rounded,
                ),
              )
            ],
          )),
    );
  }
}
