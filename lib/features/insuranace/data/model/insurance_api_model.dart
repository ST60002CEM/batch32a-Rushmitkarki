class InsuranceModel {
  final String? id;
  final String insuranceName;
  final double insurancePrice;
  final String insuranceDescription;
  final String insuranceImage;

  InsuranceModel({
    this.id,
    required this.insuranceName,
    required this.insurancePrice,
    required this.insuranceDescription,
    required this.insuranceImage,
  });

  List<Object?> get props => [
        id,
        insuranceName,
        insurancePrice,
        insuranceDescription,
        insuranceImage,
      ];
}
