import 'package:bakmi_jago_app/components/product_card_component.dart';
import 'package:bakmi_jago_app/controllers/page_index_controller.dart';
import 'package:bakmi_jago_app/controllers/product_controller.dart';
import 'package:bakmi_jago_app/main.dart';
import 'package:bakmi_jago_app/resources/color.dart';
import 'package:bakmi_jago_app/resources/font.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

class HomeProductView extends StatelessWidget {
  const HomeProductView({super.key});

  @override
  Widget build(BuildContext context) {
    final pController = Get.put(ProductController());
    final pageC = Get.put(PageIndexController());
    return Scaffold(
      backgroundColor: cWhite,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: cWhite,
        title: Text(
          "Bakmi Jago",
          style: bold.copyWith(fontSize: 25, color: cYellowDark),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 30, right: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Row(
                  children: [
                    Container(
                      height: 32,
                      width: 32,
                      child: CircleAvatar(
                        backgroundImage: NetworkImage(
                          "https://www.w3schools.com/w3images/avatar2.png",
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Reza Oktavian",
                          style: bold.copyWith(color: cBlack),
                        ),
                        Text(
                          "Pengguna",
                          style: regular.copyWith(color: cBlack),
                        )
                      ],
                    ),
                    const Spacer(),
                    ElevatedButton(
                      onPressed: () {},
                      child: Text("Tambah"),
                      style: ElevatedButton.styleFrom(
                          backgroundColor: cWhite,
                          foregroundColor: cYellowDark),
                    )
                    // IconButton(
                    //     icon: const Icon(Icons.create),
                    //     onPressed: () {
                    //       Get.to(const MyApp());
                    //     }),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: TextField(
                  controller: pController.searchController.value,
                  decoration: InputDecoration(
                      hintText: "Search",
                      suffixIcon: IconButton(
                          icon: const Icon(Icons.clear),
                          onPressed: () {
                            pController.searchController.value.clear();
                          }),
                      prefixIcon: IconButton(
                          icon: const Icon(Icons.search), onPressed: () {}),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20))),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Text(
                  "Daftar Produk",
                  textAlign: TextAlign.left,
                  style: bold.copyWith(color: cBlack, fontSize: 20),
                ),
              ),
              SizedBox(height: 10),
              Obx(() => GridView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: pController.name.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 8.0,
                      mainAxisSpacing: 8.0,
                      mainAxisExtent: 180),
                  itemBuilder: (context, index) {
                    return ProductCardComponent(
                        image: pController.image[index],
                        name: pController.name[index],
                        price: pController.price[index]);
                  })),
            ],
          ),
        ),
      ),
      bottomNavigationBar: CurvedNavigationBar(
        height: 70,
        index: 0,
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