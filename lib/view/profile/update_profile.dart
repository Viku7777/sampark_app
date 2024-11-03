import 'dart:io';

import 'package:chat_app/Config/Colors.dart';
import 'package:chat_app/Config/Strings.dart';
import 'package:chat_app/Config/Themes.dart';
import 'package:chat_app/Model/UserModel.dart';
import 'package:chat_app/controller/profile_controller.dart';
import 'package:chat_app/widgets/primary_btn.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

class UpdateProfileView extends StatefulWidget {
  const UpdateProfileView({super.key});

  @override
  State<UpdateProfileView> createState() => _UpdateProfileViewState();
}

class _UpdateProfileViewState extends State<UpdateProfileView> {
  bool isEditview = false;
  File? file;
  var profileController = Get.find<ProfileController>();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController aboutController = TextEditingController();
  late UserModel user;
  String img = "";
  @override
  void initState() {
    user = profileController.currentUser.value;
    nameController.text = user.name ?? "";
    emailController.text = user.email ?? "";
    aboutController.text = user.about ?? "";
    img = user.profileImage ?? "";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Update Profile"),
        ),
        body: Container(
          padding: const EdgeInsets.all(15),
          decoration:
              BoxDecoration(color: getColorSchema(context).primaryContainer),
          child: ListView(
            children: [
              InkWell(
                onTap: isEditview
                    ? () {
                        profileController.imagePicker().then((value) {
                          file = value;
                          setState(() {});
                        }).onError((error, stackTrace) {
                          Fluttertoast.showToast(msg: error.toString());
                        });
                      }
                    : null,
                child: Container(
                  height: 120,
                  width: 120,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: file != null && isEditview
                          ? DecorationImage(
                              image: FileImage(file!), fit: BoxFit.cover)
                          : null,
                      color: getColorSchema(context).background),
                  child: Icon(
                    isEditview ? Icons.add : Icons.photo,
                    size: 40,
                  ),
                ),
              ),
              10.heightBox,
              Align(
                alignment: Alignment.center,
                child: Text(
                  "Personal Info",
                  style: getTextTheme(context).labelLarge,
                ),
              ),
              10.heightBox,
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "Name",
                  style: getTextTheme(context).bodyMedium,
                ),
              ),
              10.heightBox,
              TextField(
                controller: nameController,
                enabled: isEditview,
                keyboardType: TextInputType.name,
                decoration: InputDecoration(
                    hintText: "xyz",
                    filled: isEditview,
                    prefixIcon: const Icon(
                      Icons.person,
                    )),
              ),
              20.heightBox,
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "About",
                  style: getTextTheme(context).bodyMedium,
                ),
              ),
              10.heightBox,
              TextField(
                controller: aboutController,
                enabled: isEditview,
                keyboardType: TextInputType.name,
                decoration: InputDecoration(
                    hintText:
                        "Hello i'm using ${WelcomePageString.appName.toLowerCase()}",
                    filled: isEditview,
                    prefixIcon: const Icon(
                      Icons.info,
                    )),
              ),
              20.heightBox,
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "Email",
                  style: getTextTheme(context).bodyMedium,
                ),
              ),
              10.heightBox,
              TextField(
                enabled: false,
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                    hintText: "Example@gmail.com",
                    filled: false,
                    prefixIcon: Icon(
                      Icons.alternate_email_rounded,
                    )),
              ),
              20.heightBox,
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "Phone Number",
                  style: getTextTheme(context).bodyMedium,
                ),
              ),
              40.heightBox,
              Obx(
                () => profileController.loading.value
                    ? const Center(child: CircularProgressIndicator())
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          PrimaryBtn(
                              name: isEditview ? "Save" : "Edit",
                              onclick: () {
                                if (isEditview) {
                                  profileController.updateProfile(
                                    file,
                                    nameController.text,
                                    aboutController.text,
                                  );
                                } else {
                                  setState(() {
                                    isEditview = true;
                                  });
                                }
                              },
                              icon: isEditview ? Icons.save : Icons.edit),
                        ],
                      ),
              ),
              10.heightBox,
            ],
          ),
        ));
  }
}
