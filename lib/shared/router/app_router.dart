import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myapp/features/buyer_home/presentation/screens/buyer_home_page.dart';
import 'package:myapp/features/markets/presentation/pages/select_market_page.dart';

final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/select-market',
    routes: [
      GoRoute(
        path: '/buyer-home',
        builder: (context, state) => const BuyerHomePage(),
      ),
      GoRoute(
        path: '/select-market',
        builder: (context, state) => const SelectMarketPage(),
      ),
    ],
  );
});
