import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:myapp/shared/models/user_model.dart';
import 'package:myapp/shared/providers/auth_provider.dart';
import 'package:myapp/shared/providers/user_repository_provider.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(authProvider).value;
    final userRepo = ref.read(userRepositoryProvider);

    if (user == null) {
      return const CircularProgressIndicator();
    }

    return FutureBuilder<UserModel?>(
      future: userRepo.getUser(user.uid),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        }

        if (snapshot.hasData && snapshot.data != null) {
          final userModel = snapshot.data!;
          if (userModel.roles.contains(UserRole.comerciante)) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              context.go('/home/comerciante');
            });
          } else if (userModel.roles.contains(UserRole.comprador)) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              context.go('/home/comprador');
            });
          } else if (userModel.roles.contains(UserRole.transportador)) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              context.go('/home/transportador');
            });
          }
        }

        return const Scaffold(
          body: Center(
            child: Text('No role assigned'),
          ),
        );
      },
    );
  }
}
