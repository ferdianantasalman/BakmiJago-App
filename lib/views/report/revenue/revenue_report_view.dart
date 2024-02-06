import 'dart:developer';

import 'package:bakmi_jago_app/controllers/report_controller.dart';
import 'package:bakmi_jago_app/controllers/revenue_controller.dart';
import 'package:bakmi_jago_app/models/revenue_model.dart';
import 'package:bakmi_jago_app/resources/color.dart';
import 'package:bakmi_jago_app/resources/font.dart';
import 'package:bakmi_jago_app/views/report/revenue/month__revenue_report_view.dart';
import 'package:bakmi_jago_app/views/report/revenue/today__revenue_report_view.dart';
import 'package:bakmi_jago_app/views/report/revenue/week__revenue_report_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RevenueReportView extends StatelessWidget {
  const RevenueReportView({
    super.key,
    required this.revenueModelToday,
    required this.revenueModelWeek,
    required this.revenueModelMonth,
  });

  final String revenueModelToday;
  final String revenueModelWeek;
  final String revenueModelMonth;

  @override
  Widget build(BuildContext context) {
    final revenueC = Get.put(RevenueController());
    revenueC.getRevenueToday();
    revenueC.getRevenueWeek();
    revenueC.getRevenueMonth();

    log("""
    Revenue TOday == ${revenueC.revenueModelToday}
    Revenue Week == ${revenueC.revenueModelWeek}
    Revenue Month == ${revenueC.revenueModelMonth}
    """);

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: cWhite,
        foregroundColor: cYellowDark,
        title: Text(
          "Laporan keuntungan",
          style: bold.copyWith(fontSize: 25, color: cYellowDark),
        ),
        centerTitle: true,
        bottom: TabBar(
          controller: revenueC.tabController,
          tabs: revenueC.myTabs,
          labelColor: cYellowDark,
          indicatorColor: cYellowDark,
        ),
      ),
      body: TabBarView(controller: revenueC.tabController, children: [
        TodayRevenueReportView(
          revenueModel: revenueC.revenueModelToday.value,
        ),
        WeekRevenueReportView(
          revenueModel: revenueC.revenueModelWeek.value,
        ),
        MonthRevenueReportView(
          revenueModel: revenueC.revenueModelMonth.value,
        ),
      ]),
    );
  }
}
