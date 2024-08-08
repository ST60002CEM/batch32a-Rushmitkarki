import 'package:equatable/equatable.dart';

class AuthEntity extends Equatable {
  final String? userId;
  final String fName;
  final String lName;
  final String email;
  final String? password;
  final String? image;
  final String phone;

  const AuthEntity({
    this.userId,
    required this.fName,
    required this.lName,
    required this.email,
    this.password,
    this.image,
    required this.phone,
  });

  @override
  List<Object?> get props => [
        userId,
        fName,
        lName,
        email,
        password,
        image,
        phone,
      ];
}
