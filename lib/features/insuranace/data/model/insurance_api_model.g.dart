// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'insurance_api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InsuranceApiModel _$InsuranceApiModelFromJson(Map<String, dynamic> json) =>
    InsuranceApiModel(
      id: json['_id'] as String?,
      insuranceName: json['insuranceName'] as String,
      insuranceDescription: json['insuranceDescription'] as String,
      insurancePrice: (json['insurancePrice'] as num).toDouble(),
      insuranceImage: json['insuranceImage'] as String,
    );

Map<String, dynamic> _$InsuranceApiModelToJson(InsuranceApiModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'insuranceName': instance.insuranceName,
      'insuranceDescription': instance.insuranceDescription,
      'insurancePrice': instance.insurancePrice,
      'insuranceImage': instance.insuranceImage,
    };
