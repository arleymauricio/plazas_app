
import 'package:myapp/features/buyer_registration/data/models/buyer_profile_model.dart';

abstract class BuyerProfileRemoteDataSource {
  Future<void> saveBuyerProfile(BuyerProfileModel buyerProfile);
}
