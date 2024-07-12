import 'package:dartz/dartz.dart';
import 'package:final_assignment/core/failure/failure.dart';
import 'package:final_assignment/features/auth/domain/entity/auth_entity.dart';

import 'package:final_assignment/features/auth/domain/usecases/auth_usecase.dart';
import 'package:final_assignment/features/auth/presentation/navigator/login_navigator.dart';
import 'package:final_assignment/features/auth/presentation/viewmodel/auth_view_model.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:local_auth/local_auth.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'auth_test.mocks.dart';



// generating fake mocks for testing(Authusecase and loginViewNav because viewmodel is dependent on these two class)
@GenerateNiceMocks([
  MockSpec<AuthUseCase>(),
  MockSpec<LoginViewNavigator>(),
  MockSpec<LocalAuthentication>()
])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late AuthUseCase mockAuthUseCase;
  late LoginViewNavigator mockLoginViewNavigator;

  late ProviderContainer container;

  setUp(
    () {
      mockAuthUseCase = MockAuthUseCase();
      mockLoginViewNavigator = MockLoginViewNavigator();

      container = ProviderContainer(
        overrides: [
          authViewModelProvider.overrideWith(
            (ref) => AuthViewModel(
              mockAuthUseCase,
              mockLoginViewNavigator,
            ),
          )
        ],
      );
    },
  );

  // Test
  test('Check for the initial state in Auth State', () {
    final authState = container.read(authViewModelProvider);
    expect(authState.isLoading, false);
    expect(authState.error, isNull);
    expect(authState.isObscure, true);
  });

  // Test 1(login)
  test('Login test with valid username and password', () async {
    // Arrange
    const correctemail = 'test@gmail.com';
    const correctPassword = 'test';

    // arrange
    when(mockAuthUseCase.loginUser(any, any)).thenAnswer((invocation) {
      final email = invocation.positionalArguments[0] as String;
      final password = invocation.positionalArguments[1] as String;
      return Future.value(email == correctemail && password == correctPassword
          ? const Right(true)
          : Left(Failure(error: 'Invalid')));
    });

    // Act
    container
        .read(authViewModelProvider.notifier)
        .loginUser('test@gmail.com', 'test');

    final authState = container.read(authViewModelProvider);

    //Assert
    expect(authState.error, isNull);
  });

  

 // Test 2 (register)
  test(
    'Register new user test with all details test',
    () async {
      // Arrange
      when(mockAuthUseCase.registerUser(any)).thenAnswer((innovation) {
        final auth = innovation.positionalArguments[0] as AuthEntity;
 
        return Future.value(
          auth.email.isNotEmpty &&
                  
                  auth.email.isNotEmpty &&
                  auth.password.isNotEmpty &&
                  
                  auth.email.contains('@') &&
                  auth.email.contains('.') 
                 
              ? const Right(true)
              : Left(
                  Failure(error: 'Invalid details'),
                ),
        );
      });
      // Act
      await container
          .read(authViewModelProvider.notifier)
          .registerUser(const AuthEntity(
            fName: 'rushmit',
            lName: 'karki',
            email: 'rushmit@gmail.com',
            password: '12345678', 
           
          ));
 
      final state = container.read(authViewModelProvider);
 
      // Assert
      expect(state.isLoading, false);
      expect(state.error, null);
    },
  );
  // test 3 (get_all_doctors)

  
  

  tearDown(() {
    container.dispose();
  });
}
