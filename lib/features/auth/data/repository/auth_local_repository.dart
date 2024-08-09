import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:final_assignment/core/failure/failure.dart';
import 'package:final_assignment/features/auth/data/data_source/local/auth_local_data_source.dart';
import 'package:final_assignment/features/auth/domain/entity/auth_entity.dart';
import 'package:final_assignment/features/auth/domain/repository/i_auth_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authLocalRepositoryProvider = Provider<IAuthRepository>((ref) {
  return AuthLocalRepository(
      authLocalDataSource: ref.read(authLocalDataSourceProvider));
});

class AuthLocalRepository implements IAuthRepository {
  final AuthLocalDataSource authLocalDataSource;

  AuthLocalRepository({required this.authLocalDataSource});

  @override
  Future<Either<Failure, bool>> registerUser(AuthEntity user) {
    return authLocalDataSource.registerUser(user);
  }

  @override
  Future<Either<Failure, bool>> loginUser(String email, String password) {
    return authLocalDataSource.loginUser(email, password);
  }

  @override
  Future<Either<Failure, bool>> registerDoctor(AuthEntity doctor) {
    // TODO: implement registerDoctor
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, bool>> fingerPrintLogin(String id) {
    // TODO: implement fingerPrintLogin
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, AuthEntity>> getCurrentUser() {
    // TODO: implement getCurrentUser
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, bool>> verifyUser() {
    // TODO: implement verifyUser
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, bool>> updateProfile(AuthEntity authEntity) {
    // TODO: implement updateProfile
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, String>> uploadProfilePicture(File image) {
    // TODO: implement uploadProfilePicture
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, bool>> resetPass(
      {required String contact,
      required String password,
      required String otp,
      required bool isPhone}) {
    // TODO: implement resetPass
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, bool>> sendOtp(
      {required String contact, required bool isPhone}) {
    // TODO: implement sendOtp
    throw UnimplementedError();
  }
}
