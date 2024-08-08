

import 'package:equatable/equatable.dart';
import 'package:final_assignment/features/auth/domain/entity/auth_entity.dart';
import 'package:final_assignment/features/home/domain/entity/doctor_entity.dart';

class FavouriteEntity extends Equatable {
  final String id;
  final DoctorEntity doctor;
  final AuthEntity user;

  FavouriteEntity({required this.id, required this.doctor, required this.user,});

  @override
  List<Object?> get props => [id, doctor, user];

}