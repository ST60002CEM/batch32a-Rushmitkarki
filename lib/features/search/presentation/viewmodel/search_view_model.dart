import 'package:final_assignment/features/home/domain/entity/doctor_entity.dart';
import 'package:final_assignment/features/home/domain/usecases/doctor_usecase.dart';
import 'package:final_assignment/features/search/presentation/state/search_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final searchViewModelProvider =
    StateNotifierProvider<SearchViewModel, SearchState>(
  (ref) => SearchViewModel(ref.read(doctorUsecaseProvider)),
);

class SearchViewModel extends StateNotifier<SearchState> {
  final DoctorUsecase _doctorUsecase;

  SearchViewModel(this._doctorUsecase) : super(SearchState.initial()) {
    fetchDoctors(); // Fetch doctors initially
  }

  Future<void> fetchDoctors() async {
    state = state.copyWith(isLoading: true);
    final result = await _doctorUsecase.paginateDoctors(state.page, 10);
    result.fold(
      (failure) {
        state = state.copyWith(
          hasReachedMax: true,
          isLoading: false,
          error: failure.error,
        );
      },
      (data) {
        state = state.copyWith(
          isLoading: false,
          doctors: data,
          page: state.page + 1,
        );
      },
    );
  }

  Future<void> searchDoctors({
    String query = '',
    String sortOrder = 'asc',
  }) async {
    state = state.copyWith(isLoading: true, query: query, sortOrder: sortOrder);
    final result = await _doctorUsecase.paginateDoctors(state.page, 10);
    result.fold(
      (failure) {
        state = state.copyWith(
          hasReachedMax: true,
          isLoading: false,
          error: failure.error,
        );
      },
      (data) {
        // Apply search and sort logic here
        final filteredAndSortedDoctors =
            applySearchAndSort(data, query, sortOrder);
        if (filteredAndSortedDoctors.isEmpty) {
          state = state.copyWith(hasReachedMax: true, isLoading: false);
        } else {
          state = state.copyWith(
            isLoading: false,
            doctors: [...state.doctors, ...filteredAndSortedDoctors],
            page: state.page + 1,
          );
        }
      },
    );
  }

  List<DoctorEntity> applySearchAndSort(
      List<DoctorEntity> doctors, String query, String sortOrder) {
    List<DoctorEntity> filteredDoctors =
        doctors.where((doctor) => doctor.doctorName.contains(query)).toList();

    if (sortOrder == 'asc') {
      filteredDoctors.sort((a, b) => a.doctorFee.compareTo(b.doctorFee));
    } else {
      filteredDoctors.sort((a, b) => b.doctorFee.compareTo(a.doctorFee));
    }

    return filteredDoctors;
  }

  Future<void> resetState() async {
    state = SearchState.initial();
    await fetchDoctors();
  }
}
