import 'package:connect_app/app/config/routes/my_named_routes.dart';
import 'package:connect_app/app/features/auth/domain/providers/auth_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authProvider = ref.read(authControllerProvider.notifier);
    return Scaffold(
      appBar: AppBar(
        title: Text('homepage'),
      ),
      body: Column(children: [
        Center(
            child: ElevatedButton(
                onPressed: () {
                  authProvider.signOut();
                  context.goNamed(MyNamedRoutes.login);
                },
                child: Text('Sign out')))
      ]),
    );
  }
}
