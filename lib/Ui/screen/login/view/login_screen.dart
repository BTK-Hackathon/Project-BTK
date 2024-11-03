import 'package:btk_project/Ui/screen/chat/chat_screen.dart';
import 'package:btk_project/Ui/screen/signup/view/sign_up_screen.dart';
import 'package:btk_project/auth/service/auth_service.dart';
import 'package:btk_project/product/extension/context_extesion.dart';
import 'package:btk_project/product/widgets/custom_elevated_button.dart';
import 'package:btk_project/product/widgets/custom_text_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late String email, password;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final FirebaseAuth auth = FirebaseAuth.instance;
  bool isPasswordVisible = false;
  final AuthService authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF2C2C2C),
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: context.dynamicWidth(0.035),
              vertical: context.dynamicHeight(0.035),
            ),
            child: Center(
              child: Container(
                padding: EdgeInsets.symmetric(
                  vertical: context.dynamicHeight(0.03),
                  horizontal: context.dynamicWidth(0.1),
                ),
                decoration: BoxDecoration(
                  color: Colors.white60,
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: Form(
                  key: formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      welcomeText(),
                      SizedBox(height: context.dynamicHeight(0.04)),
                      emailTextField(),
                      SizedBox(height: context.dynamicHeight(0.02)),
                      passwordTextField(),
                      SizedBox(height: context.dynamicHeight(0.04)),
                      logInButton(context),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          forgotPasswordButton(),
                        ],
                      ),
                      SizedBox(height: context.dynamicHeight(0.01)),
                      signUpButton(context),
                    ],
                  ),
                ),
              ),
            ),
          ),
          backButton(context),
        ],
      ),
    );
  }

  void signIn() async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      final result = await authService.signIn(email, password);
      if (result == "success") {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
                builder: (context) => const ChatScreen(
                      sessionTitle: '',
                    )),
            (route) => false);
      } else {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text("Hata"),
              content: Text(result!),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text("Geri Dön"))
              ],
            );
          },
        );
      }
    }
  }

  Positioned backButton(BuildContext context) {
    return Positioned(
      top: 50,
      left: 25,
      child: CircleAvatar(
        backgroundColor: Colors.grey[200],
        child: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
    );
  }

  CustomElevatedButton signUpButton(BuildContext context) {
    return CustomElevatedButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const SignUpScreen()),
        );
      },
      textButton: "Üye ol",
    );
  }

  Text welcomeText() {
    return const Text(
      "BTK'ya Hoşgeldiniz",
      style: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  CustomTextField emailTextField() {
    return CustomTextField(
      labelText: "Email",
      prefixIcon: const Icon(Icons.mail),
      onSaved: (value) => email = value!,
      validator: (value) {
        if (value!.isEmpty) {
          return "E-posta boş olamaz";
        }
        return null;
      },
      keyboardType: TextInputType.emailAddress,
    );
  }

  CustomTextField passwordTextField() {
    return CustomTextField(
      labelText: "Şifre",
      prefixIcon: const Icon(Icons.lock),
      obscureText: !isPasswordVisible, // Toggles based on isPasswordVisible
      suffixIcon: IconButton(
        icon: Icon(
          isPasswordVisible ? Icons.visibility : Icons.visibility_off,
        ),
        onPressed: () {
          setState(() {
            isPasswordVisible = !isPasswordVisible;
          });
        },
      ),
      onSaved: (value) => password = value!,
      validator: (value) {
        if (value!.isEmpty) {
          return "Şifre boş olamaz";
        } else if (value.length < 6) {
          return "Şifre en az 6 karakter olmalıdır";
        }
        return null;
      },
      keyboardType: TextInputType.visiblePassword,
    );
  }

  CustomElevatedButton logInButton(BuildContext context) {
    return CustomElevatedButton(
      onPressed: () async {
        if (formKey.currentState!.validate()) {
          formKey.currentState!.save();
          try {
            await auth.signInWithEmailAndPassword(
              email: email,
              password: password,
            );
            Navigator.pushNamed(context, "/mainscreen");
          } catch (e) {
            // Handle error
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: const Text("Error"),
                content: Text("Login failed: ${e.toString()}"),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text("OK"),
                  ),
                ],
              ),
            );
          }
        }
      },
      textButton: "Giriş Yap",
    );
  }

  TextButton forgotPasswordButton() {
    return TextButton(
      onPressed: () {},
      child: const Text("Şifremi Unuttum"),
    );
  }
}
