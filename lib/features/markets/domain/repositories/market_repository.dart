import '../entities/market_entity.dart';

abstract class MarketRepository {
  Future<List<MarketEntity>> getMarkets();
  Future<void> addMarket(MarketEntity market);
}
