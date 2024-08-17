import 'package:dartz/dartz.dart';
import 'package:final_assignment/core/failure/failure.dart';
import 'package:final_assignment/features/favouritedoctors/domain/usecases/favourite_doctors_usecase.dart';
import 'package:final_assignment/features/home/domain/entity/doctor_entity.dart';
import 'package:final_assignment/features/home/domain/usecases/doctor_usecase.dart';
import 'package:final_assignment/features/home/presentation/viewmodel/doctor_view_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'get_all_doctor_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<DoctorUsecase>(),
  MockSpec<FavouriteDoctorsUseCase>(),
])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late MockDoctorUsecase mockDoctorUsecase;
  late FavouriteDoctorsUseCase mockFavouriteDoctorsUseCase;
  late ProviderContainer container;

  setUp(() {
    mockDoctorUsecase = MockDoctorUsecase();
    mockFavouriteDoctorsUseCase = MockFavouriteDoctorsUseCase();

    container = ProviderContainer(
      overrides: [
        doctorViewModelProvider.overrideWith(
          (ref) =>
              DoctorViewModel(mockDoctorUsecase, mockFavouriteDoctorsUseCase),
        ),
      ],
    );
  });

  test('DoctorViewModel getAllDoctors test', () async {
    // Mock data for getAllDoctors
    final doctorsList = List<DoctorEntity>.generate(
      6,
      (index) => DoctorEntity(
        doctorid: "123",
        doctorName: "safasl",
        doctorField: "market",
        doctorExperience: "10",
        doctorFee: "100",
        doctorImage: "1000000",
      ),
    );

    when(mockDoctorUsecase.paginateDoctors(1, 6, "first"))
        .thenAnswer((_) async => Future.value(Right(doctorsList)));

    await container.read(doctorViewModelProvider.notifier).getDoctors();

    expect(
        container.read(doctorViewModelProvider).doctors, equals(doctorsList));

    verify(mockDoctorUsecase.paginateDoctors(1, 6, "second")).called(1);
  });

  test('DoctorViewModel getAllDoctors failure test', () async {
    // Mock data for getAllDoctors

    // Mock failure for getAllDoctors
    final failure = Failure(error: 'Failed to fetch doctors');

    when(mockDoctorUsecase.paginateDoctors(any, any, any))
        .thenAnswer((_) async => Future.value(
              Left(failure),
            ));
    final doctorViewModel = container.read(doctorViewModelProvider.notifier);

    // Explicitly call getDoctors
    await doctorViewModel.getDoctors();
    expect(container.read(doctorViewModelProvider).error,
        equals('Failed to fetch doctors'));
  });

  test('DoctorViewModel paginateDoctors test', () async {
    // Mock data for getAllDoctors
    final doctorsList = List<DoctorEntity>.generate(
      6,
      (index) => DoctorEntity(
        doctorid: "123",
        doctorName: "safasl",
        doctorField: "market",
        doctorExperience: "10",
        doctorFee: "100",
        doctorImage: "1000000",
      ),
    );

    when(mockDoctorUsecase.paginateDoctors(any, any, any))
        .thenAnswer((_) async => Future.value(Right(doctorsList)));
    final doctorViewModel = container.read(doctorViewModelProvider.notifier);

    // Mock paginated data
    final doctorsPage1 = List<DoctorEntity>.generate(
      6,
      (index) => DoctorEntity(
        doctorid: "123",
        doctorName: "safasl",
        doctorField: "market",
        doctorExperience: "10",
        doctorFee: "100",
        doctorImage: "1000000",
      ),
    );

    // Set up the mock to return paginated data for page 1
    when(mockDoctorUsecase.paginateDoctors(1, 6, "first")).thenAnswer(
      (_) async => Right(doctorsPage1),
    );

    // Explicitly call getDoctors to paginate
    await doctorViewModel.getDoctors();
    expect(
        container.read(doctorViewModelProvider).doctors, equals(doctorsPage1));

    // Verify the usecase method was called with correct parameters
    verify(mockDoctorUsecase.paginateDoctors(1, 6, "first")).called(1);
  });
}
