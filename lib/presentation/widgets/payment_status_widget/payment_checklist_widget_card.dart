import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'payment_checklist_model.dart';
import 'payment_checklist_widget.dart';

class PaymentCheckbox extends StatefulWidget {
  const PaymentCheckbox({super.key});
  @override
  State<PaymentCheckbox> createState() => _PaymentCheckbox();
}

class _PaymentCheckbox extends State<PaymentCheckbox> {
  bool isChecked = false;
  List<ChecklistModel> dataModel = [
    ChecklistModel(date: "JAN"),
    ChecklistModel(date: "FEB"),
    ChecklistModel(date: "MAR"),
    ChecklistModel(date: "APR"),
    ChecklistModel(date: "MEI"),
    ChecklistModel(date: "JUN"),
    ChecklistModel(date: "JUL"),
    ChecklistModel(date: "AGT"),
    ChecklistModel(date: "SEP"),
    ChecklistModel(date: "OKT"),
    ChecklistModel(date: "NOV"),
    ChecklistModel(date: "DES"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        margin: EdgeInsets.all(0),
        child: Card(
          child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 6,
                crossAxisSpacing: 0,
              ),
              itemCount: 12,
              shrinkWrap: true,
              itemBuilder: (BuildContext context, index) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      child: Column(
                        children: [
                          ChecklistWidget(
                              defaultVal: dataModel[index].isChecked),
                          Text(
                            dataModel[index].date,
                            style: TextStyle(
                              height: -0.01,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              }),
        ),
      ),
    );
  }
}
