import '../../domain/entities/market_entity.dart';
import '../../domain/repositories/market_repository.dart';

class GetMarketsUseCase {
  final MarketRepository repository;

  GetMarketsUseCase({required this.repository});

  Future<List<MarketEntity>> call() async {
    return await repository.getMarkets();
  }
}
