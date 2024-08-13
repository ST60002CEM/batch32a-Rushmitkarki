import 'package:final_assignment/features/insuranace/domain/entity/insurance_entity.dart';

class InsuranceState {
  final List<InsuranceEntity> insurance;
  final bool isLoading;
  final String? error;

  InsuranceState({
    required this.insurance,
    required this.isLoading,
    required this.error,
  });

  factory InsuranceState.initial() => InsuranceState(
        insurance: [],
        isLoading: false,
        error: null,
      );

  InsuranceState copyWith({
    List<InsuranceEntity>? insurance,
    bool? isLoading,
    String? error,
  }) {
    return InsuranceState(
      insurance: insurance ?? this.insurance,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }
}
