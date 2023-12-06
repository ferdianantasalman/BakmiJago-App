import 'package:bakmi_jago_app/components/date_field_component.dart';
import 'package:bakmi_jago_app/controllers/history_controller.dart';
import 'package:bakmi_jago_app/controllers/page_index_controller.dart';
import 'package:bakmi_jago_app/resources/color.dart';
import 'package:bakmi_jago_app/resources/font.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HistoryView extends StatelessWidget {
  const HistoryView({super.key});

  @override
  Widget build(BuildContext context) {
    final historyC = Get.put(HistoryController());
    final pageC = Get.put(PageIndexController());

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: cWhite,
        title: Text(
          "Riwayat Pesanan",
          style: bold.copyWith(fontSize: 25, color: cYellowDark),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Obx(() => ListView.builder(
            itemCount: historyC.name.length,
            itemBuilder: (context, index) {
              // final newsItem = newsC.data[index];
              return ListTile(
                contentPadding: EdgeInsets.fromLTRB(5, 5, 5, 0),
                focusColor: Colors.amber,
                leading: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: SizedBox.fromSize(
                    size: Size.fromRadius(50),
                    child: Image.network(
                      historyC.image[index],
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                // ),
                title: Text(
                  historyC.name[index],
                  style: semibold.copyWith(fontSize: 15),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                subtitle: Text(
                  "Rp. ${historyC.price[index]}",
                  style: regular.copyWith(fontSize: 13),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                onTap: () {
                  // Handle tap event (e.g., open news article)
                },
              );
            })),
        // child: Padding(
        //     padding: EdgeInsets.only(right: 30, left: 30),
        //     child: Column(
        //       children: [
        //         DateTimeFieldComponent(
        //             controller: historyC.dateController.value,
        //             hintText: "Pilih Tanggal",
        //             obsecureText: false),
        //         SizedBox(
        //           height: 20,
        //         ),
        //         Obx(() => ListView.builder(
        //             itemCount: historyC.name.length,
        //             itemBuilder: (context, index) {
        //               // final newsItem = newsC.data[index];
        //               return ListTile(
        //                 contentPadding: EdgeInsets.fromLTRB(5, 5, 5, 0),
        //                 focusColor: Colors.amber,
        //                 leading: ClipRRect(
        //                   borderRadius: BorderRadius.circular(10),
        //                   child: SizedBox.fromSize(
        //                     size: Size.fromRadius(50),
        //                     child: Image.network(
        //                       historyC.image[index],
        //                       fit: BoxFit.cover,
        //                     ),
        //                   ),
        //                 ),
        //                 // ),
        //                 title: Text(
        //                   historyC.name[index],
        //                   style: semibold.copyWith(fontSize: 15),
        //                   maxLines: 2,
        //                   overflow: TextOverflow.ellipsis,
        //                 ),
        //                 subtitle: Text(
        //                   "Rp. ${historyC.price[index]}",
        //                   style: regular.copyWith(fontSize: 13),
        //                   maxLines: 2,
        //                   overflow: TextOverflow.ellipsis,
        //                 ),
        //                 onTap: () {
        //                   // Handle tap event (e.g., open news article)
        //                 },
        //               );
        //             })),
        //       ],
        //     )),
      ),
      bottomNavigationBar: CurvedNavigationBar(
        height: 60,
        index: 1,
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
    );
  }
}
