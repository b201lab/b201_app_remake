import 'package:b201_app/presentation/widgets/pilih_bayar_widget/pilih_bayar_item.dart';
import 'package:b201_app/presentation/widgets/pilih_bayar_widget/pilih_bayar_model.dart';
import 'package:flutter/material.dart';

class PilihBayarWidget extends StatefulWidget {
  PilihBayarWidget({Key? key}) : super(key: key);
  final List<PilihBayarModel> model = modelBayar;
  @override
  _PilihBayarWidgetState createState() => _PilihBayarWidgetState();
}

class _PilihBayarWidgetState extends State<PilihBayarWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(30.0),
      child: GridView.count(
        childAspectRatio: 1, //ubah besar grid
        primary: false,
        shrinkWrap: true,
        crossAxisCount: 4,
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
        padding: const EdgeInsets.all(5),
        children: widget.model.map((entries) {
          return InkWell(
            onTap: () {
              setState(() {
                entries.isSelected = !entries.isSelected;
              });
            },
            child: PilihBayarItem(
              month: entries.month,
              year: entries.year,
              isPayed: entries.isPayed,
              isSelected: entries.isSelected,
            ),
          );
        }).toList(),
      ),
    );
  }
}
