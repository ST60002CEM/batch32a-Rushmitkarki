import 'package:dartz/dartz.dart';
import 'package:final_assignment/core/failure/failure.dart';
import 'package:final_assignment/features/home/domain/entity/doctor_entity.dart';
import 'package:final_assignment/features/home/domain/usecases/doctor_usecase.dart';
import 'package:final_assignment/features/home/presentation/viewmodel/doctor_view_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'doctor_pagination_test.mocks.dart';

@GenerateNiceMocks([MockSpec<DoctorUsecase>()])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late MockDoctorUsecase mockDoctorUsecase;
  late ProviderContainer container;

  setUp(() {
    mockDoctorUsecase = MockDoctorUsecase();

    container = ProviderContainer(
      overrides: [
        doctorViewModelProvider.overrideWith(
          (ref) => DoctorViewModel(mockDoctorUsecase),
        ),
      ],
    );
  });

  test('DoctorViewModel getAllDoctors test', () async {
    // Mock data for getAllDoctors
    final doctorsList = List<DoctorEntity>.generate(
      6,
      (index) => DoctorEntity(
        doctorid: index.toString(),
        doctorName: 'Doctor $index',
        doctorField: 'Field $index',
        doctorExperience: '${index + 1} years',
        doctorFee: '${index * 10} USD',
        doctorImage: 'image_$index.png',
      ),
    );

    when(mockDoctorUsecase.paginateDoctors(1, 6))
        .thenAnswer((_) async => Future.value(Right(doctorsList)));

    await container.read(doctorViewModelProvider.notifier).getDoctors();

    expect(
        container.read(doctorViewModelProvider).doctors, equals(doctorsList));

    verify(mockDoctorUsecase.paginateDoctors(1, 6)).called(1);
  });

  test('DoctorViewModel getAllDoctors failure test', () async {
    // Mock data for getAllDoctors

    // Mock failure for getAllDoctors
    final failure = Failure(error: 'Failed to fetch doctors');

    when(mockDoctorUsecase.paginateDoctors(any, any))
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
        doctorid: index.toString(),
        doctorName: 'Doctor $index',
        doctorField: 'Field $index',
        doctorExperience: '${index + 1} years',
        doctorFee: '${index * 10} USD',
        doctorImage: 'image_$index.png',
      ),
    );

    when(mockDoctorUsecase.paginateDoctors(any, any))
        .thenAnswer((_) async => Future.value(Right(doctorsList)));
    final doctorViewModel = container.read(doctorViewModelProvider.notifier);

    // Mock paginated data
    final doctorsPage1 = List<DoctorEntity>.generate(
      6,
      (index) => DoctorEntity(
        doctorid: index.toString(),
        doctorName: 'Doctor $index',
        doctorField: 'Field $index',
        doctorExperience: '${index + 1} years',
        doctorFee: '${index * 10} USD',
        doctorImage: 'image_$index.png',
      ),
    );

    // Set up the mock to return paginated data for page 1
    when(mockDoctorUsecase.paginateDoctors(1, 6)).thenAnswer(
      (_) async => Right(doctorsPage1),
    );

    // Explicitly call getDoctors to paginate
    await doctorViewModel.getDoctors();
    expect(
        container.read(doctorViewModelProvider).doctors, equals(doctorsPage1));

    // Verify the usecase method was called with correct parameters
    verify(mockDoctorUsecase.paginateDoctors(1, 6)).called(1);
  });
}
