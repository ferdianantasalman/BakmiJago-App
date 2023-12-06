import 'package:bakmi_jago_app/resources/color.dart';
import 'package:bakmi_jago_app/resources/font.dart';
import 'package:flutter/material.dart';

class ProductCardComponent extends StatelessWidget {
  const ProductCardComponent(
      {super.key,
      required this.image,
      required this.name,
      required this.price});

  final dynamic image;
  final String name;
  final int price;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
          border: Border.all(color: cBlack),
          borderRadius: BorderRadius.circular(12),
          color: cWhite),
      child: Column(
        children: [
          ClipRRect(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12), topRight: Radius.circular(12)),
              child: Image.network(image,
                  width: double.infinity, fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
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
              name,
              style: bold.copyWith(color: cBlack, fontSize: 15),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(2),
            child: Text(
              "Rp. $price",
              style: bold.copyWith(color: cYellowDark, fontSize: 15),
            ),
          )
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
