class RegisterState {
  final bool? isLoading;
  final bool? isSuccess;
  final String? error;

  const RegisterState({
    this.isLoading = false,
    this.isSuccess = false,
    this.error,
  });

  RegisterState copyWith({
    bool? isLoading,
    bool? isSuccess,
    String? error,
  }) {
    return RegisterState(
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      error: error ?? this.error,
    );
  }
}
