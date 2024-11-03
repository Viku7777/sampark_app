import 'dart:io';

import 'package:chat_app/Model/UserModel.dart';
import 'package:chat_app/controller/auth_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

String loggedInuser = FirebaseAuth.instance.currentUser!.uid;

class ProfileController extends GetxController {
  bool isinit = false;
  Rx<UserModel> currentUser = UserModel().obs;

  Rx<bool> loading = false.obs;
  Future<File> imagePicker() async {
    final ImagePicker picker = ImagePicker();
    XFile? pickedImg = await picker.pickImage(source: ImageSource.gallery);
    // if user not pick any image then show error
    if (pickedImg != null) {
      return File(pickedImg.path);
    } else {
      throw "Image not selected";
    }
  }

  Future<void> updateProfile(
    File? profile,
    String name,
    String about,
  ) async {
    loading.value = true;
    try {
      String imageUrl = "";
      if (profile != null) {
        Reference reference = FirebaseStorage.instance.ref().child(
              'memory/$loggedInuser/img/profile/$name',
            );
        UploadTask uploadTask = reference.putFile(
            profile,
            SettableMetadata(
              contentType: 'image/jpeg',
            ));
        imageUrl = await (await uploadTask).ref.getDownloadURL();
        currentUser.value.profileImage = imageUrl;
      }
      await userRef.doc(loggedInuser).update(imageUrl.isEmpty
          ? {
              "About": about,
              "name": name,
            }
          : {"About": about, "name": name, "profileImage": imageUrl});
      currentUser.value.name = name;
      currentUser.value.about = name;
    } on FirebaseException catch (e) {
      throw e.message!;
    }
    loading.value = false;
  }

  @override
  void onInit() {
    if (!isinit) {
      userRef.doc(loggedInuser).get().then((value) {
        if (value.exists) {
          currentUser.value =
              UserModel.fromMap(value.data() as Map<String, dynamic>);
        } else {
          Get.offAllNamed("/authpage");
        }
      });
      isinit = true;
    }
    super.onInit();
  }
}
