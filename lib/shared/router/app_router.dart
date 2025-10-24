import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:myapp/features/auth/presentation/screens/login_screen.dart';
import 'package:myapp/features/buyer_home/presentation/screens/buyer_home_page.dart';
import 'package:myapp/features/buyer_registration/presentation/screens/buyer_registration_screen.dart';
import 'package:myapp/features/home/home_screen.dart';
import 'package:myapp/shared/providers/auth_provider.dart';

final routerProvider = Provider<GoRouter>((ref) {
  final authState = ref.watch(authProvider);

  return GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(path: '/', builder: (context, state) => const LoginScreen()),
      GoRoute(
        path: '/profile',
        builder: (context, state) => const ProfileScreen(),
      ),
      GoRoute(
        path: '/buyer-home',
        builder: (context, state) => const BuyerHomePage(),
      ),
      GoRoute(
        path: '/markets',
        builder: (context, state) => const Scaffold(
          body: Center(
            child: Text('Markets'),
          ),
        ),
      ),
      GoRoute(
        path: '/entrepreneurs',
        builder: (context, state) => const Scaffold(
          body: Center(
            child: Text('Entrepreneurs'),
          ),
        ),
      ),
    ],
  );
});
