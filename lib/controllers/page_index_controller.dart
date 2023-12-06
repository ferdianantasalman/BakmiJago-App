import 'package:bakmi_jago_app/views/history/history_view.dart';
import 'package:bakmi_jago_app/views/order/order.dart';
import 'package:bakmi_jago_app/views/product/home_product_view.dart';
import 'package:bakmi_jago_app/views/profile/profile_view.dart';
import 'package:bakmi_jago_app/views/report/report_view.dart';
import 'package:get/get.dart';

class PageIndexController extends GetxController {
  RxInt pageIndex = 0.obs;
  RxInt current = 0.obs;

  final count = 0.obs;

  void changePage(int index) async {
    pageIndex.value = index;
    switch (index) {
      case 0:
        Get.offAll(HomeProductView());
        break;
      case 1:
        Get.offAll(HistoryView());
        break;
      case 2:
        Get.offAll(OrderView());
        break;
      case 3:
        Get.offAll(ReportView());
        break;
      case 4:
        Get.offAll(ProfileView());
        break;
      default:
        Get.offAll(HomeProductView());
    }
  }

  void changeIndex(int index) async {
    current.value = index;
  }

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
}
