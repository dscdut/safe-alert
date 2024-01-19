part of 'register_bloc.dart';

abstract class RegisterEvent {}

class RegisterSubmit extends RegisterEvent {
  final RegisterDTO registerDTO;

  RegisterSubmit({required this.registerDTO});
}
