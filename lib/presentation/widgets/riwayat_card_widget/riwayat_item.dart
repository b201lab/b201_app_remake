import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:b201_app/app/utils/payment_utils.dart';

class RiwayatItem extends StatelessWidget {
  const RiwayatItem(
      {Key? key,
      required this.nominal,
      required this.date,
      required this.isConfirmed})
      : super(key: key);
  final int nominal;
  final String date;
  final bool isConfirmed;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 20, right: 20),
      height: 50,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                PaymentUtils.convertToIDR(nominal, 0),
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                'Tanggal Pembayaran $date',
                style: GoogleFonts.poppins(
                  fontSize: 10,
                  color: const Color.fromARGB(255, 198, 198, 198),
                  fontWeight: FontWeight.w500,
                ),
              )
            ],
          ),
          isConfirmed
              ? Image.asset(
                  'assets/images/confirmed.png',
                )
              : Image.asset(
                  'assets/images/load.png',
                )
        ],
      ),
    );
  }
}
