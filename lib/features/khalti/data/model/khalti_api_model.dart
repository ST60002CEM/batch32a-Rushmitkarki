import 'package:final_assignment/features/khalti/domain/entity/khalti_entity.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:json_annotation/json_annotation.dart';

final khaltiApiModelProvider = Provider<KhaltiApiModel>((ref){
  return  KhaltiApiModel.empty();
});
@JsonSerializable()
class KhaltiApiModel {
  final String transactionId;
  final String pidx;
  final String productId;
  final double amount;
  final Map<String, dynamic> dataFromVerificationReq;
  final Map<String, dynamic> apiQueryFromUser;
  final String paymentGateway;
  final String status;


  KhaltiApiModel({
    required this.transactionId,
    required this.pidx,
    required this.productId,
    required this.amount,
    required this.dataFromVerificationReq,
    required this.apiQueryFromUser,
    required this.paymentGateway,
    required this.status,

  });

  const KhaltiApiModel.empty()
      : transactionId = '',
        pidx = '',
        productId = '',
        amount = 0.0,
        dataFromVerificationReq = const {},
        apiQueryFromUser = const {},
        paymentGateway = '',
        status = '',


  factory KhaltiApiModel.fromJson(Map<String, dynamic> json) =>
      _$KhaltiApiModelFromJson(json);

  Map<String, dynamic> toJson() => _$KhaltiApiModelToJson(this);

// from entity
  factory KhaltiApiModel.froEntity(KhaltiEntity entity) {
    return KhaltiApiModel(
      transactionId: entity.transactionId,
      pidx: entity.pidx,
      productId: entity.productId,
      amount: entity.amount,
      dataFromVerificationReq: entity.dataFromVerificationReq,
      apiQueryFromUser: entity.apiQueryFromUser,
      paymentGateway: entity.paymentGateway,
      status: entity.status,

    );
  }

  KhaltiEntity toEntity() {
    return KhaltiEntity(
      transactionId: transactionId,
      pidx: pidx,
      productId: productId,
      amount: amount,
      dataFromVerificationReq: dataFromVerificationReq,
      apiQueryFromUser: apiQueryFromUser,
      paymentGateway: paymentGateway,
      status: status,

    );
  }
}
