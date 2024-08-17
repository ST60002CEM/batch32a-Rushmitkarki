// import 'package:dartz/dartz.dart';
// import 'package:final_assignment/features/favouritedoctors/domain/usecases/favourite_doctors_usecase.dart';
// import 'package:final_assignment/features/home/domain/entity/doctor_entity.dart';
// import 'package:final_assignment/features/home/presentation/viewmodel/doctor_view_model.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:mockito/annotations.dart';
// import 'package:mockito/mockito.dart';
//
// import 'get_all_doctor_test.mocks.dart';
//
// @GenerateMocks([MockSpec<FavouriteDoctorsUseCase>])
// void main() {
//   TestWidgetsFlutterBinding.ensureInitialized();
//
//   late ProviderContainer container;
//   late FavouriteDoctorsUseCase mockFavouriteDoctorsUseCase;
//   late MockDoctorUsecase mockDoctorUsecase;
//
//   setUp(() {
//     mockFavouriteDoctorsUseCase = MockFavouriteDoctorsUseCase();
//     container = ProviderContainer(
//       overrides: [
//         doctorViewModelProvider.overrideWith(
//           (ref) =>
//               DoctorViewModel(mockDoctorUsecase, mockFavouriteDoctorsUseCase),
//         ),
//       ],
//     );
//   });
//
//   test('DoctorViewModel pagination test', () async {
//     final doctorViewModel = container.read(doctorViewModelProvider.notifier);
//
//     // Mock paginated data
//     final doctorsPage1 = List<DoctorEntity>.generate(
//       6,
//       (index) => DoctorEntity(
//         doctorid: "123",
//         doctorName: "safasl",
//         doctorField: "market",
//         doctorExperience: "10",
//         doctorFee: "100",
//         doctorImage: "1000000",
//       ),
//     );
//     final doctorsPage2 = List<DoctorEntity>.generate(
//       6,
//       (index) => DoctorEntity(
//         doctorid: "123",
//         doctorName: "safasl",
//         doctorField: "market",
//         doctorExperience: "10",
//         doctorFee: "100",
//         doctorImage: "1000000",
//       ),
//     );
//
//     // Set up the mock to return paginated data
//     when(mockDoctorUsecase.paginateDoctors(1, 6, '')).thenAnswer(
//       (_) async => Right(doctorsPage1),
//     );
//     when(mockDoctorUsecase.paginateDoctors(2, 6, '')).thenAnswer(
//       (_) async => Right(doctorsPage2),
//     );
//
//     // Explicitly call getDoctors
//     await doctorViewModel.getDoctors();
//     expect(
//       container.read(doctorViewModelProvider).doctors,
//       equals(doctorsPage1),
//     );
//
//     // Load next page (page 2)
//     await doctorViewModel.getDoctors();
//     expect(
//       container.read(doctorViewModelProvider).doctors,
//       equals([...doctorsPage1, ...doctorsPage2]),
//     );
//
//     // Verify the usecase methods were called with correct parameters
//     verify(mockDoctorUsecase.paginateDoctors(1, 6, '')).called(1);
//     verify(mockDoctorUsecase.paginateDoctors(2, 6, '')).called(1);
//   });
// }

import 'package:dartz/dartz.dart';
import 'package:final_assignment/features/favouritedoctors/domain/usecases/favourite_doctors_usecase.dart';
import 'package:final_assignment/features/home/domain/entity/doctor_entity.dart';
import 'package:final_assignment/features/home/domain/usecases/doctor_usecase.dart';
import 'package:final_assignment/features/home/presentation/viewmodel/doctor_view_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'get_all_doctor_test.mocks.dart';

@GenerateMocks([FavouriteDoctorsUseCase, DoctorUsecase])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late ProviderContainer container;
  late FavouriteDoctorsUseCase mockFavouriteDoctorsUseCase;
  late MockDoctorUsecase mockDoctorUsecase;

  setUp(() {
    mockFavouriteDoctorsUseCase = MockFavouriteDoctorsUseCase();
    mockDoctorUsecase = MockDoctorUsecase();

    container = ProviderContainer(
      overrides: [
        doctorViewModelProvider.overrideWith(
          (ref) =>
              DoctorViewModel(mockDoctorUsecase, mockFavouriteDoctorsUseCase),
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
        doctorid: "123",
        doctorName: "Doctor $index",
        doctorField: "Specialty",
        doctorExperience: "10 years",
        doctorFee: "200",
        doctorImage: "image.png",
      ),
    );

    final doctorsPage2 = List<DoctorEntity>.generate(
      6,
      (index) => DoctorEntity(
        doctorid: "789",
        doctorName: "Doctor ${index + 6}",
        doctorField: "Specialty",
        doctorExperience: "12 years",
        doctorFee: "250",
        doctorImage: "image2.png",
      ),
    );

    // Set up the mock to return paginated data
    when(mockDoctorUsecase.paginateDoctors(1, 6, '')).thenAnswer(
      (_) async => Right(doctorsPage1),
    );
    when(mockDoctorUsecase.paginateDoctors(2, 6, '')).thenAnswer(
      (_) async => Right(doctorsPage2),
    );

    // Call the first page of data
    await doctorViewModel.getDoctors();
    expect(
        container.read(doctorViewModelProvider).doctors, equals(doctorsPage1));

    // Call the next page of data
    await doctorViewModel.getDoctors();
    expect(container.read(doctorViewModelProvider).doctors,
        equals([...doctorsPage1, ...doctorsPage2]));

    // Verify the usecase methods were called with correct parameters
    verify(mockDoctorUsecase.paginateDoctors(1, 6, '')).called(1);
    verify(mockDoctorUsecase.paginateDoctors(2, 6, '')).called(1);
  });
}
