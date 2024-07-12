import 'package:dartz/dartz.dart';
import 'package:final_assignment/features/home/domain/entity/doctor_entity.dart';
import 'package:final_assignment/features/home/domain/usecases/doctor_usecase.dart';
import 'package:final_assignment/features/home/presentation/viewmodel/doctor_view_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'doctor_pagination_test.mocks.dart';

@GenerateMocks([DoctorUsecase])
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

  test('DoctorViewModel pagination test', () async {
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
    final doctorsPage2 = List<DoctorEntity>.generate(
      6,
      (index) => DoctorEntity(
        doctorid: (index + 6).toString(),
        doctorName: 'Doctor ${index + 6}',
        doctorField: 'Field ${index + 6}',
        doctorExperience: '${index + 7} years',
        doctorFee: '${(index + 6) * 10} USD',
        doctorImage: 'image_${index + 6}.png',
      ),
    );

    // Set up the mock to return paginated data
    when(mockDoctorUsecase.paginateDoctors(1, 6)).thenAnswer(
      (_) async => Right(doctorsPage1),
    );
    when(mockDoctorUsecase.paginateDoctors(2, 6)).thenAnswer(
      (_) async => Right(doctorsPage2),
    );

    // Explicitly call getDoctors
    await doctorViewModel.getDoctors();
    expect(
      container.read(doctorViewModelProvider).doctors,
      equals(doctorsPage1),
    );

    // Load next page (page 2)
    await doctorViewModel.getDoctors();
    expect(
      container.read(doctorViewModelProvider).doctors,
      equals([...doctorsPage1, ...doctorsPage2]),
    );

    // Verify the usecase methods were called with correct parameters
    verify(mockDoctorUsecase.paginateDoctors(1, 6)).called(1);
    verify(mockDoctorUsecase.paginateDoctors(2, 6)).called(1);
  });
}
