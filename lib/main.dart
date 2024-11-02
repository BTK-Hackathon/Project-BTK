import 'package:flutter/material.dart';
import 'package:btk_hackathon/app/main_app.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  // Flutter binding'ini başlat
  WidgetsFlutterBinding.ensureInitialized();

  // Firebase'i başlat
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Uygulamayı çalıştır
  runApp(const MainApp());
}
