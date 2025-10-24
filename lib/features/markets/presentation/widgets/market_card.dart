import 'package:flutter/material.dart';
import 'package:myapp/features/markets/domain/entities/market_entity.dart';

class MarketCard extends StatelessWidget {
  final MarketEntity market;

  const MarketCard({super.key, required this.market});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.network(
            market.imageUrl,
            fit: BoxFit.cover,
            width: double.infinity,
            height: 200,
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  market.name,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 8),
                Text(market.description),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(Icons.location_on_outlined),
                    const SizedBox(width: 4),
                    Text(market.address),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
