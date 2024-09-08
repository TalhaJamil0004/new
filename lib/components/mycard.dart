import "package:flutter/material.dart";
import "package:velocity_x/velocity_x.dart";
import 'package:veterinary_application/components/mybutton.dart';

class Mycard extends StatelessWidget {
  final String imgPath;
  final String docName;
  final String docDetail;
  final void Function()? docLink;
  const Mycard(
      {super.key,
      required this.imgPath,
      required this.docName,
      required this.docDetail,
      required this.docLink});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          Image.asset(
            imgPath,
            fit: BoxFit.cover,
            height: 200,
            // width: 200,
            
          ),
          SizedBox(height: 8),
          Text(
            docName,
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: context.primaryColor),
          ),
          SizedBox(height: 4),
          Text(
            docDetail,
            textAlign: TextAlign.center,
            style: TextStyle(color: context.primaryColor),
          ).p16(),
          const SizedBox(height: 20),
          MyButton(
                      onTap: docLink,
                      text: 'Contact Me',
                  ),
           const SizedBox(height: 20),
        ],
      ).color(context.canvasColor),
    ).backgroundColor(context.primaryColor);
  }
}
