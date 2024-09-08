import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:veterinary_application/components/routes.dart';
import 'package:veterinary_application/models/user.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:veterinary_application/components/mybutton.dart';
import 'package:veterinary_application/components/mysquaretile.dart';
import 'package:veterinary_application/components/mytextfield.dart';
import 'package:veterinary_application/models/auth_services.dart';

class RegisterPage extends StatefulWidget {
  final Function()? onTap;
  const RegisterPage({super.key, required this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final emailController = TextEditingController();
  final nameController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  bool isLoading = false;

  @override
  void dispose() {
    emailController.dispose();
    nameController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    isLoading = false;
    super.dispose();
  }

  void signUserUp() async {
    setState(() {
      isLoading = true;
    });

    try {
      if (passwordController.text == confirmPasswordController.text) {
        await saveData(emailController.text);
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: emailController.text, password: passwordController.text);
        // saving user data to firestore
        final user = UserModel(
            name: nameController.text,
            email: emailController.text,
            cardNumber: "",
            money: 15000, // initial hardcoded money
            password: passwordController.text);
        await FirebaseFirestore.instance
            .collection("users")
            .doc(user.email)
            .set(user.toJson());
        setState(() {
          isLoading = false;
        });
      Navigator.pushNamed(context, MyRoutes.homeroute);
      } else {
        showErrorMessage("Password doesn't match!");
        setState(() {
          isLoading = false;
        });
      }
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
                      // const Icon(Icons.person_add_rounded, size: 100)
                      //     .iconColor(context.primaryColor),
                    Image.asset(
                               "assets/images/signup.png",
                                  height: 250,
                                  width: 400,
                                  fit: BoxFit.contain,
                                ),
                  
                      const SizedBox(height: 30),
                      "Creating a new account"
                          .text
                          .color(context.primaryColor)
                          .size(16)
                          .bold
                          .make(),

                      const SizedBox(height: 25),
                      MyTextField(
                        controller: nameController,
                        hintText: 'name',
                        obscureText: false,
                      ),
                      const SizedBox(height: 10),
                      MyTextField(
                        controller: emailController,
                        hintText: 'email',
                        obscureText: false,
                      ),
                      const SizedBox(height: 10),
                      MyTextField(
                        controller: passwordController,
                        hintText: 'password',
                        obscureText: true,
                      ),
                      const SizedBox(height: 10),
                      MyTextField(
                        controller: confirmPasswordController,
                        hintText: 'confirm password',
                        obscureText: true,
                      ),
                      const SizedBox(height: 10),
                      const SizedBox(height: 20),
                      MyButton(
                        onTap: signUserUp,
                        text: "Sign up",
                      ),
                      // const SizedBox(height: 20),
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
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.center,
                      //   children: [
                      //     MySquareTile(
                      //       imagePath: "assets/images/google.png",
                      //       onTap: () => AuthServices().signInWithGoogle(),
                      //     ),
                        
                      //   ],
                      // ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Already have an account?",
                              style: TextStyle(
                                  color: context.primaryColor, fontSize: 14)),
                          const SizedBox(width: 5),
                          GestureDetector(
                            onTap: widget.onTap,
                            child: Text(
                              "Login now",
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
