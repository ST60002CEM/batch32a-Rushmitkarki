import 'package:equatable/equatable.dart';
import 'package:final_assignment/features/khalti/domain/entity/khalti_entity.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:json_annotation/json_annotation.dart';

part 'khalti_api_model.g.dart';

final khaltiApiModelProvider = Provider<KhaltiApiModel>((ref) {
  return const KhaltiApiModel.empty();
});

@JsonSerializable()
class KhaltiApiModel extends Equatable {
  @JsonKey(name: "_id")
  final String? id;
  final String transactionId;
  final String pidx;
  final String productId;
  final double amount;
  final Map<String, dynamic>? dataFromVerificationReq;
  final Map<String, dynamic>? apiQueryFromUser;
  final String? paymentGateway;
  final String? status;

  const KhaltiApiModel({
    required this.id,
    required this.transactionId,
    required this.pidx,
    required this.productId,
    required this.amount,
    this.dataFromVerificationReq,
    this.apiQueryFromUser,
    this.paymentGateway,
    this.status,
  });

  const KhaltiApiModel.empty()
      : id = '',
        transactionId = '',
        pidx = '',
        productId = '',
        amount = 0.0,
        dataFromVerificationReq = const {},
        apiQueryFromUser = const {},
        paymentGateway = '',
        status = '';

  factory KhaltiApiModel.fromJson(Map<String, dynamic> json) =>
      _$KhaltiApiModelFromJson(json);

  Map<String, dynamic> toJson() => _$KhaltiApiModelToJson(this);

// from entity
  factory KhaltiApiModel.froEntity(KhaltiEntity entity) {
    return KhaltiApiModel(
      id: entity.id,
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
      id: id,
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

  @override
  List<Object?> get props => [
        transactionId,
        pidx,
        productId,
        amount,
        dataFromVerificationReq,
        apiQueryFromUser,
        paymentGateway,
        status,
      ];
}
