import 'package:bakmi_jago_app/controllers/report.controller.dart';
import 'package:bakmi_jago_app/resources/color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfitReportView extends StatelessWidget {
  const ProfitReportView({super.key});

  @override
  Widget build(BuildContext context) {
    final reportC = Get.put(ReportController());

    return Scaffold(
      backgroundColor: cWhite,
      body: Center(
        child: Text("Today History"),
      ),
    );
  }
}
