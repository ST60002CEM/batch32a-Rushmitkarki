// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'insurance_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InsuranceDto _$InsuranceDtoFromJson(Map<String, dynamic> json) => InsuranceDto(
      success: json['success'] as bool,
      message: json['message'] as String,
      insurance: (json['insurance'] as List<dynamic>)
          .map((e) => InsuranceApiModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$InsuranceDtoToJson(InsuranceDto instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'insurance': instance.insurance,
    };
