import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myapp/shared/repositories/auth_repository.dart';

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepositoryImpl();
});
