import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PilihBayarItem extends StatelessWidget {
  const PilihBayarItem(
      {Key? key,
      required this.month,
      required this.year,
      this.isPayed = false,
      this.isSelected = false})
      : super(key: key);
  final int year;
  final int month;
  final bool isPayed;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          color: isPayed
              ? const Color.fromARGB(255, 198, 198, 198)
              : isSelected
                  ? const Color.fromARGB(255, 237, 29, 36)
                  : Colors.white,
          boxShadow: const [
            BoxShadow(
                color: Color.fromARGB(10, 0, 0, 0),
                offset: Offset(0, 0),
                spreadRadius: 10,
                blurRadius: 90),
          ]),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(15),
            child: Text(
              '${monthFormatter(month)}\n$year',
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                fontSize: 18,
                color: isSelected ? Colors.white : Colors.black,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

String monthFormatter(int month) {
  List<String> name = [
    'JAN',
    'FEB',
    'MAR',
    'APR',
    'MEI',
    'JUN',
    'JUL',
    'AGT',
    'SEP',
    'OKT',
    'NOV',
    'DES'
  ];

  return name[month - 1];
}
