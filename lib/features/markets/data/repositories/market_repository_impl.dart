import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:myapp/features/markets/data/models/market_model.dart';
import 'package:myapp/features/markets/domain/entities/market_entity.dart';
import 'package:myapp/features/markets/domain/repositories/market_repository.dart';

class MarketRepositoryImpl implements MarketRepository {
  final FirebaseFirestore firestore;

  MarketRepositoryImpl({required this.firestore});

  @override
  Future<List<MarketEntity>> getMarkets() async {
    try {
      final snapshot = await firestore.collection('markets').get();
      return snapshot.docs.map((doc) => MarketModel.fromFirestore(doc)).toList();
    } catch (e) {
      print(e);
      return [];
    }
  }

  @override
  Future<void> addMarket(MarketEntity market) async {
    try {
      final marketModel = MarketModel(
        id: market.id,
        name: market.name,
        description: market.description,
        address: market.address,
        imageUrl: market.imageUrl,
      );
      await firestore.collection('markets').doc(market.id).set(marketModel.toFirestore());
    } catch (e) {
      print(e);
    }
  }
}
