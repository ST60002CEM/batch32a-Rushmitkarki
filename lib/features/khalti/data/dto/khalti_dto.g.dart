// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'khalti_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

KhaltiDto _$KhaltiDtoFromJson(Map<String, dynamic> json) => KhaltiDto(
      transactionId: json['transactionId'] as String,
      pidx: json['pidx'] as String,
      productId: json['productId'] as String,
      amount: (json['amount'] as num).toDouble(),
      dataFromVerificationReq:
          json['dataFromVerificationReq'] as Map<String, dynamic>,
      apiQueryFromUser: json['apiQueryFromUser'] as Map<String, dynamic>,
      paymentGateway: json['paymentGateway'] as String,
      status: json['status'] as String,
    );

Map<String, dynamic> _$KhaltiDtoToJson(KhaltiDto instance) => <String, dynamic>{
      'transactionId': instance.transactionId,
      'pidx': instance.pidx,
      'productId': instance.productId,
      'amount': instance.amount,
      'dataFromVerificationReq': instance.dataFromVerificationReq,
      'apiQueryFromUser': instance.apiQueryFromUser,
      'paymentGateway': instance.paymentGateway,
      'status': instance.status,
    };
