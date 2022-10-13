import 'package:b201_app/presentation/widgets/riwayat_card_widget/riwayat_item.dart';
import 'package:b201_app/presentation/widgets/riwayat_card_widget/riwayat_model.dart';
import 'package:flutter/material.dart';

class RiwayatWidget extends StatelessWidget {
  final List<RiwayatModel> entries;

  const RiwayatWidget({Key? key, required this.entries}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: entries.length * 70,
      margin: EdgeInsets.only(left: 20, right: 20),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          color: Colors.white,
          boxShadow: const [
            BoxShadow(
                color: Color.fromARGB(10, 0, 0, 0),
                offset: Offset(0, 0),
                spreadRadius: 10,
                blurRadius: 90),
          ]),
      child: ListView.separated(
        padding: const EdgeInsets.all(8),
        itemCount: entries.length,
        itemBuilder: (BuildContext context, int index) {
          return RiwayatItem(
              nominal: entries[index].nominal,
              date: entries[index].date,
              isConfirmed: entries[index].isConfirmed);
        },
        separatorBuilder: (BuildContext context, int index) => const Divider(),
      ),
    );
  }
}
