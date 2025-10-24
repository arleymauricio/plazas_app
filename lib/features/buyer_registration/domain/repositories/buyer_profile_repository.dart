import 'package:myapp/features/buyer_registration/domain/entities/buyer_profile_entity.dart';

abstract class BuyerProfileRepository {
  Future<void> saveBuyerProfile(BuyerProfileEntity buyerProfile);
  Future<BuyerProfileEntity?> getBuyerProfile(String email);
}
