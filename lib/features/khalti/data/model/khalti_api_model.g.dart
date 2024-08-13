// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'khalti_api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

KhaltiApiModel _$KhaltiApiModelFromJson(Map<String, dynamic> json) =>
    KhaltiApiModel(
      id: json['_id'] as String?,
      transactionId: json['transactionId'] as String,
      pidx: json['pidx'] as String,
      productId: json['productId'] as String,
      amount: (json['amount'] as num).toDouble(),
      dataFromVerificationReq:
          json['dataFromVerificationReq'] as Map<String, dynamic>?,
      apiQueryFromUser: json['apiQueryFromUser'] as Map<String, dynamic>?,
      paymentGateway: json['paymentGateway'] as String?,
      status: json['status'] as String?,
    );

Map<String, dynamic> _$KhaltiApiModelToJson(KhaltiApiModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'transactionId': instance.transactionId,
      'pidx': instance.pidx,
      'productId': instance.productId,
      'amount': instance.amount,
      'dataFromVerificationReq': instance.dataFromVerificationReq,
      'apiQueryFromUser': instance.apiQueryFromUser,
      'paymentGateway': instance.paymentGateway,
      'status': instance.status,
    };
