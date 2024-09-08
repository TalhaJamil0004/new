import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:veterinary_application/components/mybutton.dart';
import 'package:veterinary_application/components/mysquaretile.dart';
import 'package:veterinary_application/components/mytextfield.dart';
import 'package:veterinary_application/components/routes.dart';
import 'package:veterinary_application/models/auth_services.dart';

class LoginPage extends StatefulWidget {
  final Function()? onTap;
  const LoginPage({super.key, required this.onTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool isLoading = false;

  void signUserIn() async {
    setState(() {
      isLoading = true;
    });

    try {
      await saveData(emailController.text);
      await login();

      debugPrint("Email saved in login: ${emailController.text}");
      setState(() {
        isLoading = false;
      });
     Navigator.pushNamed(context, MyRoutes.homeroute);
    } on FirebaseAuthException catch (e) {
      setState(() {
        isLoading = false;
      });
      showErrorMessage(e.message ?? "Authentication error");
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      showErrorMessage(e.toString());
    }
  }

  Future<void> login() async {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text, password: passwordController.text);
  }

  Future<void> saveData(String email) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    debugPrint("Email to be saved ----->>> $email");
    await prefs.setString('userEmail', email);
  }

  void showErrorMessage(String message) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(message),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('OK'),
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: isLoading
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 50),
                      // const Icon(
                      //   Icons.lock,
                      //   size: 100,
                      // ).iconColor(context.primaryColor),
                    
                     Image.asset(
                                  "assets/images/login.png",
                                  height: 250,
                                  width: 400,
                                  fit: BoxFit.contain,
                                ),
    
                      const SizedBox(height: 30),
                      "Welcome to login page"
                          .text
                          .color(context.primaryColor)
                          .size(16)
                          .bold
                          .make(),

                      const SizedBox(height: 25),
                      MyTextField(
                        controller: emailController,
                        hintText: 'username',
                        obscureText: false,
                      ),
                      const SizedBox(height: 10),
                      MyTextField(
                        controller: passwordController,
                        hintText: 'password',
                        obscureText: true,
                      ),
                      const SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text("forgot password?",
                                  style:
                                      TextStyle(color: context.primaryColor)),
                            ]),
                      ),
                      const SizedBox(height: 20),
                      MyButton(
                        onTap: signUserIn,
                        text: 'Sign in',
                      ),
                      const SizedBox(height: 20),
                      // Padding(
                      //   padding: const EdgeInsets.symmetric(horizontal: 25),
                      //   child: Row(
                      //     children: [
                      //       Expanded(
                      //           child: Divider(
                      //         color: Colors.grey[400],
                      //         thickness: 0.5,
                      //       )),
                      //       Padding(
                      //           padding:
                      //               const EdgeInsets.symmetric(horizontal: 10),
                      //           child: Text(
                      //             "or continue with",
                      //             style: TextStyle(color: context.primaryColor),
                      //           )),
                      //       Expanded(
                      //           child: Divider(
                      //         color: Colors.grey[400],
                      //         thickness: 0.5,
                      //       )),
                      //     ],
                      //   ),
                      // ),
                      // const SizedBox(height: 20),
//                     Row(
//   mainAxisAlignment: MainAxisAlignment.center,
//   children: [
//     MySquareTile(
//       imagePath: "assets/images/google.png",
//       onTap: () async {
//         try {
//           await AuthServices().signInWithGoogle();
//         } catch (e) {
//           // Handle the error, for example, by showing a dialog or printing the error
//           print('Error during Google sign-in: $e');
//           // Optionally, show a dialog or a snackbar to inform the user
//           showDialog(
//             context: context,
//             builder: (context) => AlertDialog(
//               title: Text('Error'),
//               content: Text('An error occurred during Google sign-in: $e'),
//               actions: [
//                 TextButton(
//                   onPressed: () => Navigator.of(context).pop(),
//                   child: Text('OK'),
//                 ),
//               ],
//             ),
//           );
//         }
//       },
//     ),
//   ],
// ),

                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Not a member?",
                              style: TextStyle(
                                  color: context.primaryColor, fontSize: 14)),
                          const SizedBox(width: 5),
                          GestureDetector(
                            onTap: widget.onTap,
                            child: Text(
                              "Register now",
                              style: TextStyle(
                                  color: Colors.blue[600],
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}
