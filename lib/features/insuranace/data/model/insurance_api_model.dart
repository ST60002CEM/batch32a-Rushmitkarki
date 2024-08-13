import 'package:final_assignment/features/insuranace/domain/entity/insurance_entity.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:json_annotation/json_annotation.dart';

part 'insurance_api_model.g.dart';

final insuranceApiModelProvider = Provider<InsuranceApiModel>((ref) {
  return const InsuranceApiModel.empty();
});

@JsonSerializable()
class InsuranceApiModel {
  @JsonKey(name: '_id')
  final String? id;
  final String insuranceName;
  final String insuranceDescription;
  final double insurancePrice;
  final String insuranceImage;

  const InsuranceApiModel({
    this.id,
    required this.insuranceName,
    required this.insuranceDescription,
    required this.insurancePrice,
    required this.insuranceImage,
  });

  const InsuranceApiModel.empty()
      : id = '',
        insuranceName = '',
        insuranceDescription = '',
        insurancePrice = 0,
        insuranceImage = '';

  factory InsuranceApiModel.fromJson(Map<String, dynamic> json) =>
      _$InsuranceApiModelFromJson(json);

  Map<String, dynamic> toJson() => _$InsuranceApiModelToJson(this);

  // to entitylist

  // from entity
  factory InsuranceApiModel.fromEntity(InsuranceEntity entity) {
    return InsuranceApiModel(
      id: entity.insuranceid,
      insuranceName: entity.insuranceName,
      insuranceDescription: entity.insuranceDescription,
      insurancePrice: entity.insurancePrice,
      insuranceImage: entity.insuranceImage,
    );
  }

  // to entity
  InsuranceEntity toEntity() {
    return InsuranceEntity(
      insuranceid: id,
      insuranceName: insuranceName,
      insuranceDescription: insuranceDescription,
      insurancePrice: insurancePrice,
      insuranceImage: insuranceImage,
    );
  }
}
