import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'widgets/custom_app_bar.dart';
import 'widgets/market_card.dart';
import 'widgets/bottom_navigation.dart';

class BuyerHomePage extends StatelessWidget {
  const BuyerHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '¿Dónde quieres comprar?',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: 8.0),
              Text(
                'Elige entre la frescura de las plazas o los productos únicos de los emprendedores.',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 16.0),
              const MarketCard(
                image: 'https://i.imgur.com/t4YdYqs.jpeg',
                title: 'Compra en Plazas de Mercado',
                description: 'Encuentra productos frescos, variados y de la mejor calidad directamente del campo.',
                actionLink: 'Explorar Plazas →',
                route: '/markets',
              ),
              const MarketCard(
                image: 'https://i.imgur.com/P0jgxN0.jpeg',
                title: 'Compra en Emprendedores',
                description: 'Apoya el talento local y descubre productos únicos artesanales y llenos de historia.',
                actionLink: 'Explorar Emprendedores →',
                route: '/entrepreneurs',
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const BottomNavigation(),
    );
  }
}
