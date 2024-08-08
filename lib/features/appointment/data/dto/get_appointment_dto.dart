import 'package:json_annotation/json_annotation.dart';

import '../model/appointment_model.dart';

part 'get_appointment_dto.g.dart';

@JsonSerializable()
class GetAppointmentDto {
  final bool success;
  final List<AppointmentModel> data;

  GetAppointmentDto({required this.success, required this.data});

  factory GetAppointmentDto.fromJson(Map<String, dynamic> json) =>
      _$GetAppointmentDtoFromJson(json);

  Map<String, dynamic> toJson() => _$GetAppointmentDtoToJson(this);
}
