import 'package:btk_project/product/extension/context_extesion.dart';
import 'package:btk_project/product/widgets/custom_outlined_button.dart';
import 'package:flutter/material.dart';

class LogSignScreen extends StatefulWidget {
  const LogSignScreen({super.key});

  @override
  State<LogSignScreen> createState() => _LogSignScreenState();
}

class _LogSignScreenState extends State<LogSignScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF2C2C2C),
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: context.dynamicWidth(0.05),
            vertical: context.dynamicHeight(0.05)),
        child: SingleChildScrollView(
          child: Column(
            children: [
              centerView(context),
              SizedBox(
                height: context.dynamicHeight(0.05),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    decoration: boxDecoration(),
                    child: logInButton(context),
                  ),
                  Container(
                    decoration: boxDecoration(),
                    child: signInButton(context),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  BoxDecoration boxDecoration() {
    return BoxDecoration(
      borderRadius: BorderRadius.circular(20),
      boxShadow: const [
        BoxShadow(
          color: Colors.black26,
          blurRadius: 5,
          spreadRadius: 2,
          offset: Offset(0, 3),
        ),
      ],
    );
  }

  Center centerView(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.only(top: context.dynamicHeight(0.4)),
        child: Column(
          children: [
            avatarIcon(),
            SizedBox(
              height: context.dynamicHeight(0.02),
            ),
            Container(
              padding: EdgeInsets.symmetric(
                  vertical: context.dynamicHeight(0.02),
                  horizontal: context.dynamicWidth(0.1)),
              decoration: BoxDecoration(
                color: Colors.black45,
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: titleText(),
            ),
          ],
        ),
      ),
    );
  }

  CircleAvatar avatarIcon() {
    return const CircleAvatar(
      radius: 50,
      backgroundColor: Colors.black45,
      child: Icon(
        Icons.account_tree_outlined,
        size: 50,
        color: Colors.white,
      ),
    );
  }

  Column titleText() {
    return const Column(
      children: [
        Text("Bize Katıl",
            style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold)),
        Text("ve En iyi Deneyimi Yaşa",
            style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold)),
      ],
    );
  }

  CustomOutlinedButton logInButton(BuildContext context) {
    return CustomOutlinedButton(
        onPressed: () {
          Navigator.pushNamed(context, "/loginscreen");
        },
        text: "Giriş Yap");
  }

  CustomOutlinedButton signInButton(BuildContext context) {
    return CustomOutlinedButton(
        onPressed: () {
          Navigator.pushNamed(context, "/signupscreen");
        },
        text: "Üye Ol");
  }
}
