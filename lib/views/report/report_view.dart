import 'package:bakmi_jago_app/controllers/page_index_controller.dart';
import 'package:bakmi_jago_app/resources/color.dart';
import 'package:bakmi_jago_app/resources/font.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ReportView extends StatelessWidget {
  const ReportView({super.key});

  @override
  Widget build(BuildContext context) {
    final pageC = Get.put(PageIndexController());

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
        bottomNavigationBar: CurvedNavigationBar(
          height: 60,
          index: 3,
          color: cYellowDark,
          animationCurve: Curves.bounceInOut,
          animationDuration: Duration(milliseconds: 300),
          backgroundColor: Colors.white,
          // style: TabStyle.fixedCircle,
          items: [
            const Column(
              children: [
                Icon(
                  Icons.wallet_travel,
                  size: 40,
                  color: Colors.white,
                ),
                Text("Produk")
              ],
            ),
            const Column(
              children: [
                Icon(
                  Icons.wallet_travel,
                  size: 40,
                  color: Colors.white,
                ),
                Text("Riwayat")
              ],
            ),
            const Column(
              children: [
                Icon(
                  Icons.add,
                  size: 40,
                  color: Colors.white,
                ),
                Text("Tambah")
              ],
            ),
            const Column(
              children: [
                Icon(
                  Icons.folder,
                  size: 40,
                  color: Colors.white,
                ),
                Text("Laporan")
              ],
            ),
            const Column(
              children: [
                Icon(
                  Icons.person,
                  size: 40,
                  color: Colors.white,
                ),
                Text("Profile")
              ],
            ),
          ],
          onTap: (index) {
            pageC.changePage(index);
          },
        ),
      ),
    );
  }
}
