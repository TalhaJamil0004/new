import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class MyButton extends StatelessWidget {
  final void Function()? onTap;
  final String text;
  const MyButton({super.key, required this.onTap, required this.text});

  @override
  Widget build(BuildContext context) {
    return  MouseRegion(
      cursor: SystemMouseCursors.click, 
      child:GestureDetector(
      onTap: onTap,
      child: Container(
          padding: EdgeInsets.all(10),
          margin: EdgeInsets.symmetric(horizontal: 25),
          decoration: BoxDecoration(
              color: context.primaryColor,
              borderRadius: BorderRadius.circular(8)),
          child: Center(
            child: Text(
              text,
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16),
            ),
          )),
    ));
  }
}
