import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cvms_mobile/core/theme/app_strings.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user_model.dart';

class AuthRepository {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<UserModel?> signIn(
    String email,
    String password, {
    bool keepLoggedIn = false,
  }) async {
    final cred = await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    final user = cred.user;
    if (user == null) return null;

    final userDoc = await _db.collection('users').doc(user.uid).get();
    if (!userDoc.exists) {
      await _auth.signOut();
      throw Exception("User record not found.");
    }

    final data = userDoc.data()!;
    final role = data['role'] ?? AppStrings.roleSecurity;
    if (role != AppStrings.roleSecurity) {
      await _auth.signOut();
      throw Exception("Only security personnel can login here.");
    }

    await _db.collection('users').doc(user.uid).set({
      'lastLogin': FieldValue.serverTimestamp(),
      'status': 'active',
    }, SetOptions(merge: true));
    if (keepLoggedIn) {
      await _saveKeepLoggedIn(user.uid);
    } else {
      await _clearKeepLoggedIn();
    }

    return UserModel.fromMap(user.uid, {
      ...data,
      'lastLogin': DateTime.now().toIso8601String(),
      'status': 'active',
    });
  }

  Future<void> _saveKeepLoggedIn(String uid) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(AppStrings.keepLoggedInKey, true);
    await prefs.setString(AppStrings.userIdKey, uid);
  }

  Future<void> _clearKeepLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(AppStrings.keepLoggedInKey);
    await prefs.remove(AppStrings.userIdKey);
  }

  Future<void> signOut() async {
    await _clearKeepLoggedIn();
    await _auth.signOut();
  }

  Future<UserModel?> getLoggedInUser() async {
    final prefs = await SharedPreferences.getInstance();
    final keepLoggedIn = prefs.getBool(AppStrings.keepLoggedInKey) ?? false;
    final savedUid = prefs.getString(AppStrings.userIdKey);

    if (!keepLoggedIn || savedUid == null) {
      return null;
    }

    final userDoc = await _db.collection('users').doc(savedUid).get();
    if (!userDoc.exists) {
      await _clearKeepLoggedIn();
      return null;
    }

    final data = userDoc.data()!;

    final currentUser = _auth.currentUser;
    if (currentUser == null || currentUser.uid != savedUid) {}

    return UserModel.fromMap(savedUid, data);
  }

  Stream<User?> authStateChanges() => _auth.authStateChanges();

  Future<bool> ensureUserIsSignedIn() async {
    final prefs = await SharedPreferences.getInstance();
    final keepLoggedIn = prefs.getBool(AppStrings.keepLoggedInKey) ?? false;
    final savedUid = prefs.getString(AppStrings.userIdKey);

    if (!keepLoggedIn || savedUid == null) return false;

    final currentUser = _auth.currentUser;
    if (currentUser != null && currentUser.uid == savedUid) {
      return true;
    }

    return false;
  }

  Future<void> sendPasswordResetEmail(String email) async {
    await _auth.sendPasswordResetEmail(email: email);
  }
}
