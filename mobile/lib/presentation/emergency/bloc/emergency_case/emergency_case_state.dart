part of 'emergency_case_bloc.dart';

class EmergencyCaseState extends Equatable {
  final List<EmergencyCaseDTO> emergencyCases;
  final bool isLoading;
  final bool isSuccess;
  final String errorMessage;

  const EmergencyCaseState({
    this.emergencyCases = const [],
    this.isLoading = false,
    this.isSuccess = false,
    this.errorMessage = '',
  });

  @override
  List<Object> get props =>
      [emergencyCases, isLoading, isSuccess, errorMessage];

  EmergencyCaseState copyWith({
    List<EmergencyCaseDTO>? emergencyCases,
    bool? isLoading,
    bool? isSuccess,
    String? errorMessage,
  }) {
    return EmergencyCaseState(
      emergencyCases: emergencyCases ?? this.emergencyCases,
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
