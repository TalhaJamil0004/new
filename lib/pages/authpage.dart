import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:veterinary_application/pages/home_page.dart';
import 'package:veterinary_application/pages/loginorregisterpage.dart';


class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //StreamBuilder builds the UI depending on the state of user. 
      body: StreamBuilder<User?>(
        // here the stream is Firebase... basically this stream shows either the user loggedin or loggedout
          stream: FirebaseAuth.instance.authStateChanges(),
          // it builds the state depending on the the stream even change
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return HomePage();
            } else {
              return LoginOrRegisterPage();
            }
          }),
    );
  }
}
