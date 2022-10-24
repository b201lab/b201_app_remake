import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
class PasswordTextField extends StatelessWidget {
  const PasswordTextField({super.key});
  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              height: 60.0,
              width: double.infinity-48.0,
              decoration: BoxDecoration(
                color: const Color(0xffFAFAFA),
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: Row(
                children: const [
                  SizedBox(
                    width: 20.0,
                  ),
                  Icon(FeatherIcons.lock, color: Color(0xffC6C6C6),),
                  SizedBox(
                    width: 10.0,
                  ),
                  Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Password",
                            hintStyle: TextStyle(
                                color: Color(0xffC6C6C6)
                            )
                        ),
                      ))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}