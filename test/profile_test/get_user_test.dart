import 'package:dartz/dartz.dart';
import 'package:final_assignment/core/failure/failure.dart';
import 'package:final_assignment/core/shared_prefs/user_shared_prefs.dart';
import 'package:final_assignment/features/auth/domain/entity/auth_entity.dart';
import 'package:final_assignment/features/auth/domain/usecases/auth_usecase.dart';
import 'package:final_assignment/features/profile/presentation/navigator/profile_navigator.dart';
import 'package:final_assignment/features/profile/presentation/viewmodel/profile_view_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockAuthUseCase extends Mock implements AuthUseCase {}

class MockProfileNavigator extends Mock implements ProfileNavigator {}

class MockUserSharedPrefs extends Mock implements UserSharedPrefs {}

void main() {
  late ProfileViewmodel profileViewmodel;
  late MockAuthUseCase mockAuthUseCase;
  late MockProfileNavigator mockNavigator;
  late MockUserSharedPrefs mockUserSharedPrefs;

  setUp(() {
    mockAuthUseCase = MockAuthUseCase();
    mockNavigator = MockProfileNavigator();
    mockUserSharedPrefs = MockUserSharedPrefs();

    profileViewmodel = ProfileViewmodel(
      navigator: mockNavigator,
      userSharedPrefs: mockUserSharedPrefs,
      authUseCase: mockAuthUseCase,
    );
  });

  group('ProfileViewmodel tests - getCurrentUser', () {
    test('getCurrentUser succeeds and updates state correctly', () async {
      // Mock data
      const authEntity = AuthEntity(
          fName: 'Rushmit',
          lName: 'Karki',
          email: 'karki@gmail.com',
          password: '12345678');
      const authUseCaseResponse =
          Right<Failure, AuthEntity>(authEntity); // Explicit type annotation

      // Stub authUseCase.getCurrentUser()
      when(mockAuthUseCase.getCurrentUser())
          .thenAnswer((_) async => authUseCaseResponse);

      // Stub userSharedPrefs.checkId() to return Right with matching userId
      when(mockUserSharedPrefs.checkId()).thenAnswer((_) async =>
          Right<Failure, String>(authEntity.fName)); // Explicit type annotation

      // Execute getCurrentUser()
      await profileViewmodel.getCurrentUser();

      // Verify state updates
      expect(profileViewmodel.state.isLoading, false);
      expect(profileViewmodel.state.error, isNull);
      expect(profileViewmodel.state.authEntity, authEntity);

      // Verify interactions
      verify(mockAuthUseCase.getCurrentUser()).called(1);
      verify(mockUserSharedPrefs.checkId()).called(1);
    });

    test('getCurrentUser fails and updates error state', () async {
      // Mock failure response
      final failure = Failure(error: 'Failed to fetch current user');
      final authUseCaseResponse =
          Left<Failure, AuthEntity>(failure); // Explicit type annotation

      // Stub authUseCase.getCurrentUser()
      when(mockAuthUseCase.getCurrentUser())
          .thenAnswer((_) async => authUseCaseResponse);

      // Execute getCurrentUser()
      await profileViewmodel.getCurrentUser();

      // Verify state updates
      expect(profileViewmodel.state.isLoading, false);
      expect(profileViewmodel.state.error, failure.error);
      expect(profileViewmodel.state.authEntity, isNull);

      // Verify interactions
      verify(mockAuthUseCase.getCurrentUser()).called(1);
      verifyNever(mockUserSharedPrefs.checkId());
    });
  });

  tearDown(() {
    // Clean up
    profileViewmodel.dispose();
  });
}
