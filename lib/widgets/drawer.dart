import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:veterinary_application/components/routes.dart';
import 'package:veterinary_application/models/user.dart';

class MyDrawer extends StatefulWidget {
  final String email;
  MyDrawer({super.key, required this.email});

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  UserModel user = UserModel();
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getUserData();
    });
  }

  void getUserData() async {
    setState(() {
      isLoading = true;
    });

    try {
      debugPrint("Email in drawer ----->>>> ${widget.email}");
      final document = await FirebaseFirestore.instance
          .collection("users")
          .doc(widget.email)
          .get();

      if (document.exists) {
        debugPrint("User:------->>>>> ${document.data()}");
        user = UserModel.fromJson(document.data()!);
      } else {
        debugPrint("No user data found for this email.");
      }
    } catch (e) {
      debugPrint("Error fetching user data: $e");
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error fetching user data: $e')));
    }

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Column(
                children: [
                  DrawerHeader(
                    padding: EdgeInsets.zero,
                    child: UserAccountsDrawerHeader(
                      margin: const EdgeInsets.all(0),
                      accountName: (user.name ?? "NIL")
                          .text
                          .xl
                          .color(context.primaryColor)
                          .make(),
                      accountEmail: (user.email ?? "NIL")
                          .text
                          .medium
                          .color(context.primaryColor)
                          .make(),
                      currentAccountPicture: const CircleAvatar(
                        backgroundImage:
                            AssetImage("assets/images/mainimg.png"),
                      ),
                      decoration: BoxDecoration(color: context.canvasColor),
                    ),
                  ),
                  ListTile(
                    onTap: () =>
                        Navigator.pushNamed(context, MyRoutes.homeroute),
                    leading: Icon(
                      CupertinoIcons.home,
                      color: context.primaryColor,
                    ),
                    title: Text(
                      "Home",
                      style: TextStyle(color: context.primaryColor),
                    ),
                  ),
                  ListTile(
                    onTap: () =>
                        Navigator.pushNamed(context, MyRoutes.aboutusroute),
                    leading: Icon(
                      CupertinoIcons.question_circle_fill,
                      color: context.primaryColor,
                    ),
                    title: Text(
                      "About Us",
                      style: TextStyle(color: context.primaryColor),
                    ),
                  ),
                  ListTile(
                    onTap: () =>
                        Navigator.pushNamed(context, MyRoutes.servicesroute),
                    leading: Icon(
                      CupertinoIcons.gear_solid,
                      color: context.primaryColor,
                    ),
                    title: Text(
                      "Services",
                      style: TextStyle(color: context.primaryColor),
                    ),
                  ),
                  ListTile(
                    onTap: () =>
                        Navigator.pushNamed(context, MyRoutes.mailroute),
                    leading: Icon(
                      CupertinoIcons.mail_solid,
                      color: context.primaryColor,
                    ),
                    title: Text(
                      "Appointment",
                      style: TextStyle(color: context.primaryColor),
                    ),
                  ),
                  ListTile(
                    onTap: () =>
                        Navigator.pushNamed(context, MyRoutes.sellroute),
                    leading: Icon(
                      CupertinoIcons.paw_solid,
                      color: context.primaryColor,
                    ),
                    title: Text(
                      "Selling Pets",
                      style: TextStyle(color: context.primaryColor),
                    ),
                  ),
                  ListTile(
                    onTap: () =>
                        Navigator.pushNamed(context, MyRoutes.shoproute),
                    leading: Icon(
                      CupertinoIcons.cart_fill_badge_plus,
                      color: context.primaryColor,
                    ),
                    title: Text(
                      "Shop",
                      style: TextStyle(color: context.primaryColor),
                    ),
                  ),
                  ListTile(
                    onTap: () =>
                        Navigator.pushNamed(context, MyRoutes.cartroute),
                    leading: Icon(
                      CupertinoIcons.cart_fill,
                      color: context.primaryColor,
                    ),
                    title: Text(
                      "Cart",
                      style: TextStyle(color: context.primaryColor),
                    ),
                  ),
                  ListTile(
                    onTap: () async {
                      try {
                        SharedPreferences prefs =
                            await SharedPreferences.getInstance();
                        await prefs.remove('userEmail');
                        await FirebaseAuth.instance.signOut();
                        Navigator.pushReplacementNamed(
                            context, MyRoutes.authroute);
                      } catch (e) {
                        debugPrint(e.toString());
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text('Error signing out: $e')));
                      }
                    },
                    leading: Icon(
                      Icons.logout,
                      color: context.primaryColor,
                    ),
                    title: Text(
                      "Sign Out",
                      style: TextStyle(color: context.primaryColor),
                    ),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                ],
              ),
            ),
    );
  }
}
