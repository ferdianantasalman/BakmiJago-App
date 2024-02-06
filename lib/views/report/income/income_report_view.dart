import 'dart:developer';

import 'package:bakmi_jago_app/controllers/income_controller.dart';
import 'package:bakmi_jago_app/controllers/report_controller.dart';
import 'package:bakmi_jago_app/controllers/revenue_controller.dart';
import 'package:bakmi_jago_app/resources/color.dart';
import 'package:bakmi_jago_app/resources/font.dart';
import 'package:bakmi_jago_app/views/report/income/month_income_report_view.dart';
import 'package:bakmi_jago_app/views/report/income/today_income_report_view.dart';
import 'package:bakmi_jago_app/views/report/income/week_income_report_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class IncomeReportView extends StatelessWidget {
  const IncomeReportView({
    super.key,
    required this.incomeModelToday,
    required this.incomeModelWeek,
    required this.incomeModelMonth,
  });

  final String incomeModelToday;
  final String incomeModelWeek;
  final String incomeModelMonth;

  @override
  Widget build(BuildContext context) {
    final incomeC = Get.put(IncomeController());
    incomeC.getIncomeToday();
    incomeC.getIncomeWeek();
    incomeC.getIncomeMonth();

    log("""
    Income TOday == ${incomeC.incomeModelToday.value}
    Income Week == ${incomeC.incomeModelWeek.value}
    Income Month == ${incomeC.incomeModelMonth.value}
    """);

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
          controller: incomeC.tabController,
          tabs: incomeC.myTabs,
          labelColor: cYellowDark,
          indicatorColor: cYellowDark,
        ),
      ),
      body: TabBarView(controller: incomeC.tabController, children: [
        TodayIncomeReportView(
          incomeModel: incomeModelToday,
        ),
        WeekIncomeReportView(
          incomeModel: incomeModelWeek,
        ),
        MonthIncomeReportView(
          incomeModel: incomeModelMonth,
        ),
      ]),
    );
  }
}
