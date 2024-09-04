import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.canvasColor,
      appBar: AppBar(
        title: "Profile".text.xl2.bold.color(context.primaryColor).make(),
        backgroundColor: Colors.transparent,
      ),
    );
  }
}
