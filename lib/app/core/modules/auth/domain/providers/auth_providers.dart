import 'package:connect_app/app/core/modules/auth/domain/providers/controller/auth_controller.dart';
import 'package:connect_app/app/core/modules/auth/domain/providers/controller/text_form_controller.dart';
import 'package:connect_app/app/core/modules/auth/domain/providers/state/auth_state.dart';
import 'package:connect_app/app/core/modules/auth/domain/repo/auth_repo.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authFormController =
    ChangeNotifierProvider((ref) => MyAuthFormController());

final authRepositoryProvider = Provider<AuthRepo>((ref) {
  return AuthRepo(FirebaseAuth
      .instance); // or just use the AuthRepo line instead of defining a new variable
});
final authControllerProvider =
    StateNotifierProvider<AuthController, AuthState>((ref) {
  return AuthController(AuthState(), ref.read(authRepositoryProvider));
});

final authStateProvider = StreamProvider<User?>((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  ref.read(authControllerProvider);
  return authRepository.authStateChanges;
});
final checkIfAuthinticated =
    FutureProvider((ref) => ref.watch(authStateProvider));
