class InsuranceEntity {
  final String? insuranceid;
  final String insuranceName;
  final String insuranceDescription;
  final double insurancePrice;
  final String insuranceImage;

  InsuranceEntity({
    this.insuranceid,
    required this.insuranceName,
    required this.insuranceDescription,
    required this.insurancePrice,
    required this.insuranceImage,
  });

  List<Object?> get props => [
        insuranceid,
        insuranceName,
        insuranceDescription,
        insurancePrice,
        insuranceImage,
      ];
}
