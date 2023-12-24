import 'package:bakmi_jago_app/models/user_model.dart';
import 'package:bakmi_jago_app/providers/user_provider.dart';
import 'package:get/get.dart';

class UserController extends GetxController {
  UserModel userModel = UserModel();
  RxBool isLoading = false.obs;

  // GET Info User or Profile
  Future getInfoUser() async {
    try {
      isLoading.value = true;
      final user = await UserProvider.getUser();
      userModel = user;
      return userModel;
    } catch (e) {
      throw Exception(e);
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onInit() {
    super.onInit();
    getInfoUser();
  }

  @override
  void onReady() {
    super.onReady();
    getInfoUser();
  }

  @override
  void onClose() {
    super.onClose();
    // getInfoUser();
  }
}
