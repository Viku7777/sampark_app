import 'package:chat_app/Model/UserModel.dart';
import 'package:chat_app/controller/auth_controller.dart';
import 'package:get/get.dart';

class ContactController extends GetxController {
  RxBool loading = false.obs;
  RxList<UserModel> users = <UserModel>[].obs;

  @override
  void onInit() {
    loading.value = true;
    userRef.get().then((value) {
      users.value = value.docs.map((e) => UserModel.fromMap(e.data())).toList();
      loading.value = false;
    });

    super.onInit();
  }
}
