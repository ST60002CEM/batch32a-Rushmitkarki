import 'package:final_assignment/features/home/domain/entity/doctor_entity.dart';

class SearchState {
  final List<DoctorEntity> doctors;
  final bool hasReachedMax;
  final int page;
  final bool isLoading;
  final String error;
  final String query;  // For search query
  final String sortOrder;  // For sort order

  SearchState({
    required this.doctors,
    required this.hasReachedMax,
    required this.page,
    required this.isLoading,
    required this.error,
    required this.query,
    required this.sortOrder,
  });

  factory SearchState.initial() {
    return SearchState(
      doctors: [],
      hasReachedMax: false,
      page: 0,
      isLoading: false,
      error: '',
      query: '',
      sortOrder: 'asc',
    );
  }

  get selectedSortOption => null;

  get searchResults => null;

  SearchState copyWith({
    List<DoctorEntity>? doctors,
    bool? hasReachedMax,
    int? page,
    bool? isLoading,
    String? error,
    String? query,
    String? sortOrder,
  }) {
    return SearchState(
      doctors: doctors ?? this.doctors,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      page: page ?? this.page,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      query: query ?? this.query,
      sortOrder: sortOrder ?? this.sortOrder,
    );
  }
}
