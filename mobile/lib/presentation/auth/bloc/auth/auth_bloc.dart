import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_template/data/models/user_model.dart';
import 'package:flutter_template/data/repositories/user_repository.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc({required UserRepository userRepository})
      : _userRepository = userRepository,
        super(const AuthState.unknown()) {
    on<AuthUserInfoSet>(_onSetUserInfo);
    on<AuthUserInfoCheck>(_onCheckUserInfo);
  }
  final UserRepository _userRepository;

  void _onCheckUserInfo(
    AuthUserInfoCheck event,
    Emitter<AuthState> emit,
  ) {
    try {
      final UserModel? user = _userRepository.getUserInfo();

      _changeAuthState(user, emit);
    } catch (err) {
      emit(const AuthState.unauthenticated());
    }
  }

  void _onSetUserInfo(AuthUserInfoSet event, Emitter<AuthState> emit) {
    _changeAuthState(event.currentUser, emit);
  }

  void _changeAuthState(UserModel? user, Emitter<AuthState> emit) {
    if (user == null) {
      emit(const AuthState.unauthenticated());
    } else {
      emit(AuthState.authenticated(user));
    }
  }
}
