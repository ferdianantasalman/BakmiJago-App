import 'package:bakmi_jago_app/controllers/report_controller.dart';
import 'package:bakmi_jago_app/controllers/revenue_controller.dart';
import 'package:bakmi_jago_app/resources/color.dart';
import 'package:bakmi_jago_app/resources/font.dart';
import 'package:bakmi_jago_app/views/report/revenue/month__revenue_report_view.dart';
import 'package:bakmi_jago_app/views/report/revenue/today__revenue_report_view.dart';
import 'package:bakmi_jago_app/views/report/revenue/week__revenue_report_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RevenueReportView extends StatelessWidget {
  const RevenueReportView({super.key});

  @override
  Widget build(BuildContext context) {
    final revenueC = Get.put(RevenueController());
    revenueC.getRevenueToday();
    revenueC.getRevenueWeek();
    revenueC.getRevenueMonth();

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
