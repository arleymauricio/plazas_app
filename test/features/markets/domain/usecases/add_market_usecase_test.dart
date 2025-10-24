import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:myapp/features/markets/domain/entities/market_entity.dart';
import 'package:myapp/features/markets/domain/repositories/market_repository.dart';
import 'package:myapp/features/markets/domain/usecases/add_market_usecase.dart';
import 'add_market_usecase_test.mocks.dart';

@GenerateMocks([MarketRepository])
void main() {
  late AddMarketUseCase addMarketUseCase;
  late MockMarketRepository mockMarketRepository;

  setUp(() {
    mockMarketRepository = MockMarketRepository();
    addMarketUseCase = AddMarketUseCase(repository: mockMarketRepository);
  });

  final tMarket = MarketEntity(
    id: '1',
    name: 'Test Market',
    description: 'Test Description',
    address: 'Test Address',
    imageUrl: 'test_url',
  );

  test('should add a market to the repository', () async {
    // Arrange
    when(mockMarketRepository.addMarket(any)).thenAnswer((_) async => Future.value());

    // Act
    await addMarketUseCase(tMarket);

    // Assert
    verify(mockMarketRepository.addMarket(tMarket));
    verifyNoMoreInteractions(mockMarketRepository);
  });
}
