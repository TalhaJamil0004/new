import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:veterinary_application/components/routes.dart';
import 'package:veterinary_application/pages/home_page.dart';
import 'package:veterinary_application/pages/payment_provider.dart';
import 'package:veterinary_application/widgets/cardInputFormatter.dart';

class PaymentDetails extends StatelessWidget {
  const PaymentDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<PaymentProvider>(
      builder: (context, provider, child) {
        if (provider.selectedPaymentMethod == PaymentMethod.COD) {
          return const CODDetails();
        } else if (provider.selectedPaymentMethod == PaymentMethod.Online) {
          return const OnlinePaymentDetails();
        } else {
          return Center(
            child: 'Please select a payment method.'
                .text
                .color(context.primaryColor)
                .make(),
          );
        }
      },
    ).color(context.canvasColor);
  }
}

class CODDetails extends StatelessWidget {
  const CODDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          'Cash on Delivery'.text.color(context.primaryColor).make(),
          const SizedBox(height: 20),
          'Delivery Charges: 200Rs'.text.color(context.primaryColor).make(),
          const SizedBox(height: 40),
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            style: ElevatedButton.styleFrom(
              backgroundColor: context.primaryColor,
            ),
            child: 'Confirm'.text.bold.color(context.canvasColor).make(),
          ),
        ],
      ),
    );
  }
}

class OnlinePaymentDetails extends StatefulWidget {
  const OnlinePaymentDetails({super.key});

  @override
  State<OnlinePaymentDetails> createState() => _OnlinePaymentDetailsState();
}

class _OnlinePaymentDetailsState extends State<OnlinePaymentDetails> {
  final _key = GlobalKey<FormState>();
  final paymentController = TextEditingController();
  bool isLoading = true;

  @override
  void initState() {
    getInitialCard();
    super.initState();
  }

  Future getInitialCard() async {
    final prefs = await SharedPreferences.getInstance();
    final userEmail = prefs.getString("userEmail") ?? "";
    final user = await FirebaseFirestore.instance
        .collection("users")
        .doc(userEmail)
        .get();
    final userData = user.data() ?? {};
    paymentController.text = userData['cardNumber'] ?? "";
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _key,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            'Online Payment'.text.color(context.primaryColor).make(),
            const SizedBox(height: 20),
            if (isLoading) ...[
              const Center(
                child: CircularProgressIndicator(),
              ),
            ] else ...[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: TextFormField(
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(16),
                    CardInputFormatter(),
                  ],
                  controller: paymentController,
                  validator: (val) {
                    val = val!.replaceAll(' ', '');
                    if (val.isEmpty) {
                      return "Enter card number!";
                    } else if (val.length < 16) {
                      return "Please enter 16 digits number!!";
                    } else {
                      return null;
                    }
                  },
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    icon: const Icon(Icons.payment),
                    labelText: 'Card number',
                    border: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.red),
                        borderRadius: BorderRadius.circular(35)),
                    focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black)),
                  ),
                ),
              ),
              const SizedBox(height: 40),
              ElevatedButton(
                onPressed: () async {
                  if (_key.currentState!.validate()) {
                    try {
                      final prefs = await SharedPreferences.getInstance();
                      final userEmail = prefs.getString("userEmail") ?? "";
                      await FirebaseFirestore.instance
                          .collection("users")
                          .doc(userEmail)
                          .update({"cardNumber": paymentController.text});
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          backgroundColor: Colors.green,
                          content:
                              "Card saved Successfully".text.white.make()));
                      Navigator.pushNamed(context, MyRoutes.homeroute);
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          backgroundColor: Colors.red,
                          content: e.toString().text.make()));
                    }
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: context.primaryColor,
                ),
                child:
                    'Confirm'.text.semiBold.color(context.canvasColor).make(),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
