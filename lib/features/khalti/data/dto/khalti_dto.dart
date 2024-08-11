import 'package:json_annotation/json_annotation.dart';

part 'khalti_dto.g.dart';

@JsonSerializable()
class KhaltiDto {
  final String transactionId;
  final String pidx;
  final String productId;
  final double amount;
  final Map<String, dynamic> dataFromVerificationReq;
  final Map<String, dynamic> apiQueryFromUser;
  final String paymentGateway;
  final String status;

  KhaltiDto({
    required this.transactionId,
    required this.pidx,
    required this.productId,
    required this.amount,
    required this.dataFromVerificationReq,
    required this.apiQueryFromUser,
    required this.paymentGateway,
    required this.status,
  });

//   Add factory method for creating dto from json

  Map<String, dynamic> toJson() => _$KhaltiDtoToJson(this);

  factory KhaltiDto.fromJson(Map<String, dynamic> json) =>
      _$KhaltiDtoFromJson(json);
}
