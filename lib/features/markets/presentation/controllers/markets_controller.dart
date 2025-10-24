import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:myapp/features/markets/data/repositories/market_repository_impl.dart';
import 'package:myapp/features/markets/domain/usecases/get_markets_usecase.dart';
import 'package:myapp/features/markets/domain/entities/market_entity.dart';

final marketsProvider = FutureProvider<List<MarketEntity>>((ref) async {
  final getMarketsUseCase = ref.read(getMarketsUseCaseProvider);
  return await getMarketsUseCase.call();
});

final getMarketsUseCaseProvider = Provider<GetMarketsUseCase>((ref) {
  final marketRepository = ref.read(marketRepositoryProvider);
  return GetMarketsUseCase(repository: marketRepository);
});

final marketRepositoryProvider = Provider<MarketRepositoryImpl>((ref) {
  return MarketRepositoryImpl(firestore: FirebaseFirestore.instance);
});
