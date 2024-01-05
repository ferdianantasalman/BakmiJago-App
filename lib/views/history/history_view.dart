import 'package:bakmi_jago_app/components/date_field_component.dart';
import 'package:bakmi_jago_app/components/invoice_component.dart';
import 'package:bakmi_jago_app/components/item_history_component.dart';
import 'package:bakmi_jago_app/controllers/history_controller.dart';
import 'package:bakmi_jago_app/controllers/page_index_controller.dart';
import 'package:bakmi_jago_app/resources/color.dart';
import 'package:bakmi_jago_app/resources/font.dart';
import 'package:bakmi_jago_app/views/history/detail_history_view.dart';
import 'package:bakmi_jago_app/views/history/month_history_view.dart';
import 'package:bakmi_jago_app/views/history/today_history_view.dart';
import 'package:bakmi_jago_app/views/history/year_history_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HistoryView extends StatelessWidget {
  const HistoryView({super.key});

  @override
  Widget build(BuildContext context) {
    final historyC = Get.put(HistoryController());

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
          controller: historyC.tabController,
          tabs: historyC.myTabs,
          labelColor: cYellowDark,
          indicatorColor: cYellowDark,
        ),
      ),
      body: TabBarView(controller: historyC.tabController, children: [
        TodayHistoryView(),
        MonthHistoryView(),
        YearHistoryView()
      ]),

      // Column(
      //   children: [
      //     Padding(
      //       padding: const EdgeInsets.all(20.0),
      //       child: DateTimeFieldComponent(
      //           controller: historyC.dateController.value,
      //           hintText: "Pilih Tanggal",
      //           obsecureText: false),
      //     ),
      //     const SizedBox(
      //       height: 20,
      //     ),
      //     Obx(() => historyC.isLoading.value
      //         ? const Center(
      //             child: CircularProgressIndicator(
      //               color: cPrimaryGreen,
      //             ),
      //           )
      //         : Padding(
      //             padding: const EdgeInsets.all(20),
      //             child: historyC.name.isEmpty
      //                 ? const Center(
      //                     child: Text('Tidak ada Laporan'),
      //                   )
      //                 : Obx(() => ListView.builder(
      //                     scrollDirection: Axis.vertical,
      //                     itemCount: historyC.name.length,
      //                     itemBuilder: (context, index) {
      //                       return ItemHistoryComponent(
      //                         invoiceName: "INV-1",
      //                         price: 5000,
      //                         totalBarang: 20000,
      //                         onTap: () {
      //                           Get.to(const DetailHistoryView());
      //                         },
      //                       );
      //                     }))))
      //   ],
      // )

      // SingleChildScrollView(
      //   // child: Obx(() => ListView.builder(
      //   //     itemCount: historyC.name.length,
      //   //     itemBuilder: (context, index) {
      //   //       // final newsItem = newsC.data[index];
      //   //       return ListTile(
      //   //         contentPadding: EdgeInsets.fromLTRB(5, 5, 5, 0),
      //   //         focusColor: Colors.amber,
      //   //         leading: ClipRRect(
      //   //           borderRadius: BorderRadius.circular(10),
      //   //           child: SizedBox.fromSize(
      //   //             size: Size.fromRadius(50),
      //   //             child:
      //   //                 Image.network(historyC.image[index], fit: BoxFit.cover,
      //   //                     errorBuilder: (context, error, stackTrace) {
      //   //               return Image.asset(
      //   //                 "assets/images/placeholder.png",
      //   //                 width: 90,
      //   //                 height: 80,
      //   //                 fit: BoxFit.cover,
      //   //               );
      //   //             }),
      //   //           ),
      //   //         ),
      //   //         // ),
      //   //         title: Text(
      //   //           historyC.name[index],
      //   //           style: semibold.copyWith(fontSize: 15),
      //   //           maxLines: 2,
      //   //           overflow: TextOverflow.ellipsis,
      //   //         ),
      //   //         subtitle: Text(
      //   //           "Rp. ${historyC.price[index]}",
      //   //           style: regular.copyWith(fontSize: 13),
      //   //           maxLines: 2,
      //   //           overflow: TextOverflow.ellipsis,
      //   //         ),
      //   //         onTap: () {
      //   //           // Handle tap event (e.g., open news article)
      //   //         },
      //   //       );
      //   //     })),
      //   child: Padding(
      //       padding: EdgeInsets.only(right: 30, left: 30),
      //       child: Column(
      //         children: [
      //           DateTimeFieldComponent(
      //               controller: historyC.dateController.value,
      //               hintText: "Pilih Tanggal",
      //               obsecureText: false),
      //           const SizedBox(
      //             height: 20,
      //           ),
      //           // invoiceCard()

      //           // Obx(() => ListView.builder(
      //           //     itemCount: historyC.name.length,
      //           //     itemBuilder: (context, index) {
      //           //       // final newsItem = newsC.data[index];
      //           //       return ListTile(
      //           //         contentPadding: EdgeInsets.fromLTRB(5, 5, 5, 0),
      //           //         focusColor: Colors.amber,
      //           //         leading: ClipRRect(
      //           //           borderRadius: BorderRadius.circular(10),
      //           //           child: SizedBox.fromSize(
      //           //             size: Size.fromRadius(50),
      //           //             child: Image.network(
      //           //               historyC.image[index],
      //           //               fit: BoxFit.cover,
      //           //             ),
      //           //           ),
      //           //         ),
      //           //         // ),
      //           //         title: Text(
      //           //           historyC.name[index],
      //           //           style: semibold.copyWith(fontSize: 15),
      //           //           maxLines: 2,
      //           //           overflow: TextOverflow.ellipsis,
      //           //         ),
      //           //         subtitle: Text(
      //           //           "Rp. ${historyC.price[index]}",
      //           //           style: regular.copyWith(fontSize: 13),
      //           //           maxLines: 2,
      //           //           overflow: TextOverflow.ellipsis,
      //           //         ),
      //           //         onTap: () {
      //           //           // Handle tap event (e.g., open news article)
      //           //         },
      //           //       );
      //           //     })),
      //         ],
      //       )),
      // ),
    );
  }
}
