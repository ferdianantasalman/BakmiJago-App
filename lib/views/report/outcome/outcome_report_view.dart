import 'package:bakmi_jago_app/controllers/outcome_controller.dart';
import 'package:bakmi_jago_app/resources/color.dart';
import 'package:bakmi_jago_app/resources/font.dart';
import 'package:bakmi_jago_app/views/report/outcome/month_oucome_report_view.dart';
import 'package:bakmi_jago_app/views/report/outcome/today_oucome_report_view.dart';
import 'package:bakmi_jago_app/views/report/outcome/week_oucome_report_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OutcomeReportView extends StatelessWidget {
  const OutcomeReportView({super.key});

  @override
  Widget build(BuildContext context) {
    final outcomeC = Get.put(OutcomeController());
    outcomeC.getReportsToday();
    outcomeC.getReportsWeek();
    outcomeC.getReportsMonth();
    outcomeC.getOutcomeToday();
    outcomeC.getOutcomeWeek();
    outcomeC.getOutcomeMonth();

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: cWhite,
        foregroundColor: cYellowDark,
        title: Text(
          "Laporan Pendapatan",
          style: bold.copyWith(fontSize: 25, color: cYellowDark),
        ),
        centerTitle: true,
        bottom: TabBar(
          controller: outcomeC.tabController,
          tabs: outcomeC.myTabs,
          labelColor: cYellowDark,
          indicatorColor: cYellowDark,
        ),
      ),
      body: TabBarView(controller: outcomeC.tabController, children: [
        TodayOutcomeReportView(
            outcomeModel: outcomeC.outcomeModelToday.value,
            listReportModel: outcomeC.listReportModelToday),
        WeekOutcomeReportView(
            outcomeModel: outcomeC.outcomeModelWeek.value,
            listReportModel: outcomeC.listReportModelWeek),
        MonthOutcomeReportView(
            outcomeModel: outcomeC.outcomeModelMonth.value,
            listReportModel: outcomeC.listReportModelMonth),
      ]),
    );
  }
}
