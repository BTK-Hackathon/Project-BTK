import 'package:btk_project/Ui/screen/app/main_app.dart';
import 'package:btk_project/Ui/screen/chat/chat_screen.dart';
import 'package:btk_project/Ui/screen/log_sign/log_sign_screen.dart';
import 'package:btk_project/Ui/screen/login/view/login_screen.dart';
import 'package:btk_project/Ui/screen/main/main_screen.dart';
import 'package:btk_project/Ui/screen/signup/view/sign_up_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const MainApp(),
      routes: {
        "LogSignScreen": (context) => const LogSignScreen(),
        "/loginscreen": (context) => const LoginScreen(),
        "/signupscreen": (context) => const SignUpScreen(),
        "/homescreen": (context) => const ChatScreen(
              sessionTitle: '',
            ),
        "/mainscreen": (context) => MainScreen(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
