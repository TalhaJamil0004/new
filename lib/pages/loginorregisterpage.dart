import 'package:flutter/material.dart';
import 'package:veterinary_application/pages/loginpage.dart';
import 'package:veterinary_application/pages/registerpage.dart';

class LoginOrRegisterPage extends StatefulWidget {
  const LoginOrRegisterPage({super.key});

  @override
  State<LoginOrRegisterPage> createState() => _LoginOrRegisterPageState();
}

class _LoginOrRegisterPageState extends State<LoginOrRegisterPage> {

  bool showLoginPage = true;

  void togglePages(){
    setState(() {
      showLoginPage = !showLoginPage;
    });
  }
 @override
  Widget build(BuildContext context) {
   if (showLoginPage)
   {
    return LoginPage(onTap: togglePages);
   }
   else
   {
    return RegisterPage(
    onTap: togglePages,
   );
   }
  }
}