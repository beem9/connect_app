import 'package:connect_app/app/core/extensions/build_context_extension.dart';
import 'package:connect_app/app/features/auth/domain/helper/auth_validators.dart';
import 'package:connect_app/app/features/auth/widgets/my_textform_widget.dart';
import 'package:flutter/material.dart';

class MyAuthFormState extends StatefulWidget {
  const MyAuthFormState({super.key, required this.formKey});
  final GlobalKey<FormState> formKey;

  @override
  State<MyAuthFormState> createState() => _MyAuthFormStateState();
}

class _MyAuthFormStateState extends State<MyAuthFormState> {
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
                  onChange: null,
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
                onChange: null,
                validation: (value) {
                  return _authValidators.userNameValidator(value);
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
                obscureText: true,
                onChange: null,
                validation: (value) {
                  return _authValidators.passwordValidator(value);
                },
                suffixIcon: Icon(Icons.remove_red_eye),
              )
            ],
          )),
    );
  }
}
