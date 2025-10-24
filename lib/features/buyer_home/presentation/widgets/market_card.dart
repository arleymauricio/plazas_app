import 'package:flutter/material.dart';

class MarketCard extends StatelessWidget {
  final String image;
  final String title;
  final String description;
  final String actionLink;
  final String route;

  const MarketCard({
    super.key,
    required this.image,
    required this.title,
    required this.description,
    required this.actionLink,
    required this.route,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      child: Column(
        children: [
          Image.network(image),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 8.0),
                Text(description),
                const SizedBox(height: 8.0),
                TextButton(
                  onPressed: () => Navigator.pushNamed(context, route),
                  child: Text(actionLink),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
