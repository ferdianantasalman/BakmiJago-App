import 'package:bakmi_jago_app/models/product/product_model.dart';
import 'package:bakmi_jago_app/resources/color.dart';
import 'package:bakmi_jago_app/resources/constant.dart';
import 'package:bakmi_jago_app/resources/font.dart';
import 'package:bakmi_jago_app/views/product/add_product_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductCardComponent extends StatelessWidget {
  const ProductCardComponent(
      {super.key,
      required this.productModel,
      required this.onTapEdit,
      required this.onTapDelete});

  final ProductModel productModel;
  final Function() onTapEdit;
  final Function() onTapDelete;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 30),
      decoration: BoxDecoration(
          border: Border.all(color: cBlack),
          borderRadius: BorderRadius.circular(12),
          color: cWhite),
      child: Column(
        children: [
          ClipRRect(
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(12), topRight: Radius.circular(12)),
              child: Image.network(
                  "${baseUrl}public/products/${productModel.image}",
                  width: double.infinity,
                  height: 100,
                  fit: BoxFit.fill, errorBuilder: (context, error, stackTrace) {
                return Image.asset(
                  "assets/images/placeholder.png",
                  width: 90,
                  height: 80,
                  fit: BoxFit.cover,
                );
              })),
          Padding(
            padding: const EdgeInsets.all(5),
            child: Text(
              productModel.name!,
              style: bold.copyWith(color: cYellowDark, fontSize: 15),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(2),
            child: Text(
              "Rp. ${productModel.price!}",
              style: bold.copyWith(color: cYellowPrimary, fontSize: 15),
            ),
          ),
          Padding(
              padding: const EdgeInsets.all(2),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  OutlinedButton(
                    onPressed: onTapEdit,
                    style: const ButtonStyle(
                      foregroundColor: MaterialStatePropertyAll(cYellowDark),
                      side: MaterialStatePropertyAll(
                        BorderSide(color: cYellowDark),
                      ),
                    ),
                    child: const Icon(
                      Icons.edit,
                      color: cYellowDark,
                      size: 20,
                    ),
                  ),
                  OutlinedButton(
                    style: const ButtonStyle(
                      foregroundColor: MaterialStatePropertyAll(cYellowDark),
                      side: MaterialStatePropertyAll(
                        BorderSide(color: cYellowDark),
                      ),
                    ),
                    child: const Icon(
                      Icons.delete,
                      color: cYellowDark,
                      size: 20,
                    ),
                    onPressed: () {
                      Get.dialog(
                        Dialog(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(13),
                          ),
                          child: Container(
                            padding: const EdgeInsets.all(16),
                            width: 350,
                            height: 180,
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    "Konfirmasi Untuk Hapus Data?",
                                    style: TextStyle(
                                      color: cYellowDark,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  const Text(
                                    "Dengan mengkonfirmasi anda mensetujui bahwa anda akan menghapus data tersebut",
                                    style: TextStyle(
                                      color: Color(0xff808D9D),
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      ElevatedButton(
                                        style: const ButtonStyle(
                                          elevation:
                                              MaterialStatePropertyAll(0),
                                          backgroundColor:
                                              MaterialStatePropertyAll<Color>(
                                            cYellowDark,
                                          ),
                                        ),
                                        onPressed: onTapDelete,
                                        child: const Text("Konfirmasi"),
                                      ),
                                      OutlinedButton(
                                        onPressed: () => Get.back(),
                                        style: const ButtonStyle(
                                          foregroundColor:
                                              MaterialStatePropertyAll(
                                                  cYellowDark),
                                          side: MaterialStatePropertyAll(
                                            BorderSide(color: cYellowDark),
                                          ),
                                        ),
                                        child: const Text("Batalkan"),
                                      )
                                    ],
                                  )
                                ]),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ))
        ],
      ),
    );

    // Container(
    //   decoration: BoxDecoration(
    //     borderRadius: BorderRadius.circular(12.0),
    //     color: Colors.white,
    //     boxShadow: [
    //       BoxShadow(
    //         color: Colors.grey.withOpacity(0.5),
    //         spreadRadius: 2,
    //         blurRadius: 5,
    //         offset: Offset(0, 2), // changes position of shadow
    //       ),
    //     ],
    //   ),
    //   child: Column(
    //     crossAxisAlignment: CrossAxisAlignment.start,
    //     children: [
    //       ClipRRect(
    //           borderRadius: BorderRadius.vertical(top: Radius.circular(12.0)),
    //           child: Image.asset("assets/images/a.png")),
    //       Padding(
    //         padding: const EdgeInsets.all(8.0),
    //         child: Text(
    //           name,
    //           style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
    //         ),
    //       ),
    //       Padding(
    //         padding: const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 8.0),
    //         child: Text(
    //           '$price', // Replace 'price' with the actual property from your model
    //           style: TextStyle(fontSize: 14.0, color: Colors.green),
    //         ),
    //       ),
    //     ],
    //   ),
    // );

    // Padding(
    //     padding: const EdgeInsets.only(top: 10),
    //     child: Card(
    //       elevation: 5,
    //       child: Padding(
    //         padding: const EdgeInsets.all(5),
    //         child: Column(
    //           crossAxisAlignment: CrossAxisAlignment.start,
    //           children: [
    //             Container(
    //               height: 200,
    //               // width: 20,
    //               decoration: BoxDecoration(
    //                   borderRadius: BorderRadius.circular(10), color: cWhite),
    //               child: Padding(
    //                 padding: const EdgeInsets.all(5),
    //                 child:
    //                     Image.asset('assets/images/a.png', fit: BoxFit.cover),
    //               ),
    //             ),
    //             Padding(
    //               padding: const EdgeInsets.all(5),
    //               child: Text(name,
    //                   style: bold.copyWith(color: cBlack, fontSize: 15)),
    //             ),
    //             Padding(
    //               padding: const EdgeInsets.all(5),
    //               child: Text("$price",
    //                   style:
    //                       regular.copyWith(color: cYellowLight, fontSize: 15)),
    //             )
    //           ],
    //         ),
    //       ),
    //     ));
  }
}
