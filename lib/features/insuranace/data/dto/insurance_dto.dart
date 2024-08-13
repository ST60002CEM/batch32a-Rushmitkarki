import 'package:final_assignment/features/insuranace/data/model/insurance_api_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'insurance_dto.g.dart';

@JsonSerializable()
class InsuranceDto {
  final bool success;
  final String message;
  final List<InsuranceApiModel> data;

  InsuranceDto({
    required this.success,
    required this.message,
    required this.data,
  });

  Map<String, dynamic> tojson() => _$InsuranceDtoToJson(this);

  factory InsuranceDto.fromJson(Map<String, dynamic> json) =>
      _$InsuranceDtoFromJson(json);
}
