import 'package:flutter/material.dart';

class ProfilePP extends StatelessWidget {
  const ProfilePP({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        const CircleAvatar(
            radius: 60,
            backgroundImage: NetworkImage('https://via.placeholder.com/150')),
        FloatingActionButton.small(
          onPressed: () {},
          backgroundColor: Colors.red,
          child: const Icon(
            Icons.edit,
          ),
        ),
      ],
    );
  }
}
