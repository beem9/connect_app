import 'package:connect_app/app/features/auth/domain/providers/state/auth_state.dart';
import 'package:connect_app/app/features/auth/domain/repo/auth_repo.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthController extends StateNotifier<AuthState> {
  AuthController(super.state, this._authRepo);

  final AuthRepo _authRepo;
  Future<bool> register(
      {required String email,
      required String userName,
      required String password}) async {
    state = state.copyWith(isLoading: true);
    try {
      User? user = await _authRepo.createUserWithEmailAndPassword(
          email: email, password: password, userName: userName);
      if (user != null) {
        await user.updateDisplayName(userName);
        state = state.copyWith(isLoading: false, isAuth: true);

        return true;
      }
    } catch (e) {
      return false;
    }
    return false;
  }

  Future googleSign() async {
    state = state.copyWith(isLoading: true);
    try {
      final user = await _authRepo.signInWithGoogle();
      if (user != null) {
        state = state.copyWith(isAuth: true);
      }
      state = state.copyWith(isLoading: false);
    } catch (e) {
      state = state.copyWith(isLoading: false);
      throw e.toString();
    }
  }

  Future<bool> signOut() async {
    try {
      await _authRepo.signOut();
      state = state.copyWith(
        isAuth: false,
        error: null,
      );
      return true;
    } catch (e) {
      return false;
    }
  }
}
