import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:myapp/features/buyer_registration/data/datasources/buyer_profile_remote_data_source.dart';
import 'package:myapp/features/buyer_registration/data/models/buyer_profile_model.dart';

class BuyerProfileRemoteDataSourceImpl implements BuyerProfileRemoteDataSource {
  final FirebaseFirestore firestore;

  BuyerProfileRemoteDataSourceImpl({required this.firestore});

  @override
  Future<void> saveBuyerProfile(BuyerProfileModel buyerProfile) async {
    await firestore
        .collection('buyers')
        .doc(buyerProfile.email)
        .set(buyerProfile.toJson());
  }
}
