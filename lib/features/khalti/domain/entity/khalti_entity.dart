import 'package:equatable/equatable.dart';

class KhaltiEntity extends Equatable {
  final String? id;
  final String transactionId;
  final String pidx;
  final String productId;
  final double amount;
  final Map<String, dynamic>? dataFromVerificationReq;
  final Map<String, dynamic>? apiQueryFromUser;
  final String? paymentGateway;
  final String? status;

  const KhaltiEntity({
    this.id,
    required this.transactionId,
    required this.pidx,
    required this.productId,
    required this.amount,
    this.dataFromVerificationReq,
    this.apiQueryFromUser,
    this.paymentGateway,
    this.status,
  });

  @override
  List<Object?> get props => [
        id,
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
