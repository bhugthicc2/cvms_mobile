import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
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
    try {
      // Ensure Firebase is initialized before accessing Firestore
      if (Firebase.apps.isEmpty) {
        print('💥 Firebase not initialized, cannot access Firestore');
        return const LoginResponse(
          success: false,
          message: 'Firebase not initialized. Please restart the app.',
        );
      }

      // Look for the account in Firestore `users` collection by email + password
      final usersRef = FirebaseFirestore.instance.collection('users');

      print('🔍 Searching for user with email: ${request.email}');

      final query =
          await usersRef
              .where('email', isEqualTo: request.email)
              .where('password', isEqualTo: request.password)
              .limit(1)
              .get();

      print('📊 Query result: ${query.docs.length} documents found');

      if (query.docs.isEmpty) {
        print('❌ No user found with these credentials');
        return const LoginResponse(
          success: false,
          message: 'Invalid email or password',
        );
      }

      final doc = query.docs.first;
      final data = doc.data();

      print('✅ User found: ${data['name']} (${data['email']})');

      return LoginResponse(
        success: true,
        message: 'Login successful',
        user: User(
          id: doc.id,
          email: data['email'] ?? '',
          name: data['name'] ?? '',
        ),
      );
    } catch (e) {
      print('💥 Firebase error: $e');
      return LoginResponse(
        success: false,
        message: 'Connection error: ${e.toString()}',
      );
    }
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
