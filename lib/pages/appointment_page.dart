import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:veterinary_application/pages/send_email_service.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:veterinary_application/components/mybutton.dart';
import 'package:veterinary_application/components/mytextformfield.dart';

class MailPage extends StatefulWidget {
  const MailPage({super.key});

  @override
  State<MailPage> createState() => _MailPageState();
}

class _MailPageState extends State<MailPage> {
  final _formKey = GlobalKey<FormState>();

  final ownerNameController = TextEditingController();
  final emailController = TextEditingController();
  final petCategoryController = TextEditingController();
  final petTreatementController = TextEditingController();
  final suitableTimeController = TextEditingController();

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.transparent,
            title:
                "Appointment".text.xl2.bold.color(context.primaryColor).make(),
            leading: IconButton(
                icon: Icon(Icons.arrow_back, color: context.primaryColor),
                onPressed: () {
                  Navigator.pop(context);
                })),
                
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
                                Image.asset(
                                  "assets/images/appointment.webp",
                                  height: 250,
                                  width: 400,
                                  fit: BoxFit.contain,
                                ),
                                const SizedBox(
                                  height: 20.0,
                                ),
                                "Welcome to Appointment page"
                                    .text
                                    .xl2
                                    .bold
                                    .color(context.primaryColor)
                                    .make(),
                                const SizedBox(
                                  height: 20.0,
                                ),
                                const Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 40.0, horizontal: 50.0),
                                ),
                                Form(
                                  key: _formKey,
                                  child: Column(
                                    children: [
                                      // ownername
                                      MyTextFormField(
                                        controller: ownerNameController,
                                        hintText: 'Owner Name',
                                        obscureText: false,
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),

                                      MyTextFormField(
                                        controller: emailController,
                                        hintText: 'Email',
                                        obscureText: false,
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      MyTextFormField(
                                        controller: petCategoryController,
                                        hintText: 'Category Of Pet',
                                        obscureText: false,
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      MyTextFormField(
                                        controller: petTreatementController,
                                        hintText: 'Type Of Service',
                                        obscureText: false,
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),

                                      MyTextFormField(
                                        controller: suitableTimeController,
                                        hintText: 'Suitable Time',
                                        obscureText: false,
                                      ),
                                      const SizedBox(
                                        height: 30,
                                      ),

                                      MyButton(
                                        onTap: () async {
                                          if (_formKey.currentState!
                                              .validate()) {
                                            setState(() {
                                              isLoading = true;
                                            });
                                            
                                            Map<String, String> data = {
                                              "ownerName":
                                                  ownerNameController.text,
                                              "email": emailController.text,
                                              "category":
                                                  petCategoryController.text,
                                              "service":
                                                  petTreatementController.text,
                                              "time":
                                                  suitableTimeController.text
                                            };
                                            await FirebaseFirestore.instance
                                                .collection("appointments")
                                                .doc(emailController.text)
                                                .set(data);
                                  const subject = "Appointment Created";
                                  final message =
                                      "Your appointment with our Veternary Doctor is created for ${suitableTimeController.text}. Kindly reach the hospital timely.";
                                      await SendEmailService.sendEmail(
                                      name: ownerNameController.text,
                                      email: emailController.text,
                                      subject: subject,
                                      message: message);
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(SnackBar(
                                                    content:
                                                        "Appointment Scheduled"
                                                            .text
                                                            .make()));
                                            Navigator.pop(context);
                                            setState(() {
                                              isLoading = false;
                                            });
                                          }
                                        },
                                        text: 'Submit',
                                      ),
                                      const SizedBox(height: 80),
             
                                    ],
                                  ),
                                )
                              ])))));
  }
}
