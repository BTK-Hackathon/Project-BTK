import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthService {
  final FirebaseAuth auth = FirebaseAuth.instance;
  Future forgotPassword(String email) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
    } catch (e) {
      debugPrint("AuthService forgotPassword error: $e");
    }
  }

  Future<String?> signIn(String email, String password) async {
    String? res;
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      res = "success";
    } on FirebaseAuthException catch (e) {
      if (e.code == "user-not-found") {
        res = "Kullanıcı bulunamadı";
      } else if (e.code == "wrong-password") {
        res = "Şifre Yanlış";
      } else if (e.code == "user-disabled") {
        res = "Kullanıcı Pasif";
      } else {
        res = "Bir hata oluştu. Lütfen tekrar deneyin.";
      }
    } catch (e) {
      res = "Bir hata oluştu. Lütfen tekrar deneyin.";
    }
    return res;
  }
}
