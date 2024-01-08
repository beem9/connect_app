import 'package:connect_app/app/config/routes/my_named_routes.dart';
import 'package:connect_app/app/core/extensions/build_context_extension.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
//import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: GestureDetector(
        onTap: () {
          context.pushNamed(MyNamedRoutes.register);
        },
        child: Container(
            height: context.screenHeight * 0.2,
            width: context.screenWidth * 0.2,
            color: Colors.amber,
            child: Text(context.translate.login)),
      )),
    );
  }
}
