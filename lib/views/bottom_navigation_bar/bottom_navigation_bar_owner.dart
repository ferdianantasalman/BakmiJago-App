import 'package:bakmi_jago_app/resources/color.dart';
import 'package:bakmi_jago_app/views/history/history_view.dart';
import 'package:bakmi_jago_app/views/order/order_view.dart';
import 'package:bakmi_jago_app/views/product/home_product_view.dart';
import 'package:bakmi_jago_app/views/profile/profile_view.dart';
import 'package:bakmi_jago_app/views/report/report_view.dart';
import 'package:flutter/material.dart';

class BottomNavBarOwner extends StatefulWidget {
  const BottomNavBarOwner({super.key});

  @override
  State<BottomNavBarOwner> createState() => _BottomNavBarOwnerState();
}

class _BottomNavBarOwnerState extends State<BottomNavBarOwner> {
  List<Widget> bodyView = const [
    HomeProductView(),
    HistoryView(),
    OrderView(),
    ReportView(),
    ProfileView()
  ];

  int _index = 0;

  void _onTapItem(int index) {
    setState(() {
      _index = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: bodyView[_index],
      bottomNavigationBar: SizedBox(
        // height: 89,
        child: BottomNavigationBar(
            fixedColor: cDarkYellow,
            showUnselectedLabels: true,
            unselectedItemColor: Colors.grey,
            onTap: _onTapItem,
            currentIndex: _index,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: "Produk",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.history),
                label: "Riwayat",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.add),
                label: "Pesanan",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.bar_chart_rounded),
                label: "Laporan",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: "Profile",
              ),
            ]),
      ),
    );
  }
}
