import 'package:flutter/material.dart';

import 'currency_formatter.dart';

class RiwayatItem extends StatelessWidget {
  final int nominal;
  final String date;
  final bool isConfirmed;
  const RiwayatItem(
      {Key? key,
      required this.nominal,
      required this.date,
      required this.isConfirmed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 20, right: 20),
      height: 50,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                CurrencyFormat.convertToIdr(nominal, 0),
                style: TextStyle(
                    fontSize: 18,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w700),
              ),
              Text(
                "Tanggal Pembayaran $date",
                style: TextStyle(
                    fontSize: 10,
                    fontFamily: 'Poppins',
                    color: Color.fromARGB(255, 198, 198, 198)),
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
