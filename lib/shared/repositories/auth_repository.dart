import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthRepository {
  Stream<User?> get authStateChanges;
}

class AuthRepositoryImpl implements AuthRepository {
  @override
  Stream<User?> get authStateChanges => FirebaseAuth.instance.authStateChanges();
}
