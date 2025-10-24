import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:logger/logger.dart';
import 'package:myapp/features/auth/data/auth_service.dart';
import 'package:myapp/features/buyer_registration/domain/usecases/get_buyer_profile_use_case.dart';
import 'package:go_router/go_router.dart';
import 'package:myapp/features/buyer_registration/presentation/screens/buyer_registration_screen.dart';
import 'package:myapp/features/buyer_home/presentation/screens/buyer_home_page.dart';
import 'package:sign_in_button/sign_in_button.dart';

enum UserRole { buyer, seller, recolector, delivery }

final loginIsLoadingProvider = StateProvider<bool>((ref) => false);

class LoginScreen extends ConsumerWidget {
  const LoginScreen({super.key});

  void _signInWithGoogle(
    BuildContext context,
    WidgetRef ref,
    UserRole role,
  ) async {
    final logger = Logger();
    logger.i('Attempting to sign in with Google as role: ${role.name}');
    ref.read(loginIsLoadingProvider.notifier).state = true;

    try {
      final authService = ref.read(authServiceProvider);
      final userCredential = await authService.signInWithGoogle();
      if (userCredential.user != null) {
        final getBuyerProfile = ref.read(getBuyerProfileUseCaseProvider);
        final buyerProfile = await getBuyerProfile.execute(
          userCredential.user!.email!,
        );
        if (buyerProfile != null) {
          logger.i('Buyer Profile Found: Navigating to Home Page');
          context.go('/buyer-home');
        } else {
          logger.w(
            'No buyer profile found for email: ${userCredential.user!.email!}',
          );
          context.go(
            '/buyer-registration',
            extra: {'email': userCredential.user!.email!, 'role': role.name},
          );
        }
      }
      logger.i(
        'Google Sign-In process completed for user: ${userCredential.user?.email}',
      );
    } catch (e) {
      logger.e('Google Sign-In failed', e);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: ${e.toString()}'),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      // Ensure the provider is still mounted before trying to modify its state.
      if (ref.exists(loginIsLoadingProvider)) {
        ref.read(loginIsLoadingProvider.notifier).state = false;
      }
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Scaffold(body: LoginView());
  }
}

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  UserRole _selectedRole = UserRole.buyer;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Background Image with Blur
        Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/login.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
            child: Container(color: Colors.black.withOpacity(0.2)),
          ),
        ),
        // Centered Login Card
        Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 400),
            child: Card(
              elevation: 8,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              color: Colors.white.withOpacity(0.9),
              child: Padding(
                padding: const EdgeInsets.all(32.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Shopping Bag Icon
                    const Icon(
                      Icons.shopping_bag_rounded,
                      size: 60,
                      color: Colors.orange,
                    ),
                    const SizedBox(height: 24),
                    // App Title
                    const Text(
                      'Mercado Plazas',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                      ),
                    ),
                    const SizedBox(height: 8),
                    // Subtitle
                    Text(
                      'Tu plaza de mercado en línea',
                      style: TextStyle(color: Colors.grey[600], fontSize: 16),
                    ),
                    const SizedBox(height: 32),
                    // Role Selection Label
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Selecciona tu rol',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    // Role Dropdown
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.grey.shade300),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<UserRole>(
                          value: _selectedRole,
                          isExpanded: true,
                          onChanged: (UserRole? newValue) {
                            if (newValue != null) {
                              setState(() {
                                _selectedRole = newValue;
                              });
                            }
                          },
                          items: UserRole.values.map((UserRole role) {
                            return DropdownMenuItem<UserRole>(
                              value: role,
                              child: Text(_getRoleLabel(role)),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    // Consumer for the button to react to loading state
                    Consumer(
                      builder: (context, ref, child) {
                        final isLoading = ref.watch(loginIsLoadingProvider);
                        return SizedBox(
                          width: double.infinity,
                          child: SignInButton(
                            Buttons.google,
                            onPressed: () {
                              if (!isLoading) {
                                const LoginScreen()._signInWithGoogle(
                                  context,
                                  ref,
                                  _selectedRole,
                                );
                              }
                            },
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            text: isLoading
                                ? 'Iniciando...'
                                : 'Iniciar Sesión con Google',
                            padding: const EdgeInsets.symmetric(vertical: 12),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  String _getRoleLabel(UserRole role) {
    switch (role) {
      case UserRole.buyer:
        return 'Comprador';
      case UserRole.seller:
        return 'Vendedor';
      case UserRole.recolector:
        return 'Recolector';
      case UserRole.delivery:
        return 'Repartidor';
    }
  }
}
