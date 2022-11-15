import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

class ChecklistWidget extends StatelessWidget {
  final bool defaultVal;
  const ChecklistWidget({super.key, required this.defaultVal});

  @override
  Widget build(BuildContext context) {
    Rx<bool> isChecked = defaultVal.obs;

    Color getColor(Set<MaterialState> states) {
      const Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.pressed,
        MaterialState.hovered,
      };
      if (states.any(interactiveStates.contains)) {
        return Colors.black;
      }
      return Colors.red;
    }

    return Obx(
      (() => Checkbox(
            shape: CircleBorder(),
            checkColor: Colors.white,
            fillColor: MaterialStateProperty.resolveWith(getColor),
            value: isChecked.value,
            onChanged: (bool? value) {
              isChecked.value = !isChecked.value;
            },
          )),
    );
  }
}
