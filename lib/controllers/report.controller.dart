import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ReportController extends GetxController {
  Rx<TextEditingController> nameController = TextEditingController().obs;
  Rx<TextEditingController> dateController = TextEditingController().obs;
  Rx<TextEditingController> totalController = TextEditingController().obs;
  Rx<TextEditingController> descController = TextEditingController().obs;
}
