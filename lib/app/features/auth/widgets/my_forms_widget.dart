import 'package:connect_app/app/core/extensions/build_context_extension.dart';
import 'package:connect_app/app/features/auth/domain/helper/auth_validators.dart';
import 'package:connect_app/app/features/auth/domain/providers/auth_providers.dart';
import 'package:connect_app/app/features/auth/widgets/my_textform_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MyAuthFormState extends ConsumerStatefulWidget {
  const MyAuthFormState({super.key, required this.formKey});
  final GlobalKey<FormState> formKey;

  @override
  /*add consumer*/ ConsumerState<MyAuthFormState> createState() =>
      _MyAuthFormStateState();
}

class _MyAuthFormStateState
    extends ConsumerState<MyAuthFormState> /*add consumer*/ {
  final _authValidators = AuthValidators();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final FocusNode emailNode = FocusNode();
  final FocusNode usernameNode = FocusNode();
  final FocusNode passwordNode = FocusNode();

  @override
  void dispose() {
    emailController.dispose();
    usernameController.dispose();
    passwordController.dispose();
    emailNode.dispose();
    usernameNode.dispose();
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
              MyTextFormField(
                textController: usernameController,
                myFocusNode: usernameNode,
                myAction: TextInputAction.next,
                labelText: context.translate.username,
                prefixIcon: Icon(Icons.person),
                obscureText: false,
                onChange: (value) {
                  if (value != null) {
                    formProvider.setUserNameField(value);
                  }
                  return null;
                },
                validation: (val) {
                  return _authValidators.userNameValidator(val);
                },
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
