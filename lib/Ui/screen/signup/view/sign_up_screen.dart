import 'package:btk_project/product/extension/context_extesion.dart';
import 'package:btk_project/product/widgets/custom_elevated_button.dart';
import 'package:btk_project/product/widgets/custom_text_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  late String name, email, password;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final FirebaseAuth auth = FirebaseAuth.instance;

  bool isPasswordVisible = false; // Şifre görünürlüğü kontrolü için

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF2C2C2C),
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: context.dynamicWidth(0.035),
          vertical: context.dynamicHeight(0.035),
        ),
        child: Stack(
          children: [
            backButton(context),
            Center(
              child: Container(
                padding: EdgeInsets.symmetric(
                  vertical: MediaQuery.of(context).size.height * 0.04,
                  horizontal: MediaQuery.of(context).size.width * 0.1,
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
                      tittleText(),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.05),
                      nameTextField(),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.02),
                      emailTextField(),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.02),
                      passwordTextField(),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.05),
                      signUpButton(context),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.02),
                      signInButton(context),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Positioned backButton(BuildContext context) {
    return Positioned(
      top: 16,
      left: 16,
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
        onPressed: () async {
          if (formKey.currentState!.validate()) {
            formKey.currentState!.save();
            try {
              var userResult = await auth.createUserWithEmailAndPassword(
                email: email,
                password: password,
              );
              formKey.currentState!.reset();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text("Aramıza Hoşgeldin $name"),
                ),
              );
              Navigator.pushNamed(context, "/loginscreen");
              print("Kullanıcı oluşturuldu: ${userResult.user!.uid}");
              // Yeni kullanıcı kaydını ekledikten sonra yönlendirme yapılabilir
            } catch (e) {
              print("Kayıt işlemi sırasında hata oluştu: $e");
            }
          }
        },
        textButton: "Üye Ol");
  }

  Text tittleText() {
    return const Text(
      "Yeni Hesap Oluştur",
      style: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  CustomTextField nameTextField() {
    return CustomTextField(
        labelText: "Ad-Soyad",
        prefixIcon: const Icon(Icons.person),
        onSaved: (value) {
          name = value!;
        },
        validator: (value) {
          if (value!.isEmpty) {
            return "Ad boş olamaz";
          }
          return null;
        },
        keyboardType: TextInputType.name);
  }

  CustomTextField emailTextField() {
    return CustomTextField(
      labelText: "E-posta",
      prefixIcon: const Icon(Icons.email),
      keyboardType: TextInputType.emailAddress,
      onSaved: (value) {
        email = value!;
      },
      validator: (value) {
        if (value!.isEmpty) {
          return "E-posta boş olamaz";
        }
        return null;
      },
    );
  }

  CustomTextField passwordTextField() {
    return CustomTextField(
      labelText: "Şifre",
      prefixIcon: const Icon(Icons.lock),
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
      onSaved: (value) {
        password = value!;
      },
      validator: (value) {
        if (value!.isEmpty) {
          return "Şifre boş olamaz";
        } else if (value.length < 6) {
          return "Şifre en az 6 karakter olmalıdır";
        }
        return null;
      },
      keyboardType: TextInputType.visiblePassword,
      obscureText: !isPasswordVisible,
    );
  }

  TextButton signInButton(BuildContext context) {
    return TextButton(
      onPressed: () {
        Navigator.pop(context);
      },
      child: const Text(
        "Zaten hesabınız var mı? Giriş Yap",
        style: TextStyle(decoration: TextDecoration.underline),
      ),
    );
  }
}
