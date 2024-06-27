import 'package:final_assignment/features/home/data/model/doctor_api_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'doctor_dto.g.dart';

@JsonSerializable()
class DoctorDto {
  final bool success;
  final String message;
  final List<DoctorApiModel> doctors;

  DoctorDto({
    required this.success,
    required this.message,
    required this.doctors,
  });

  Map<String, dynamic> toJson() => _$DoctorDtoToJson(this);
  factory DoctorDto.fromJson(Map<String, dynamic> json) => _$DoctorDtoFromJson(json);
}
