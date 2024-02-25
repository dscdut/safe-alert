// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'manage_emergency_case_bloc.dart';

class ManageEmergencyCaseState extends Equatable {
  final List<EmergencyCaseModel> emergencyCases;
  final Status status;
  final String errorMessage;
  const ManageEmergencyCaseState({
    this.emergencyCases = const [],
    this.status = Status.initial,
    this.errorMessage = '',
  });

  @override
  List<Object> get props => [emergencyCases, status, errorMessage];

  ManageEmergencyCaseState copyWith({
    List<EmergencyCaseModel>? emergencyCases,
    Status? status,
    String? errorMessage,
  }) {
    return ManageEmergencyCaseState(
      emergencyCases: emergencyCases ?? this.emergencyCases,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
