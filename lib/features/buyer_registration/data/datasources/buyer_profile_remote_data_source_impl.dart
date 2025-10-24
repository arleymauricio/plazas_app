import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myapp/features/buyer_registration/data/datasources/buyer_profile_remote_data_source.dart';
import 'package:myapp/features/buyer_registration/data/models/buyer_profile_model.dart';

final buyerProfileRemoteDataSourceProvider =
    Provider<BuyerProfileRemoteDataSource>(
      (ref) => BuyerProfileRemoteDataSourceImpl(
        firestore: FirebaseFirestore.instance,
      ),
    );

class BuyerProfileRemoteDataSourceImpl implements BuyerProfileRemoteDataSource {
  final FirebaseFirestore firestore;

  BuyerProfileRemoteDataSourceImpl({required this.firestore});

  @override
  Future<BuyerProfileModel?> getBuyerProfile(String email) async {
    final docSnapshot = await firestore.collection('buyers').doc(email).get();
    if (docSnapshot.exists) {
      return BuyerProfileModel.fromFirestore(docSnapshot.data()!);
    }
    return null;
  }

  @override
  Future<void> saveBuyerProfile(BuyerProfileModel buyerProfile) async {
    await firestore
        .collection('buyers')
        .doc(buyerProfile.email)
        .set(buyerProfile.toJson());
  }
}
