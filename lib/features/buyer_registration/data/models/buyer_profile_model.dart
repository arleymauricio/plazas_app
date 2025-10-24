import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:myapp/features/buyer_registration/domain/entities/buyer_profile_entity.dart';

class BuyerProfileModel extends BuyerProfileEntity {
  const BuyerProfileModel({
    required String email,
    required String role,
    required String address,
    required String phone,
    required String gender,
    required DateTime birthDate,
  }) : super(
         email: email,
         role: role,
         address: address,
         phone: phone,
         gender: gender,
         birthDate: birthDate,
       );

  factory BuyerProfileModel.fromFirestore(Map<String, dynamic> json) {
    return BuyerProfileModel(
      email: json['email'],
      role: json['role'],
      address: json['address'],
      phone: json['phone'],
      gender: json['gender'],
      birthDate: (json['birthDate'] as Timestamp).toDate(),
    );
  }

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

  BuyerProfileEntity toEntity() {
    return BuyerProfileEntity(
      email: email,
      role: role,
      address: address,
      phone: phone,
      gender: gender,
      birthDate: birthDate,
    );
  }
}
