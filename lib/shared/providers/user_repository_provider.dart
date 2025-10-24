import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myapp/shared/repositories/user_repository.dart';

final userRepositoryProvider = Provider<UserRepository>((ref) {
  return UserRepositoryImpl();
});
