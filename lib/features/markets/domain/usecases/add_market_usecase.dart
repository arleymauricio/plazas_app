import 'package:myapp/features/markets/domain/entities/market_entity.dart';
import 'package:myapp/features/markets/domain/repositories/market_repository.dart';

class AddMarketUseCase {
  final MarketRepository repository;

  AddMarketUseCase({required this.repository});

  Future<void> call(MarketEntity market) async {
    await repository.addMarket(market);
  }
}
