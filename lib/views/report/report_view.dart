import 'dart:developer';

import 'package:bakmi_jago_app/components/list_tile_component.dart';
import 'package:bakmi_jago_app/controllers/income_controller.dart';
import 'package:bakmi_jago_app/controllers/outcome_controller.dart';
import 'package:bakmi_jago_app/controllers/page_index_controller.dart';
import 'package:bakmi_jago_app/controllers/report_controller.dart';
import 'package:bakmi_jago_app/controllers/revenue_controller.dart';
import 'package:bakmi_jago_app/resources/color.dart';
import 'package:bakmi_jago_app/resources/font.dart';
import 'package:bakmi_jago_app/views/report/income/income_report_view.dart';
import 'package:bakmi_jago_app/views/report/outcome/add_outcome_view.dart';
import 'package:bakmi_jago_app/views/report/outcome/outcome_report_view.dart';
import 'package:bakmi_jago_app/views/report/revenue/revenue_report_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ReportView extends StatelessWidget {
  const ReportView({super.key});

  @override
  Widget build(BuildContext context) {
    final reportC = Get.put(ReportController());
    final incomeC = Get.put(IncomeController());
    final outcomeC = Get.put(OutcomeController());
    final revenueC = Get.put(RevenueController());

    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: cWhite,
          title: Text(
            "Laporan Penjualan",
            style: bold.copyWith(fontSize: 25, color: cYellowDark),
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              ListTileComponent(
                title: "Laporan Pendapatan",
                desc: "Manu untuk melihat laporan pendapatan",
                onTap: () {
                  incomeC.getIncomeToday();
                  incomeC.getIncomeWeek();
                  incomeC.getIncomeMonth();
                  log("hahah ${incomeC.incomeModelToday}");
                  log("loh iya ${incomeC.incomeModelWeek}");
                  log("iya loh ${incomeC.incomeModelMonth}");
                  Get.to(IncomeReportView(
                    incomeModelToday: incomeC.incomeModelToday.value,
                    incomeModelWeek: incomeC.incomeModelWeek.value,
                    incomeModelMonth: incomeC.incomeModelMonth.value,
                  ));
                },
              ),
              ListTileComponent(
                title: "Laporan Pengeluaran",
                desc: "Manu untuk melihat laporan pengeluaran",
                onTap: () {
                  outcomeC.getOutcomeToday();
                  outcomeC.getOutcomeWeek();
                  outcomeC.getOutcomeMonth();
                  log("hahah ${outcomeC.outcomeModelToday}");
                  log("loh iya ${outcomeC.outcomeModelWeek}");
                  log("iya loh ${outcomeC.outcomeModelMonth}");
                  Get.to(OutcomeReportView(
                    outcomeModelToday: outcomeC.outcomeModelToday.value,
                    outcomeModelWeek: outcomeC.outcomeModelWeek.value,
                    outcomeModelMonth: outcomeC.outcomeModelMonth.value,
                  ));
                },
              ),
              ListTileComponent(
                title: "Laporan Keuntungan",
                desc: "Manu untuk melihat laporan keuntungan",
                onTap: () {
                  revenueC.getRevenueToday();
                  revenueC.getRevenueWeek();
                  revenueC.getRevenueMonth();
                  log("hehe");
                  log("Today Reve == ${revenueC.revenueModelToday.value}");
                  log("Week Reve == ${revenueC.revenueModelWeek.value}");
                  log("Month Reve === ${revenueC.revenueModelMonth.value}");
                  Get.to(RevenueReportView(
                    revenueModelToday: revenueC.revenueModelToday.value,
                    revenueModelWeek: revenueC.revenueModelWeek.value,
                    revenueModelMonth: revenueC.revenueModelMonth.value,
                  ));
                },
              ),
            ],
          ),
        ));
  }
}
