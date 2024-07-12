import 'package:final_assignment/features/home/domain/entity/doctor_entity.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:json_annotation/json_annotation.dart';

part 'doctor_api_model.g.dart';

final doctorApiModelProvider = Provider<DoctorApiModel>((ref) {
  return const DoctorApiModel.empty();
});

@JsonSerializable()
class DoctorApiModel {
  @JsonKey(name: '_id')
  final String? id;
  final String doctorName;
  final String doctorField;
  final double doctorExperience;
  final double doctorFee;
  final String doctorImage;

  const DoctorApiModel({
    this.id,
    required this.doctorName,
    required this.doctorField,
    required this.doctorExperience,
    required this.doctorFee,
    required this.doctorImage,
  });

  const DoctorApiModel.empty()
      : id = '',
        doctorName = '',
        doctorField = '',
        doctorExperience = 0,
        doctorFee = 0,
        doctorImage = '';

  DoctorEntity toEntity() {
    return DoctorEntity(
      doctorid: id,
      doctorName: doctorName,
      doctorField: doctorField,
      doctorExperience: doctorExperience.toString(),
      doctorFee: doctorFee.toString(),
      doctorImage: doctorImage, 
    );
  }

  factory DoctorApiModel.fromJson(Map<String, dynamic> json) =>
      _$DoctorApiModelFromJson(json);
  Map<String, dynamic> toJson() => _$DoctorApiModelToJson(this);
  // to entitylist
  List<DoctorEntity> toEntityList(List<DoctorApiModel> doctors) {
    return doctors.map((doctor) => doctor.toEntity()).toList();
  }
}
