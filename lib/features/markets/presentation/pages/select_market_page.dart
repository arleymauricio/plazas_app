import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myapp/features/buyer_home/presentation/widgets/bottom_navigation.dart';
import 'package:myapp/features/markets/presentation/controllers/markets_controller.dart';
import '../widgets/market_card.dart';
import '../widgets/markets_app_bar.dart';

class SelectMarketPage extends ConsumerWidget {
  const SelectMarketPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final marketsAsyncValue = ref.watch(marketsProvider);

    return Scaffold(
      appBar: const MarketsAppBar(),
      body: marketsAsyncValue.when(
        data: (markets) {
          return ListView.builder(
            itemCount: markets.length,
            itemBuilder: (context, index) {
              return MarketCard(market: markets[index]);
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) => Center(child: Text('Error: $error')),
      ),
      bottomNavigationBar: const BottomNavigation(),
    );
  }
}
