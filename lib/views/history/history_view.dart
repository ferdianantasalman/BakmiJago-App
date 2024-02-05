import 'package:bakmi_jago_app/components/date_field_component.dart';
import 'package:bakmi_jago_app/components/invoice_component.dart';
import 'package:bakmi_jago_app/components/item_history_component.dart';
import 'package:bakmi_jago_app/controllers/invoice_controller.dart';
import 'package:bakmi_jago_app/controllers/page_index_controller.dart';
import 'package:bakmi_jago_app/resources/color.dart';
import 'package:bakmi_jago_app/resources/font.dart';
import 'package:bakmi_jago_app/views/history/detail_history_view.dart';
import 'package:bakmi_jago_app/views/history/month_history_view.dart';
import 'package:bakmi_jago_app/views/history/today_history_view.dart';
import 'package:bakmi_jago_app/views/history/week_history_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HistoryView extends StatelessWidget {
  const HistoryView({super.key});

  @override
  Widget build(BuildContext context) {
    final iController = Get.put(InvoiceController());
    iController.getInvoicesToday();
    iController.getInvoicesWeek();
    iController.getInvoicesMonth();

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: cWhite,
        title: Text(
          "Riwayat Pesanan",
          style: bold.copyWith(fontSize: 25, color: cYellowDark),
        ),
        centerTitle: true,
        bottom: TabBar(
          controller: iController.tabController,
          tabs: iController.myTabs,
          labelColor: cYellowDark,
          indicatorColor: cYellowDark,
        ),
      ),
      body: TabBarView(controller: iController.tabController, children: [
        TodayHistoryView(
            listInvoiceModelToday: iController.listInvoiceModelToday),
        MonthHistoryView(
            listInvoiceModelMonth: iController.listInvoiceModelMonth),
        WeekHistoryView(listInvoiceModelWeek: iController.listInvoiceModelWeek)
      ]),
    );
  }
}
