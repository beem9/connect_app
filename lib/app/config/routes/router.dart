import 'package:connect_app/app/config/routes/my_named_routes.dart';
import 'package:connect_app/app/core/modules/chats/domain/models/user_model.dart';
import 'package:connect_app/app/core/modules/chats/navbar/view/location_screen.dart';
import 'package:connect_app/app/core/modules/chats/navbar/view/navbar_screen.dart';
import 'package:connect_app/app/core/modules/chats/navbar/view/profile_screen.dart';
import 'package:connect_app/app/core/modules/chats/navbar/view/homepage.dart';
import 'package:connect_app/app/core/modules/chats/navbar/widgets/bottom_navbar_tab.dart';
import 'package:connect_app/app/core/modules/one_to_one_chat/views/message_screen.dart';
import 'package:connect_app/app/features/auth/views/login.dart';
import 'package:connect_app/app/features/auth/views/register.dart';
import 'package:connect_app/app/features/auth/views/splashscreen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

///[rootNavigatorKey] used for global | general navigation
final rootNavigatorKey = GlobalKey<NavigatorState>();
final form = GlobalKey<FormState>();
final shellRouteKey = GlobalKey<NavigatorState>();

abstract class AppRouter {
  static Widget errorWidget(BuildContext context, GoRouterState state) =>
      const SizedBox();

  /// use this in [MaterialApp.router]
  static final _router = GoRouter(
    initialLocation: MyNamedRoutes.root,
    navigatorKey: rootNavigatorKey,
    debugLogDiagnostics: true,
    routes: [
      // outside the [ShellRoute] to make the screen on top of the [BottomNavBar]
      GoRoute(
        parentNavigatorKey: rootNavigatorKey,
        path: MyNamedRoutes.root,
        pageBuilder: (context, state) => NoTransitionPage(
          key: state.pageKey,
          child: const SplashScreen(),
        ),
      ),
      GoRoute(
        parentNavigatorKey: rootNavigatorKey,
        path: "/${MyNamedRoutes.login}",
        name: MyNamedRoutes.login,
        pageBuilder: (context, state) => NoTransitionPage(
          key: state.pageKey,
          child: LoginScreen(),
        ),
      ),
      GoRoute(
        parentNavigatorKey: rootNavigatorKey,
        path: "/${MyNamedRoutes.register}",
        name: MyNamedRoutes.register,
        pageBuilder: (context, state) => NoTransitionPage(
          key: state.pageKey,
          child: RegisterScreen(),
        ),
      ),
      GoRoute(
        parentNavigatorKey: rootNavigatorKey,
        path: "/${MyNamedRoutes.chatDetails}",
        name: MyNamedRoutes.chatDetails,
        pageBuilder: (context, state) => NoTransitionPage(
          key: state.pageKey,
          child: ChatRoomPage(
            selectedUser: state.extra as UserModel,
          ),
        ),
      ),

      ShellRoute(
          navigatorKey: shellRouteKey,
          builder: (context, state, child) {
            return ScaffoldWithBottomNavBar(
              tabs: BottomNavBarTabs.tabs(context),
              child: child,
            );
          },
          routes: [
            GoRoute(
                path: "/${MyNamedRoutes.home}",
                name: MyNamedRoutes.home,
                pageBuilder: (context, state) => NoTransitionPage(
                      key: state.pageKey,
                      child: const HomePage(),
                    ),
                routes: []),
            // Add new routes for Profile and Locations screens
            GoRoute(
              path: "/${MyNamedRoutes.profile}",
              name: MyNamedRoutes.profile,
              pageBuilder: (context, state) => NoTransitionPage(
                key: state.pageKey,
                child:
                    const ProfileScreen(), // Replace with your Profile screen
              ),
            ),
            GoRoute(
              path: "/${MyNamedRoutes.location}",
              name: MyNamedRoutes.location,
              pageBuilder: (context, state) => NoTransitionPage(
                key: state.pageKey,
                child:
                    const LocationsScreen(), // Replace with your Locations screen
              ),
            ),
          ])
    ],
    errorBuilder: errorWidget,
  );

  static GoRouter get router => _router;
}
