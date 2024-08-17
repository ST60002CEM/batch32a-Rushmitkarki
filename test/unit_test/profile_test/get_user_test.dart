import 'package:dartz/dartz.dart';
import 'package:final_assignment/core/failure/failure.dart';
import 'package:final_assignment/core/shared_prefs/user_shared_prefs.dart';
import 'package:final_assignment/features/auth/domain/entity/auth_entity.dart';
import 'package:final_assignment/features/auth/domain/usecases/auth_usecase.dart';
import 'package:final_assignment/features/profile/presentation/navigator/profile_navigator.dart';
import 'package:final_assignment/features/profile/presentation/viewmodel/profile_view_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../auth_test/auth_test.mocks.dart';
import 'get_user_test.mocks.dart';

// Generate mocks using build_runner
@GenerateNiceMocks([
  MockSpec<ProfileNavigator>(),
  MockSpec<UserSharedPrefs>(),
])
void main() {
  late ProviderContainer container;
  late AuthUseCase mockAuthUseCase;
  late ProfileNavigator mockNavigator;
  late UserSharedPrefs mockUserSharedPrefs;
  late MockGoogleSignInService mockgoogleSignInService;

  setUp(() {
    mockAuthUseCase = MockAuthUseCase();
    mockNavigator = MockProfileNavigator();
    mockUserSharedPrefs = MockUserSharedPrefs();
    mockgoogleSignInService = MockGoogleSignInService();

    container = ProviderContainer(overrides: [
      profileViewmodelProvider.overrideWith((ref) => ProfileViewmodel(
          navigator: mockNavigator,
          userSharedPrefs: mockUserSharedPrefs,
          authUseCase: mockAuthUseCase,
          googleSignInService: mockgoogleSignInService))
    ]);
  });

  group('ProfileViewmodel tests - getCurrentUser', () {
    test('getCurrentUser succeeds and updates state correctly', () async {
      // Mock data
      const authEntity = AuthEntity(
        userId: '123456789123457',
        fName: 'Rushmit',
        lName: 'Karki',
        email: 'karki@gmail.com',
        password: '12345678',
        phone: '1234567890',
      );

      // Stub authUseCase.getCurrentUser()
      when(mockAuthUseCase.getCurrentUser())
          .thenAnswer((_) => Future.value(const Right(authEntity)));

      // Stub userSharedPrefs.checkId() to return Right with matching userIddev dep
      when(mockUserSharedPrefs.checkId())
          .thenAnswer((_) async => Right<Failure, String>(authEntity.fName));

      // act
      await container.read(profileViewmodelProvider.notifier).getCurrentUser();
      // Execute getCurrentUse
      final profileState = container.read(profileViewmodelProvider);

      // Verify state updates
      expect(profileState.isLoading, false);
      expect(profileState.error, isNull);
      expect(profileState.authEntity, authEntity);

      // Verify interactions
      verify(mockAuthUseCase.getCurrentUser()).called(2);
      verify(mockUserSharedPrefs.checkId()).called(1);
    });

    test('getCurrentUser fails and updates error state', () async {
      // Mock failure response
      final failure = Failure(error: 'Failed to fetch current user');

      // Stub authUseCase.getCurrentUser()
      when(mockAuthUseCase.getCurrentUser())
          .thenAnswer((_) => Future.value(Left(failure)));
      // Stub userSharedPrefs.checkId() to return Right with matching userId
      when(mockUserSharedPrefs.checkId())
          .thenAnswer((_) async => Future.value(const Right('')));
// act
      await container.read(profileViewmodelProvider.notifier).getCurrentUser();
      // Execute getCurrentUse
      final profileState = container.read(profileViewmodelProvider);

      // Verify state updates
      expect(profileState.isLoading, false);
      expect(profileState.error, isNotNull);
      expect(profileState.authEntity, isNull);

      // Verify interactions
      verify(mockAuthUseCase.getCurrentUser()).called(2);
      verifyNever(mockUserSharedPrefs.checkId());
    });
  });

  tearDown(() {
    // Clean up
    container.dispose();
  });
}
