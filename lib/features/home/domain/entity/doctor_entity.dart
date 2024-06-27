class DoctorEntity {
  final String? doctorid;
  final String doctorName;
  final String doctorField;
  final String doctorExperience;
  final String doctorFee;
  final String doctorImage;

  DoctorEntity({
    this.doctorid,
    required this.doctorName,
    required this.doctorField,
    required this.doctorExperience,
    required this.doctorFee,
    required this.doctorImage,
  });

  List<Object?> get props => [
        doctorid,
        doctorName,
        doctorField,
        doctorExperience,
        doctorFee,
        doctorImage,
      ];
}
