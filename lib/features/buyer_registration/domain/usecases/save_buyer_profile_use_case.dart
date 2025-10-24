
import 'package:myapp/features/buyer_registration/domain/entities/buyer_profile_entity.dart';
import 'package:myapp/features/buyer_registration/domain/repositories/buyer_profile_repository.dart';

class SaveBuyerProfileUseCase {
  final BuyerProfileRepository repository;

  SaveBuyerProfileUseCase({required this.repository});

  Future<void> call(BuyerProfileEntity buyerProfile) async {
    await repository.saveBuyerProfile(buyerProfile);
  }
}
