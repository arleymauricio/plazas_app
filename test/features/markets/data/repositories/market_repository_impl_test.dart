import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:myapp/features/markets/data/models/market_model.dart';
import 'package:myapp/features/markets/data/repositories/market_repository_impl.dart';
import 'package:myapp/features/markets/domain/entities/market_entity.dart';

void main() {
  group('MarketRepositoryImpl Integration Test', () {
    late MarketRepositoryImpl repository;
    late FirebaseFirestore firestore;

    setUp(() {
      firestore = FakeFirebaseFirestore();
      repository = MarketRepositoryImpl(firestore: firestore);
    });

    test('should add a market to Firestore and get it back', () async {
      // Arrange
      final market = MarketEntity(
        id: '1',
        name: 'Test Market',
        description: 'Test Description',
        address: 'Test Address',
        imageUrl: 'test_url',
      );

      // Act
      await repository.addMarket(market);
      final markets = await repository.getMarkets();

      // Assert
      expect(markets, isNotEmpty);
      expect(markets.first.name, 'Test Market');
    });
  });
}
