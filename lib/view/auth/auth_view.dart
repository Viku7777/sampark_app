import 'package:chat_app/view/auth/widget/auth_page_body.dart';
import 'package:chat_app/view/welcome/widget/welcome_header.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class AuthView extends StatelessWidget {
  const AuthView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          children: [
            30.heightBox,
            const WelcomeHeaderWidget(),
            60.heightBox,
            const AuthPageBody(),
          ],
        ),
      )),
    );
  }
}
