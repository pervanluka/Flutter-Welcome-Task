import 'package:bloc/bloc.dart';
import 'package:welcome_task/feature/auth/cubit/auth_state.dart';
import 'package:welcome_task/service/firebase/auth_repository.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepository authRepository;
  AuthCubit({required this.authRepository}) : super(Loading()) {
    if (authRepository.isLogged != null) {
      emit(Authenticated(authRepository.isLogged!));
    } else {
      emit(UnAuthenticated());
    }
  }

  void signInRequst(String email, String password) async {
    emit(Loading());
    try {
      final user =
          await authRepository.signIn(email: email, password: password);
      if (user != null) {
        emit(Authenticated(user));
      } else {
        emit(UnAuthenticated());
      }
    } catch (e) {
      emit(AuthError(e.toString()));
      emit(UnAuthenticated());
    }
  }

  void signUpRequst(String email, String password) async {
    emit(Loading());
    try {
      final user =
          await authRepository.signUp(email: email, password: password);
      if (user != null) {
        emit(Authenticated(user));
      } else {
        emit(UnAuthenticated());
      }
    } catch (e) {
      emit(AuthError(e.toString()));
      emit(UnAuthenticated());
    }
  }

  void googleSignInRequest() async {
    emit(Loading());
    try {
      final user = await authRepository.signInWithGoogle();
      if (user != null) {
        emit(Authenticated(user));
      } else {
        emit(UnAuthenticated());
      }
    } catch (e) {
      emit(AuthError(e.toString()));
      emit(UnAuthenticated());
    }
  }

  void signOutRequest() {
    emit(Loading());
    authRepository.signOut();
    emit(UnAuthenticated());
  }
}
