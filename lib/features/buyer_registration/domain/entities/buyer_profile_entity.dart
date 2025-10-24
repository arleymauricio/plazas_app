import 'package:equatable/equatable.dart';

class BuyerProfileEntity extends Equatable {
  final String email;
  final String role;
  final String address;
  final String phone;
  final String gender;
  final DateTime birthDate;

  const BuyerProfileEntity({
    required this.email,
    required this.role,
    required this.address,
    required this.phone,
    required this.gender,
    required this.birthDate,
  });

  @override
  List<Object?> get props => [email, role, address, phone, gender, birthDate];
}
