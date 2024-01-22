import 'package:connect_app/app/config/routes/my_named_routes.dart';
import 'package:connect_app/app/core/modules/auth/domain/providers/auth_providers.dart';
import 'package:connect_app/app/core/modules/chats/domain/models/user_model.dart';
import 'package:connect_app/app/core/modules/chats/domain/providers/providers.dart';
import 'package:connect_app/app/core/extensions/build_context_extension.dart';
import 'package:connect_app/app/core/services/notification_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  @override
  void initState() {
    super.initState();
    notificationSetup.registerNotification();
    notificationSetup.configLocalNotification();
  }

  @override
  Widget build(BuildContext context) {
    final chatUsers = ref.watch(usersProvider);
    final authProvider = ref.read(authControllerProvider.notifier);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Tutors',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color.fromARGB(255, 18, 140, 126),
        iconTheme: const IconThemeData(color: Colors.white),
        actions: [
          IconButton(
            icon: const Icon(Icons.exit_to_app),
            onPressed: () {
              authProvider.signOut().then((value) {
                if (value == true) {
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
              return ListTile(
                onTap: () {
                  context.pushNamed(MyNamedRoutes.chatDetails,
                      extra: data[index]);
                },
                leading: const CircleAvatar(
                  radius: 25,
                  // backgroundImage: AssetImage('assets/user_placeholder.jpg'),
                ),
                title: Text(
                  user.username,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text('Last message...'), // Display the last message
                trailing:
                    Text('12:34 PM'), // Display the time of the last message
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Implement the action for the floating action button
        },
        child: const Icon(Icons.message),
        backgroundColor: const Color.fromARGB(255, 18, 140, 126),
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