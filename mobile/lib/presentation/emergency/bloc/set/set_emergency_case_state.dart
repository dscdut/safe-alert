part of 'set_emergency_case_bloc.dart';

class SetEmergencyCaseState extends Equatable {
  final List<EmergencyCaseDTO> emergencyCases;
  final bool isLoading;
  final bool isSuccess;
  final String errorMessage;

  const SetEmergencyCaseState({
    this.emergencyCases = const [],
    this.isLoading = false,
    this.isSuccess = false,
    this.errorMessage = '',
  });

  @override
  List<Object> get props =>
      [emergencyCases, isLoading, isSuccess, errorMessage];

  SetEmergencyCaseState copyWith({
    List<EmergencyCaseDTO>? emergencyCases,
    bool? isLoading,
    bool? isSuccess,
    String? errorMessage,
  }) {
    return SetEmergencyCaseState(
      emergencyCases: emergencyCases ?? this.emergencyCases,
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
