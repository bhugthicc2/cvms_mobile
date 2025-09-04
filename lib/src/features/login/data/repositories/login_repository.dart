import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/login_request.dart';
import '../models/login_response.dart';

abstract class LoginRepository {
  Future<LoginResponse> login(LoginRequest request);
  Future<void> logout();
  Future<bool> isLoggedIn();
}

class LoginRepositoryImpl implements LoginRepository {
  @override
  Future<LoginResponse> login(LoginRequest request) async {
    // Look for the account in Firestore `users` collection by email + password
    final usersRef = FirebaseFirestore.instance.collection('users');

    final query =
        await usersRef
            .where('email', isEqualTo: request.email)
            .where('password', isEqualTo: request.password)
            .limit(1)
            .get();

    if (query.docs.isEmpty) {
      return const LoginResponse(
        success: false,
        message: 'Invalid email or password',
      );
    }

    final doc = query.docs.first;
    final data = doc.data();

    return LoginResponse(
      success: true,
      message: 'Login successful',
      user: User(
        id: doc.id,
        email: data['email'] ?? '',
        name: data['fullname'] ?? '',
      ),
    );
  }

  @override
  Future<void> logout() async {
    // TODO: Implement logout logic
    await Future.delayed(const Duration(milliseconds: 500));
  }

  @override
  Future<bool> isLoggedIn() async {
    // TODO: Check if user is logged in
    return false;
  }
}
