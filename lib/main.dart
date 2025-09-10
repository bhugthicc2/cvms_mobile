import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cvms_mobile/app/app.dart';
import 'package:cvms_mobile/firebase_options.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    print('✅ Firebase initialized successfully');
  } catch (e) {
    print('💥 Firebase initialization failed: $e');
    // Continue running the app even if Firebase fails to initialize
    // This allows the app to show appropriate error messages
  }

  final prefs = await SharedPreferences.getInstance();
  final initialIsDarkMode = prefs.getBool('isDarkMode') ?? false;

  runApp(App(initialIsDarkMode: initialIsDarkMode));
}


// git checkout -b bading-feature