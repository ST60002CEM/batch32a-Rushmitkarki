import 'package:dartz/dartz.dart';
import 'package:final_assignment/core/failure/failure.dart';
import 'package:final_assignment/core/networking/local/hive_service.dart';
import 'package:final_assignment/features/auth/data/model/auth_hive_model.dart';
import 'package:final_assignment/features/auth/domain/entity/auth_entity.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authLocalDataSourceProvider = Provider((ref) => AuthLocalDataSource(
      hiveSerice: ref.read(hiveserviceProvider),
      authHiveModel: ref.read(authHiveModelProvider),
    ));

class AuthLocalDataSource {
  final HiveService hiveSerice;
  final AuthHiveModel authHiveModel;

  AuthLocalDataSource({
    required this.hiveSerice,
    required this.authHiveModel,
  });

  Future<Either<Failure, bool>> registerUser(AuthEntity user) async {
    try {
      //If already email throw error
      final userByEmail = await hiveSerice.getUserByEmail(user.email);
      if (userByEmail != null) {
        return Left(Failure(error: 'Email already exist'));
      }
      

      // Convert Entity to model
      
      final hiveUser = authHiveModel.fromEntity(user);
      await hiveSerice.registerUser(hiveUser);
      return const Right(true);
    } catch (e) {
      return Left(Failure(error: e.toString()));
    }
  }
}
