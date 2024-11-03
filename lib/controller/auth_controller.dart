import 'package:chat_app/Model/UserModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

var userRef = FirebaseFirestore.instance.collection("users");
var chatRef = FirebaseFirestore.instance.collection("chats");
var chatRefdb = FirebaseDatabase.instance.ref("chats");
var chatroom = FirebaseFirestore.instance.collection("chatroom");

class AuthController extends GetxController {
  final auth = FirebaseAuth.instance;
  Rx<UserModel> loggedInuserDetails = UserModel().obs;

  RxBool loading = false.obs;
  //login

  Future<void> login(String email, String password) async {
    if (!EmailValidator.validate(email)) {
      Fluttertoast.showToast(msg: "Please enter a vaild email address");
    } else if (password.length <= 5) {
      Fluttertoast.showToast(msg: "Password must be at least 6 characters");
    } else {
      loading.value = true;

      try {
        UserCredential credential = await auth.signInWithEmailAndPassword(
            email: email, password: password);
        userRef.doc(credential.user!.uid).get().then((value) {
          if (value.exists) {
            loggedInuserDetails.value =
                UserModel.fromMap(value.data() as Map<String, dynamic>);
            Get.offAndToNamed("/home");
          } else {
            Fluttertoast.showToast(msg: "Something went wrong");
          }
        });
      } on FirebaseAuthException catch (e) {
        if (e.code == "user-not-found") {
          Fluttertoast.showToast(msg: "No user found for that email.");
        } else if (e.code == "wrong-password") {
          Fluttertoast.showToast(msg: "Wrong password provided for that user.");
        } else {
          Fluttertoast.showToast(msg: e.message.toString());
        }
      }
      loading.value = false;
    }
  }

  // create Account

  Future<void> createAccount(String email, String password, String name) async {
    if (!EmailValidator.validate(email)) {
      Fluttertoast.showToast(msg: "Please enter a vaild email address");
    } else if (password.length <= 5) {
      Fluttertoast.showToast(msg: "Password must be at least 6 characters");
    } else {
      loading.value = true;

      try {
        print("check1");
        UserCredential credential = await auth.createUserWithEmailAndPassword(
            email: email, password: password);
        print("check2");

        UserModel user = UserModel(
          id: credential.user!.uid,
          name: name,
          email: email,
        );
        debugPrint(user.toMap().toString());
        await userRef
            .doc(credential.user!.uid)
            .set(user.toMap())
            .onError((error, stackTrace) => loading.value = false);
        loggedInuserDetails.value = user;
        Get.offAndToNamed("/home");
      } on FirebaseAuthException catch (e) {
        Fluttertoast.showToast(msg: e.message.toString());
      }
      loading.value = false;
    }
  }

// splash view

  Future<void> splash() async {
    Future.delayed(const Duration(seconds: 1), () {
      if (auth.currentUser == null) {
        Get.offAndToNamed("/welcome");
      } else {
        userRef.doc(auth.currentUser!.uid).get().then((value) {
          if (value.exists) {
            loggedInuserDetails.value =
                UserModel.fromMap(value.data() as Map<String, dynamic>);
            Get.offAndToNamed("/home");
          } else {
            Get.offAndToNamed("/welcome");
          }
        });
      }
    });
  }
}
