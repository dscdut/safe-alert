import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_template/data/dtos/auth/register_response_dto.dart';
import 'package:flutter_template/data/repositories/user_repository.dart';

part 'register_event.dart';
part 'register_state.dart';


class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final UserRepository userRepository;
  RegisterBloc({required this.userRepository}) : super(const RegisterState()) {
    on<RegisterSubmit>(_onSubmitRegister);
  }

  Future<void> _onSubmitRegister(RegisterSubmit event, Emitter<RegisterState> emit) async {
    emit(state.copyWith(isLoading: true));

    try {
      await userRepository.registerByEmailAndPhoneNumber(event.registerDTO);
      emit(state.copyWith(isLoading: false, isSuccess: true));
    } on Exception catch (exception) {
        emit(state.copyWith(
            isLoading: false,
            isSuccess: false,
            errorMessage: exception.toString(),),);
    }
  }
}
