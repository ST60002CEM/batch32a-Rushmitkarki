import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:final_assignment/core/failure/failure.dart';
import 'package:final_assignment/core/networking/remote/http_service.dart';
import 'package:final_assignment/features/auth/data/data_source/remote/auth_remote_data_source.dart';
import 'package:final_assignment/features/auth/domain/entity/auth_entity.dart';
import 'package:final_assignment/features/auth/domain/repository/i_auth_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authRemoteRepositoryProvider = Provider<IAuthRepository>(
  (ref) => AuthRemoteRepository(
    authRemoteDataSource: ref.read(authRemoteDataSourceProvider),
    dio: ref.read(
        httpServiceProvider), // Ensure you have a dioProvider to provide the Dio instance
  ),
);

class AuthRemoteRepository implements IAuthRepository {
  final AuthRemoteDataSource authRemoteDataSource;
  final Dio dio;

  AuthRemoteRepository({
    required this.authRemoteDataSource,
    required this.dio, // Ensure Dio is injected
  });

  @override
  Future<Either<Failure, bool>> loginUser(String email, String password) {
    return authRemoteDataSource.loginUser(email: email, password: password);
  }

  @override
  Future<Either<Failure, bool>> registerUser(AuthEntity user) {
    return authRemoteDataSource.registerUser(user);
  }

  @override
  Future<Either<Failure, bool>> registerDoctor(AuthEntity doctor) {
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, bool>> verifyUser() {
    return authRemoteDataSource.verifyUser();
  }

  @override
  Future<Either<Failure, AuthEntity>> getCurrentUser() {
    return authRemoteDataSource.getMe();
  }

  @override
  Future<Either<Failure, bool>> fingerPrintLogin(String id) {
    return authRemoteDataSource.fingerPrintLogin(id);
  }

  @override
  Future<Either<Failure, bool>> updateProfile(AuthEntity authEntity) async {
    return authRemoteDataSource.updateUser(authEntity);
  }

  @override
  Future<Either<Failure, String>> uploadProfilePicture(File file) async {
    return authRemoteDataSource.uploadProfilePicture(file);
  }

  @override
  Future<Either<Failure, bool>> sendOtp(String phone) {
    return authRemoteDataSource.sentOtp(phone);
  }

  @override
  Future<Either<Failure, bool>> resetPass(
      {required String phone, required String password, required String otp}) {
    return authRemoteDataSource.resetPassword(
        phone: phone, password: password, otp: otp);
  }
}
