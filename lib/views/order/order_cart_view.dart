import 'dart:developer';

import 'package:bakmi_jago_app/components/button_component.dart';
import 'package:bakmi_jago_app/components/icon_button_component.dart';
import 'package:bakmi_jago_app/components/item_order_cart_component.dart';
import 'package:bakmi_jago_app/components/text_field_outlined_component.dart';
import 'package:bakmi_jago_app/controllers/order_controller.dart';
import 'package:bakmi_jago_app/resources/color.dart';
import 'package:bakmi_jago_app/resources/font.dart';
import 'package:flutter/material.dart';
import 'package:flutter_file_downloader/flutter_file_downloader.dart';
import 'package:get/get.dart';

class OrderCartView extends StatelessWidget {
  const OrderCartView({super.key});

  @override
  Widget build(BuildContext context) {
    final orderC = Get.put(OrderController());
    return Scaffold(
      backgroundColor: cWhite,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: cWhite,
        foregroundColor: cYellowDark,
        title: Text(
          "Pesanan",
          style: bold.copyWith(fontSize: 25, color: cYellowDark),
        ),
        centerTitle: true,
      ),
      body: Obx(() => orderC.isLoading.value
          ? const Center(
              child: CircularProgressIndicator(
                color: cPrimaryGreen,
              ),
            )
          : Padding(
              padding: const EdgeInsets.all(20),
              child: orderC.name.isEmpty
                  ? const Center(
                      child: Text('Tidak ada Laporan'),
                    )
                  : Obx(() => ListView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: orderC.name.length,
                      itemBuilder: (context, index) {
                        return ItemOrderCartComponent();
                      })))),
      bottomNavigationBar: BottomAppBar(
        padding: const EdgeInsets.all(10),
        height: 100,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text("Pilih Pembayaran",
                textAlign: TextAlign.center,
                style: bold.copyWith(fontSize: 15, color: cYellowDark)),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButtonComponent(
                  "Tunai",
                  onPressed: () {
                    // orderC.addOrders();
                    Get.dialog(Dialog(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        width: 350,
                        height: 180,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Pembayaran Tunai",
                                style: bold.copyWith(
                                    fontSize: 20, color: cYellowDark)),
                            const SizedBox(height: 15),
                            TextFieldOutlinedComponent(
                                hintText: "Uang diterima",
                                textController:
                                    orderC.inputCashController.value,
                                keyboardType: TextInputType.number),
                            const SizedBox(height: 8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                OutlinedButton(
                                  onPressed: () {
                                    Get.back();
                                  },
                                  style: const ButtonStyle(
                                    foregroundColor:
                                        MaterialStatePropertyAll(cYellowDark),
                                    side: MaterialStatePropertyAll(
                                      BorderSide(color: cYellowDark),
                                    ),
                                  ),
                                  child: Text("Batal",
                                      style: regular.copyWith(
                                          fontSize: 15, color: cYellowDark)),
                                ),
                                const SizedBox(width: 10),
                                OutlinedButton(
                                  onPressed: () {
                                    Get.dialog(Dialog(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      child: Container(
                                        padding: const EdgeInsets.all(10),
                                        width: 350,
                                        height: 400,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Center(
                                              child: Text("Pembayaran Berhasil",
                                                  style: bold.copyWith(
                                                      fontSize: 20,
                                                      color: cYellowDark)),
                                            ),
                                            const SizedBox(height: 30),
                                            Text("Metode Pembayaran",
                                                style: bold.copyWith(
                                                    fontSize: 15,
                                                    color: cYellowDark)),
                                            const SizedBox(height: 10),
                                            Text("Tunai",
                                                style: bold.copyWith(
                                                    fontSize: 15,
                                                    color: cYellowLight)),
                                            const SizedBox(height: 15),
                                            Text("Total Pembelian",
                                                style: bold.copyWith(
                                                    fontSize: 15,
                                                    color: cYellowDark)),
                                            const SizedBox(height: 10),
                                            Text("Rp. 50000",
                                                style: bold.copyWith(
                                                    fontSize: 15,
                                                    color: cYellowLight)),
                                            const SizedBox(height: 15),
                                            Text("Nominal Bayar",
                                                style: bold.copyWith(
                                                    fontSize: 15,
                                                    color: cYellowDark)),
                                            const SizedBox(height: 10),
                                            Text("Rp. 50000",
                                                style: bold.copyWith(
                                                    fontSize: 15,
                                                    color: cYellowLight)),
                                            const SizedBox(height: 15),
                                            Text("Waktu Pembayaran",
                                                style: bold.copyWith(
                                                    fontSize: 15,
                                                    color: cYellowDark)),
                                            const SizedBox(height: 10),
                                            Text("12 Desember",
                                                style: bold.copyWith(
                                                    fontSize: 15,
                                                    color: cYellowLight)),
                                            const SizedBox(height: 25),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                OutlinedButton(
                                                  onPressed: () {
                                                    Get.back();
                                                  },
                                                  style: const ButtonStyle(
                                                    foregroundColor:
                                                        MaterialStatePropertyAll(
                                                            cYellowDark),
                                                    side:
                                                        MaterialStatePropertyAll(
                                                      BorderSide(
                                                          color: cYellowDark),
                                                    ),
                                                  ),
                                                  child: Text("Selesai",
                                                      style: regular.copyWith(
                                                          fontSize: 15,
                                                          color: cYellowDark)),
                                                ),
                                                OutlinedButton(
                                                  onPressed: () {
                                                    Get.dialog(Dialog(
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(15),
                                                      ),
                                                      child: Container(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(10),
                                                        width: 350,
                                                        height: 400,
                                                        child: Column(
                                                          children: [
                                                            Text("Nota Pesanan",
                                                                style: bold.copyWith(
                                                                    fontSize:
                                                                        20,
                                                                    color:
                                                                        cYellowDark)),
                                                            const SizedBox(
                                                                height: 10),
                                                            Image.network(
                                                              "https://www.w3schools.com/w3images/avatar2.png",
                                                              width: 300,
                                                              height: 280,
                                                            ),
                                                            const SizedBox(
                                                                height: 10),
                                                            Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              children: [
                                                                OutlinedButton(
                                                                  onPressed:
                                                                      () {
                                                                    Get.back();
                                                                  },
                                                                  style:
                                                                      const ButtonStyle(
                                                                    foregroundColor:
                                                                        MaterialStatePropertyAll(
                                                                            cYellowDark),
                                                                    side:
                                                                        MaterialStatePropertyAll(
                                                                      BorderSide(
                                                                          color:
                                                                              cYellowDark),
                                                                    ),
                                                                  ),
                                                                  child: Text(
                                                                      "Kembali",
                                                                      style: regular.copyWith(
                                                                          fontSize:
                                                                              15,
                                                                          color:
                                                                              cYellowDark)),
                                                                ),
                                                                const SizedBox(
                                                                    width: 10),
                                                                OutlinedButton(
                                                                  onPressed:
                                                                      () {
                                                                    log("https://www.w3schools.com/w3images/avatar2.png");
                                                                    FileDownloader.downloadFile(
                                                                        url: "https://www.w3schools.com/w3images/avatar2.png",
                                                                        onProgress: (name, progress) {
                                                                          log("Download Nota");
                                                                        },
                                                                        onDownloadCompleted: (value) {
                                                                          log("Download Succes");
                                                                          Get.snackbar(
                                                                              "Download Berhasil",
                                                                              "Cek Pada Folder Download File Manager");
                                                                        });
                                                                  },
                                                                  style:
                                                                      const ButtonStyle(
                                                                    foregroundColor:
                                                                        MaterialStatePropertyAll(
                                                                            cYellowDark),
                                                                    side:
                                                                        MaterialStatePropertyAll(
                                                                      BorderSide(
                                                                          color:
                                                                              cYellowDark),
                                                                    ),
                                                                  ),
                                                                  child: Text(
                                                                      "Download",
                                                                      style: regular.copyWith(
                                                                          fontSize:
                                                                              15,
                                                                          color:
                                                                              cYellowDark)),
                                                                ),
                                                              ],
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                    ));
                                                  },
                                                  style: const ButtonStyle(
                                                    foregroundColor:
                                                        MaterialStatePropertyAll(
                                                            cYellowDark),
                                                    side:
                                                        MaterialStatePropertyAll(
                                                      BorderSide(
                                                          color: cYellowDark),
                                                    ),
                                                  ),
                                                  child: Text("Lihat Nota",
                                                      style: regular.copyWith(
                                                          fontSize: 15,
                                                          color: cYellowDark)),
                                                ),
                                                OutlinedButton(
                                                  onPressed: () {},
                                                  style: const ButtonStyle(
                                                    foregroundColor:
                                                        MaterialStatePropertyAll(
                                                            cYellowDark),
                                                    side:
                                                        MaterialStatePropertyAll(
                                                      BorderSide(
                                                          color: cYellowDark),
                                                    ),
                                                  ),
                                                  child: Text("Print",
                                                      style: regular.copyWith(
                                                          fontSize: 15,
                                                          color: cYellowDark)),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ));
                                  },
                                  style: const ButtonStyle(
                                    foregroundColor:
                                        MaterialStatePropertyAll(cYellowDark),
                                    side: MaterialStatePropertyAll(
                                      BorderSide(color: cYellowDark),
                                    ),
                                  ),
                                  child: Text("Proses",
                                      style: regular.copyWith(
                                          fontSize: 15, color: cYellowDark)),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ));
                  },
                  color: cYellowDark,
                  icon: const Icon(Icons.attach_money),
                ),
                const SizedBox(width: 10),
                IconButtonComponent(
                  "QRIS",
                  onPressed: () {
                    Get.dialog(Dialog(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        width: 350,
                        height: 400,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Pembayaran QRIS",
                                style: bold.copyWith(
                                    fontSize: 20, color: cYellowDark)),
                            const SizedBox(height: 8),
                            Image.asset(
                              "assets/images/qrcode.jpg",
                              width: 300,
                              height: 280,
                            ),
                            const SizedBox(height: 8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                OutlinedButton(
                                  onPressed: () {
                                    Get.back();
                                  },
                                  style: const ButtonStyle(
                                    foregroundColor:
                                        MaterialStatePropertyAll(cYellowDark),
                                    side: MaterialStatePropertyAll(
                                      BorderSide(color: cYellowDark),
                                    ),
                                  ),
                                  child: Text("Batal",
                                      style: regular.copyWith(
                                          fontSize: 15, color: cYellowDark)),
                                ),
                                const SizedBox(width: 10),
                                OutlinedButton(
                                  onPressed: () {
                                    Get.dialog(Dialog(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      child: Container(
                                        padding: const EdgeInsets.all(10),
                                        width: 350,
                                        height: 400,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Center(
                                              child: Text("Pembayaran Berhasil",
                                                  style: bold.copyWith(
                                                      fontSize: 20,
                                                      color: cYellowDark)),
                                            ),
                                            const SizedBox(height: 30),
                                            Text("Metode Pembayaran",
                                                style: bold.copyWith(
                                                    fontSize: 15,
                                                    color: cYellowDark)),
                                            const SizedBox(height: 10),
                                            Text("Tunai",
                                                style: bold.copyWith(
                                                    fontSize: 15,
                                                    color: cYellowLight)),
                                            const SizedBox(height: 15),
                                            Text("Total Pembelian",
                                                style: bold.copyWith(
                                                    fontSize: 15,
                                                    color: cYellowDark)),
                                            const SizedBox(height: 10),
                                            Text("Rp. 50000",
                                                style: bold.copyWith(
                                                    fontSize: 15,
                                                    color: cYellowLight)),
                                            const SizedBox(height: 15),
                                            Text("Nominal Bayar",
                                                style: bold.copyWith(
                                                    fontSize: 15,
                                                    color: cYellowDark)),
                                            const SizedBox(height: 10),
                                            Text("Rp. 50000",
                                                style: bold.copyWith(
                                                    fontSize: 15,
                                                    color: cYellowLight)),
                                            const SizedBox(height: 15),
                                            Text("Waktu Pembayaran",
                                                style: bold.copyWith(
                                                    fontSize: 15,
                                                    color: cYellowDark)),
                                            const SizedBox(height: 10),
                                            Text("12 Desember",
                                                style: bold.copyWith(
                                                    fontSize: 15,
                                                    color: cYellowLight)),
                                            const SizedBox(height: 25),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                OutlinedButton(
                                                  onPressed: () {
                                                    Get.back();
                                                  },
                                                  style: const ButtonStyle(
                                                    foregroundColor:
                                                        MaterialStatePropertyAll(
                                                            cYellowDark),
                                                    side:
                                                        MaterialStatePropertyAll(
                                                      BorderSide(
                                                          color: cYellowDark),
                                                    ),
                                                  ),
                                                  child: Text("Selesai",
                                                      style: regular.copyWith(
                                                          fontSize: 15,
                                                          color: cYellowDark)),
                                                ),
                                                OutlinedButton(
                                                  onPressed: () {
                                                    Get.dialog(Dialog(
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(15),
                                                      ),
                                                      child: Container(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(10),
                                                        width: 350,
                                                        height: 400,
                                                        child: Column(
                                                          children: [
                                                            Text("Nota Pesanan",
                                                                style: bold.copyWith(
                                                                    fontSize:
                                                                        20,
                                                                    color:
                                                                        cYellowDark)),
                                                            const SizedBox(
                                                                height: 10),
                                                            Image.network(
                                                              "https://www.w3schools.com/w3images/avatar2.png",
                                                              width: 300,
                                                              height: 280,
                                                            ),
                                                            const SizedBox(
                                                                height: 10),
                                                            Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              children: [
                                                                OutlinedButton(
                                                                  onPressed:
                                                                      () {
                                                                    Get.back();
                                                                  },
                                                                  style:
                                                                      const ButtonStyle(
                                                                    foregroundColor:
                                                                        MaterialStatePropertyAll(
                                                                            cYellowDark),
                                                                    side:
                                                                        MaterialStatePropertyAll(
                                                                      BorderSide(
                                                                          color:
                                                                              cYellowDark),
                                                                    ),
                                                                  ),
                                                                  child: Text(
                                                                      "Kembali",
                                                                      style: regular.copyWith(
                                                                          fontSize:
                                                                              15,
                                                                          color:
                                                                              cYellowDark)),
                                                                ),
                                                                const SizedBox(
                                                                    width: 10),
                                                                OutlinedButton(
                                                                  onPressed:
                                                                      () {
                                                                    log("https://www.w3schools.com/w3images/avatar2.png");
                                                                    FileDownloader.downloadFile(
                                                                        url: "https://www.w3schools.com/w3images/avatar2.png",
                                                                        onProgress: (name, progress) {
                                                                          log("Download Nota");
                                                                        },
                                                                        onDownloadCompleted: (value) {
                                                                          log("Download Succes");
                                                                          Get.snackbar(
                                                                              "Download Berhasil",
                                                                              "Cek Pada Folder Download File Manager");
                                                                        });
                                                                  },
                                                                  style:
                                                                      const ButtonStyle(
                                                                    foregroundColor:
                                                                        MaterialStatePropertyAll(
                                                                            cYellowDark),
                                                                    side:
                                                                        MaterialStatePropertyAll(
                                                                      BorderSide(
                                                                          color:
                                                                              cYellowDark),
                                                                    ),
                                                                  ),
                                                                  child: Text(
                                                                      "Download",
                                                                      style: regular.copyWith(
                                                                          fontSize:
                                                                              15,
                                                                          color:
                                                                              cYellowDark)),
                                                                ),
                                                              ],
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                    ));
                                                  },
                                                  style: const ButtonStyle(
                                                    foregroundColor:
                                                        MaterialStatePropertyAll(
                                                            cYellowDark),
                                                    side:
                                                        MaterialStatePropertyAll(
                                                      BorderSide(
                                                          color: cYellowDark),
                                                    ),
                                                  ),
                                                  child: Text("Lihat Nota",
                                                      style: regular.copyWith(
                                                          fontSize: 15,
                                                          color: cYellowDark)),
                                                ),
                                                OutlinedButton(
                                                  onPressed: () {},
                                                  style: const ButtonStyle(
                                                    foregroundColor:
                                                        MaterialStatePropertyAll(
                                                            cYellowDark),
                                                    side:
                                                        MaterialStatePropertyAll(
                                                      BorderSide(
                                                          color: cYellowDark),
                                                    ),
                                                  ),
                                                  child: Text("Print",
                                                      style: regular.copyWith(
                                                          fontSize: 15,
                                                          color: cYellowDark)),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ));
                                  },
                                  style: const ButtonStyle(
                                    foregroundColor:
                                        MaterialStatePropertyAll(cYellowDark),
                                    side: MaterialStatePropertyAll(
                                      BorderSide(color: cYellowDark),
                                    ),
                                  ),
                                  child: Text("Proses",
                                      style: regular.copyWith(
                                          fontSize: 15, color: cYellowDark)),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ));
                  },
                  color: cYellowDark,
                  icon: const Icon(Icons.qr_code_scanner_outlined),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// void showDialog() {
//   Get.dialog(Dialog());
// }
