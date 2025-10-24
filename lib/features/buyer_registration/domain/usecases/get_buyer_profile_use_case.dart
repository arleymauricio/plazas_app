import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myapp/features/buyer_registration/data/repositories/buyer_profile_repository_impl.dart';
import 'package:myapp/features/buyer_registration/domain/entities/buyer_profile_entity.dart';
import 'package:myapp/features/buyer_registration/domain/repositories/buyer_profile_repository.dart';

final getBuyerProfileUseCaseProvider = Provider<GetBuyerProfileUseCase>(
  (ref) => GetBuyerProfileUseCase(ref.watch(buyerProfileRepositoryProvider)),
);

class GetBuyerProfileUseCase {
  final BuyerProfileRepository _repository;

  GetBuyerProfileUseCase(this._repository);

  Future<BuyerProfileEntity?> execute(String email) {
    return _repository.getBuyerProfile(email);
  }
}
