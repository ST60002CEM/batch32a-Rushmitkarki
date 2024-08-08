import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:final_assignment/core/failure/failure.dart';
import 'package:final_assignment/core/shared_prefs/user_shared_prefs.dart';
import 'package:final_assignment/features/auth/domain/entity/auth_entity.dart';
import 'package:final_assignment/features/auth/domain/repository/i_auth_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authUseCaseProvider = Provider<AuthUseCase>((ref) {
  return AuthUseCase(
      authRepository: ref.watch(authRepositoryProvider),
      userSharedPrefs: ref.watch(userSharedPrefsProvider));
});

class AuthUseCase {
  final UserSharedPrefs userSharedPrefs;
  final IAuthRepository authRepository;

  AuthUseCase({required this.authRepository, required this.userSharedPrefs});

  Future<Either<Failure, bool>> registerUser(AuthEntity? auth) {
    return authRepository.registerUser(auth!);
  }

  Future<Either<Failure, bool>> loginUser(String? user, String? password) {
    return authRepository.loginUser(user!, password!);
  }

  Future<Either<Failure, bool>> verifyUser() {
    return authRepository.verifyUser();
  }

  Future<Either<Failure, AuthEntity>> getCurrentUser() {
    return authRepository.getCurrentUser();
  }

  Future<Either<Failure, bool>> fingerPrintLogin() async {
    final data = await userSharedPrefs.checkId();
    return data.fold((l) => Left(Failure(error: l.error)), (r) async {
      if (r != '') {
        await authRepository.fingerPrintLogin(r);
        return const Right(true);
      }
      return Left(Failure(error: 'No fingerprint id found'));
    });
  }

  Future<Either<Failure, bool>> updateProfile(AuthEntity user) {
    return authRepository.updateProfile(user);
  }

  Future<Either<Failure, String>> uploadProfilePicture(File file) {
    return authRepository.uploadProfilePicture(file);
  }

  Future<Either<Failure, bool>> sendOtp(String phone) async {
    return await authRepository.sendOtp(phone);
  }

  //resetPass
  Future<Either<Failure, bool>> resetPass(
      {required String phone,
      required String password,
      required String otp}) async {
    return await authRepository.resetPass(
        phone: phone, password: password, otp: otp);
  }
}
