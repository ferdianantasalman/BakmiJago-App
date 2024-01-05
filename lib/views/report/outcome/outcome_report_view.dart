import 'package:bakmi_jago_app/controllers/report.controller.dart';
import 'package:bakmi_jago_app/resources/color.dart';
import 'package:bakmi_jago_app/resources/font.dart';
import 'package:bakmi_jago_app/views/report/outcome/add_outcome_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OutcomeReportView extends StatelessWidget {
  const OutcomeReportView({super.key});

  @override
  Widget build(BuildContext context) {
    final reportC = Get.put(ReportController());

    return Scaffold(
      backgroundColor: cWhite,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(const AddOutcomeView());
        },
        backgroundColor: cYellowDark,
        child: Icon(Icons.add),
      ),
      body: Center(
          child: Text("Laporan Pengeluaran",
              style: regular.copyWith(color: cYellowDark, fontSize: 20))),
    );
  }
}
