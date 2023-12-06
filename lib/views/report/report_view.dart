import 'package:bakmi_jago_app/controllers/page_index_controller.dart';
import 'package:bakmi_jago_app/resources/color.dart';
import 'package:bakmi_jago_app/resources/font.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ReportView extends StatelessWidget {
  const ReportView({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: cWhite,
          title: Text(
            "Riwayat Pesanan",
            style: bold.copyWith(fontSize: 25, color: cYellowDark),
          ),
          centerTitle: true,
          bottom: TabBar(
              labelColor: cYellowDark,
              indicatorColor: cYellowDark,
              tabs: [
                Tab(
                  text: "Pemasukan",
                ),
                Tab(text: "Pengeluaran"),
                Tab(text: "Penjualan"),
              ]),
        ),
        body: TabBarView(children: [
          Center(
              child: Text("Laporan Pemasukan",
                  style: regular.copyWith(color: cYellowDark, fontSize: 20))),
          Center(
              child: Text("Laporan Pengeluaran",
                  style: regular.copyWith(color: cYellowDark, fontSize: 20))),
          Center(
              child: Text("Laporan Penjualan",
                  style: regular.copyWith(color: cYellowDark, fontSize: 20))),
        ]),
      ),
    );
  }
}
