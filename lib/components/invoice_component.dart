import 'package:bakmi_jago_app/resources/color.dart';
import 'package:bakmi_jago_app/resources/font.dart';
import 'package:bakmi_jago_app/utils/dotted_line.dart';
import 'package:bakmi_jago_app/utils/rupiah_utils.dart';
import 'package:flutter/material.dart';

Widget invoiceCard() => Container(
      padding: const EdgeInsets.all(10),
      color: cWhite,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Center(
            child: Text("Bakmi Jago",
                style: bold.copyWith(fontSize: 20, color: cBlack)),
          ),
          const SizedBox(height: 10),
          Center(
            child: Text("Jl. Lawanggada No, Kota Cirebon",
                style: regular.copyWith(fontSize: 15, color: cBlack)),
          ),
          const SizedBox(height: 10),
          Center(
            child: Text("12 Desember 2022 - 22:00:10",
                style: regular.copyWith(fontSize: 15, color: cBlack)),
          ),
          const SizedBox(height: 30),
          Center(
            child: Text("Pesanan",
                style: regular.copyWith(fontSize: 15, color: cBlack)),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Column(
                children: [
                  Text("Bakmi Ayam",
                      style: regular.copyWith(fontSize: 15, color: cBlack)),
                  const SizedBox(height: 3),
                  Text("2 x ${RupiahUtils.beRupiah(25000)}",
                      style: regular.copyWith(fontSize: 15, color: cBlack)),
                ],
              ),
              const Spacer(),
              Text(RupiahUtils.beRupiah(50000),
                  style: regular.copyWith(fontSize: 15, color: cBlack)),
            ],
          ),
          Row(
            children: [
              Column(
                children: [
                  Text("Bakmi Ayam",
                      style: regular.copyWith(fontSize: 15, color: cBlack)),
                  const SizedBox(height: 3),
                  Text("2 x ${RupiahUtils.beRupiah(25000)}",
                      style: regular.copyWith(fontSize: 15, color: cBlack)),
                ],
              ),
              const Spacer(),
              Text(RupiahUtils.beRupiah(50000),
                  style: regular.copyWith(fontSize: 15, color: cBlack)),
            ],
          ),
          Row(
            children: [
              Column(
                children: [
                  Text("Bakmi Ayam",
                      style: regular.copyWith(fontSize: 15, color: cBlack)),
                  const SizedBox(height: 3),
                  Text("2 x ${RupiahUtils.beRupiah(25000)}",
                      style: regular.copyWith(fontSize: 15, color: cBlack)),
                ],
              ),
              const Spacer(),
              Text(RupiahUtils.beRupiah(50000),
                  style: regular.copyWith(fontSize: 15, color: cBlack)),
            ],
          ),
          const SizedBox(height: 15),
          Center(
            child: CustomPaint(painter: DrawDottedhorizontalline()),
          ),
          const SizedBox(height: 15),
          Row(
            children: [
              Text("Total",
                  style: regular.copyWith(fontSize: 15, color: cBlack)),
              const Spacer(),
              Text(RupiahUtils.beRupiah(50000),
                  style: regular.copyWith(fontSize: 15, color: cBlack)),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Text("Bayar",
                  style: regular.copyWith(fontSize: 15, color: cBlack)),
              const Spacer(),
              Text(RupiahUtils.beRupiah(60000),
                  style: regular.copyWith(fontSize: 15, color: cBlack)),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Text("Kembalian",
                  style: regular.copyWith(fontSize: 15, color: cBlack)),
              const Spacer(),
              Text(RupiahUtils.beRupiah(10000),
                  style: regular.copyWith(fontSize: 15, color: cBlack)),
            ],
          ),
          const SizedBox(height: 30),
          Center(
            child: Text("Terima Kasih",
                style: regular.copyWith(fontSize: 15, color: cBlack)),
          ),
        ],
      ),
    );
