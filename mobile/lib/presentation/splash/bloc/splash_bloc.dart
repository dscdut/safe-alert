import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_template/presentation/auth/bloc/auth/auth_bloc.dart';

part 'splash_event.dart';
part 'splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  SplashBloc({required AuthBloc authBloc})
      : _authBloc = authBloc,
        super(const SplashState()) {
    on<SplashStarted>(_onSplashStarted);
    add(SplashStarted());
  }

  final AuthBloc _authBloc;

  Future<void> _onSplashStarted(
    SplashStarted event,
    Emitter<SplashState> emiiter,
  ) async {
    await Future.delayed(const Duration(milliseconds: 2000));

    _authBloc.add(AuthUserInfoCheck());
  }
}
