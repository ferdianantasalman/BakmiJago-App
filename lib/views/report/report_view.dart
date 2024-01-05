import 'package:bakmi_jago_app/controllers/page_index_controller.dart';
import 'package:bakmi_jago_app/controllers/report.controller.dart';
import 'package:bakmi_jago_app/resources/color.dart';
import 'package:bakmi_jago_app/resources/font.dart';
import 'package:bakmi_jago_app/views/report/income/income_report_view.dart';
import 'package:bakmi_jago_app/views/report/outcome/add_outcome_view.dart';
import 'package:bakmi_jago_app/views/report/outcome/outcome_report_view.dart';
import 'package:bakmi_jago_app/views/report/profit/profit_report_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ReportView extends StatelessWidget {
  const ReportView({super.key});

  @override
  Widget build(BuildContext context) {
    final reportC = Get.put(ReportController());

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: cWhite,
        title: Text(
          "Laporan Penjualan",
          style: bold.copyWith(fontSize: 25, color: cYellowDark),
        ),
        centerTitle: true,
        bottom: TabBar(
          controller: reportC.tabController,
          tabs: reportC.myTabs,
          labelColor: cYellowDark,
          indicatorColor: cYellowDark,
        ),
      ),
      body: TabBarView(controller: reportC.tabController, children: [
        IncomeReportView(),
        OutcomeReportView(),
        ProfitReportView()
      ]),
    );
  }
}
