import 'package:connect_app/app/config/routes/my_named_routes.dart';
import 'package:connect_app/app/core/chats/domain/models/user_model.dart';
import 'package:connect_app/app/core/chats/domain/providers/providers.dart';
import 'package:connect_app/app/core/extensions/build_context_extension.dart';
import 'package:connect_app/app/features/auth/domain/providers/auth_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final chatUsers = ref.watch(usersProvider);
    final authProvider = ref.read(authControllerProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: Text(context.translate.users),
        actions: [
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () {
              // Perform logout logic
              authProvider.signOut().then((value) {
                if (value == true) {
                  // Navigate to the login page after successful logout
                  context.goNamed(MyNamedRoutes.login);
                }
              });
            },
          ),
        ],
      ),
      body: chatUsers.when(
        data: (List<UserModel> data) {
          return ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, index) {
              final user = data[index];
              return Card(
                child: ListTile(
                  title: Text(user.email),
                  subtitle: Text(user.username),
                ),
              );
            },
          );
        },
        error: (Object error, StackTrace stackTrace) {
          return Center(child: Text(context.translate.register));
        },
        loading: () {
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}



          //   authProvider.signOut().then((value) {
          //     if (value == true) {
          //       context.goNamed(MyNamedRoutes.login);
          //     }
          //   }
          //   );
          // },