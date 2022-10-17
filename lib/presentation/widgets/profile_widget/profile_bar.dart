import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileBar extends StatelessWidget {
  const ProfileBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(double.infinity),
          child: Image.network(
            'https://www.firstbenefits.org/wp-content/uploads/2017/10/placeholder-1024x1024.png',
            width: 80,
            height: 80,
          ),
        ),
        Container(
          padding: const EdgeInsets.only(left: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'eaTai',
                style: Get.textTheme.caption
                    ?.copyWith(fontSize: 14, fontWeight: FontWeight.w300),
              ),
              Text(
                'Arrijal Istighfarotudzdzilal',
                style: Get.textTheme.subtitle1
                    ?.copyWith(fontSize: 14, fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
