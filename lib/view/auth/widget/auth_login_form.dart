// ignore_for_file: must_be_immutable

import 'package:chat_app/controller/auth_controller.dart';
import 'package:chat_app/widgets/primary_btn.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

class AuthLoginForm extends StatelessWidget {
  AuthLoginForm({super.key});
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(AuthController());
    return Column(
      children: [
        10.heightBox,
        TextField(
          controller: email,
          decoration: const InputDecoration(
            hintText: "Email",
            prefixIcon: Icon(Icons.alternate_email_rounded),
          ),
        ),
        20.heightBox,
        TextField(
          controller: password,
          decoration: const InputDecoration(
            hintText: "Password",
            prefixIcon: Icon(Icons.password_rounded),
          ),
        ),
        20.heightBox,
        Obx(
          () => controller.loading.value
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    PrimaryBtn(
                        name: "Login",
                        onclick: () async {
                          controller.login(email.text, password.text);
                        },
                        icon: Icons.lock),
                  ],
                ),
        ),
        10.heightBox,
      ],
    );
  }
}
