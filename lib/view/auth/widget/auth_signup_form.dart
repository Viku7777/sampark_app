import 'package:chat_app/controller/auth_controller.dart';
import 'package:chat_app/widgets/primary_btn.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/route_manager.dart';
import 'package:velocity_x/velocity_x.dart';

class AuthSignupForm extends StatelessWidget {
  AuthSignupForm({super.key});

  @override
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController name = TextEditingController();
  var controller = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        10.heightBox,
        TextField(
          controller: name,
          decoration: const InputDecoration(
            hintText: "Full Name",
            prefixIcon: Icon(Icons.person),
          ),
        ),
        20.heightBox,
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
                        name: "Signup",
                        onclick: () async {
                          controller.createAccount(
                              email.text, password.text, name.text);
                        },
                        icon: Icons.lock),
                  ],
                ),
        ),
      ],
    );
  }
}
