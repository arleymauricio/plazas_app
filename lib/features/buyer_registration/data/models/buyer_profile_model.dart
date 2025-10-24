
import 'package:cloud_firestore/cloud_firestore.dart';

class BuyerProfileModel {
  final String email;
  final String role;
  final String address;
  final String phone;
  final String gender;
  final DateTime birthDate;

  BuyerProfileModel({
    required this.email,
    required this.role,
    required this.address,
    required this.phone,
    required this.gender,
    required this.birthDate,
  });

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'role': role,
      'address': address,
      'phone': phone,
      'gender': gender,
      'birthDate': Timestamp.fromDate(birthDate),
    };
  }
}
