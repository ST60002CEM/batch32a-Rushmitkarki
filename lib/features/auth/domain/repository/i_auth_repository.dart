import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:final_assignment/core/failure/failure.dart';
import 'package:final_assignment/core/provider/internet_connectivity.dart';
import 'package:final_assignment/features/auth/data/repository/auth_local_repository.dart';
import 'package:final_assignment/features/auth/data/repository/auth_remote_repository.dart';
import 'package:final_assignment/features/auth/domain/entity/auth_entity.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authRepositoryProvider = Provider<IAuthRepository>((ref) {
  // check internet connectivity
  final checkConncetivity = ref.read(connectivityStatusProvider);
  if (checkConncetivity == ConnectivityStatus.isConnected) {
    return (ref.read(authRemoteRepositoryProvider));
  } else {
    return (ref.read(authLocalRepositoryProvider));
  }
});

abstract class IAuthRepository {
  Future<Either<Failure, bool>> registerUser(AuthEntity user);

  Future<Either<Failure, bool>> loginUser(String email, String password);

  // doctor
  Future<Either<Failure, bool>> registerDoctor(AuthEntity doctor);

  Future<Either<Failure, bool>> verifyUser();

  Future<Either<Failure, AuthEntity>> getCurrentUser();

  Future<Either<Failure, bool>> fingerPrintLogin(String id);

  Future<Either<Failure, bool>> updateProfile(AuthEntity user);

  Future<Either<Failure, String>> uploadProfilePicture(File file);

  Future<Either<Failure, bool>> sendOtp(
      {required String contact, required bool isPhone});

  Future<Either<Failure, bool>> resetPass(
      {required String contact,
      required String password,
      required String otp,
      required bool isPhone});

  Future<Either<Failure, AuthEntity>> getUserByGoogle(String token);

  Future<Either<Failure, bool>> googleLogin(String token, String? password);

  Future<Either<Failure, List<AuthEntity>>> searchUser(String query);
}
