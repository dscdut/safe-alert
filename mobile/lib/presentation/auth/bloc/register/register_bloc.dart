import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_template/data/dtos/auth/register_response_dto.dart';
import 'package:flutter_template/data/repositories/user_repository.dart';
import 'package:flutter_template/generated/locale_keys.g.dart';
import 'package:flutter_template/presentation/auth/bloc/register/register_state.dart';

part 'register_event.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final UserRepository userRepository;
  RegisterBloc({required this.userRepository}) : super(const RegisterState()) {
    on<RegisterSubmit>(_onSubmitRegister);
  }

  Future<void> _onSubmitRegister(
      RegisterSubmit event, Emitter<RegisterState> emit) async {
    emit(state.copyWith(isLoading: true));

    try {
      await userRepository.registerByEmailAndPhoneNumber(event.registerDTO);
      emit(state.copyWith(isLoading: false, isSuccess: true));
    } on DioException catch (exception) {
      if (exception.response != null && exception.response!.statusCode == 409) {
        emit(state.copyWith(
            isLoading: false,
            isSuccess: false,
            error: LocaleKeys.validator_email_or_phone_number_exists.tr()));
      } else {
        emit(state.copyWith(
            isLoading: false,
            isSuccess: false,
            error: LocaleKeys.texts_error_occur.tr()));
      }
    }
  }
}
