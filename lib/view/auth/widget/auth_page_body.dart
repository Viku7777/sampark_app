import 'package:chat_app/Config/Colors.dart';
import 'package:chat_app/Config/Themes.dart';
import 'package:chat_app/view/auth/widget/auth_login_form.dart';
import 'package:chat_app/view/auth/widget/auth_signup_form.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

class AuthPageBody extends StatelessWidget {
  const AuthPageBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    RxBool isLoginState = true.obs;

    return Container(
      // height: 400,
      margin: const EdgeInsets.symmetric(horizontal: 15),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: getColorSchema(context).primaryContainer,
      ),
      child: Column(
        children: [
          Obx(
            () => Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () {
                    isLoginState.value = true;
                  },
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width / 2.7,
                    child: Column(
                      children: [
                        Text(
                          "Login",
                          style: isLoginState.value
                              ? getTextTheme(context).bodyLarge
                              : getTextTheme(context).labelLarge,
                        ),
                        5.heightBox,
                        AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          width: isLoginState.value ? 100 : 0,
                          height: 5,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              color: getColorSchema(context).primary),
                        )
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    isLoginState.value = false;
                  },
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width / 2.7,
                    child: Column(
                      children: [
                        Text(
                          "Signup",
                          style: isLoginState.value
                              ? getTextTheme(context).labelLarge
                              : getTextTheme(context).bodyLarge,
                        ),
                        5.heightBox,
                        AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          width: isLoginState.value ? 0 : 100,
                          height: 5,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              color: getColorSchema(context).primary),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          10.heightBox,
          Obx(() => isLoginState.value ? AuthLoginForm() : AuthSignupForm())
        ],
      ),
    );
  }
}
