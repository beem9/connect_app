import 'package:connect_app/app/config/routes/my_named_routes.dart';
import 'package:connect_app/app/config/theme/my_colors.dart';
import 'package:connect_app/app/core/extensions/build_context_extension.dart';
import 'package:connect_app/app/core/modules/auth/domain/providers/auth_providers.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class SplashScreen extends ConsumerWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final checkIfAuth = ref.watch(checkIfAuthinticated);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'splashscreen',
          style: context.theme.textTheme.titleMedium?.copyWith(
            color: MyColors.black,
          ),
        ),
        backgroundColor: Colors.orangeAccent,
      ),
      body: checkIfAuth.when(data: (AsyncValue<User?> data) {
        if (data.value?.uid != null) {
          /*
          Sometimes, you need to perform certain tasks after the UI has been updated and rendered. 
          This could involve measuring the size of a widget, showing a dialog, or animating elements 
          based on their final positions.
          Using WidgetsBinding.instance.addPostFrameCallback allows you to delay these tasks until the next frame,
          ensuring the UI is fully updated and the correct dimensions are available
          */
          WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
            context.goNamed(MyNamedRoutes.home);
          });
        } else {
          WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
            context.goNamed(MyNamedRoutes.register);
          });
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      }, error: (Object error, StackTrace stackTrace) {
        return Center(child: Text(error.toString()));
      }, loading: () {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }),
    );
  }
}
