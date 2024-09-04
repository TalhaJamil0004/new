import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:veterinary_application/components/routes.dart';
import 'package:veterinary_application/models/cart.dart';
import 'package:veterinary_application/models/purchaseModel.dart';
import 'package:veterinary_application/pages/payment_provider.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: "Cart".text.xl2.bold.color(context.primaryColor).make(),
      ),
      body: Column(
        children: [
          const CartList().p32().expand(),
        ],
      ),
    );
  }
}

class CartList extends StatefulWidget {
  const CartList({super.key});

  @override
  State<CartList> createState() => _CartListState();
}

class _CartListState extends State<CartList> {
  final cart = CartModel();

  @override
  Widget build(BuildContext context) {
    return cart.items.isEmpty
        ? (Column(
            children: [
              "Nothing to show".text.xl3.makeCentered(),
              const Divider(),
              SizedBox(
                height: 200,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    "${cart.TotalPrice}"
                        .text
                        .xl5
                        // .color(context.theme.primaryColor)
                        .make(),
                     ElevatedButton(
                            onPressed: () {
                            Navigator.pushNamed(context, MyRoutes.paymentroute);
                            },
                            style: ButtonStyle(
                                backgroundColor: WidgetStateProperty.all(
                                    context.theme.primaryColor)),
                            child: "Payment Method".text.white.make())
                        .w20(context),
                    
                    ElevatedButton(
                            onPressed: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      backgroundColor: Colors.red,
                                      content:
                                          "Cart is Empty!".text.white.make()));
                            },
                            style: ButtonStyle(
                                backgroundColor: WidgetStateProperty.all(
                                    context.theme.primaryColor)),
                            child: "Buy".text.white.make())
                        .w32(context)
                  ],
                ),
              )
            ],
          ))
        : (Column(
            children: [
              Expanded(
                child: ListView.builder(
                    itemCount: cart.items.length,
                    itemBuilder: (context, index) => ListTile(
                        leading: const Icon(Icons.done),
                        trailing: IconButton(
                          icon: const Icon(Icons.remove_circle_outline),
                          onPressed: () {
                            setState(() {
                              cart.remove(cart.items[index], []);
                            });
                          },
                        ),
                        title: Text(cart.items[index].name))),
              ),
              const Divider(),
              SizedBox(
                height: 200,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    "${cart.TotalPrice}"
                        .text
                        .xl5
                        // .color(context.theme.primaryColor)
                        .make(),
                    ElevatedButton(
                            onPressed: () {
                            Navigator.pushNamed(context, MyRoutes.paymentroute);
                            },
                            style: ButtonStyle(
                                backgroundColor: WidgetStateProperty.all(
                                    context.theme.primaryColor)),
                            child: "Payment Method".text.white.make())
                        .w20(context),
                    Consumer<PaymentProvider>(
                        builder: (context, provider, child) {
                      return ElevatedButton(
                              onPressed: () async {
                                try {
                                  SharedPreferences prefs =
                                      await SharedPreferences.getInstance();
                                  String? userEmail =
                                      prefs.getString("userEmail") ?? "";

                                  if (provider.selectedPaymentMethod ==
                                      PaymentMethod.Online) {
                                    await onlinePurchase(userEmail, context);
                                  } else if (provider.selectedPaymentMethod ==
                                      PaymentMethod.COD) {
                                    await cashOnDeliveryPurchase(
                                        userEmail, context);
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                            backgroundColor: Colors.red,
                                            content:
                                                "Please select payment method!"
                                                    .text
                                                    .make()));
                                  }
                                } catch (e) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          backgroundColor: Colors.red,
                                          content: e.toString().text.make()));
                                }
                              },
                              style: ButtonStyle(
                                  backgroundColor: WidgetStateProperty.all(
                                      context.theme.primaryColor)),
                              child: "Buy".text.white.make())
                          .w20(context);
                    })
                  ],
                ),
              )
            ],
          ));
  }

  Future onlinePurchase(String userEmail, BuildContext context) async {
    String cardNumber = "";
    final userSnapshot = await FirebaseFirestore.instance
        .collection("users")
        .doc(userEmail)
        .get();
    final user = userSnapshot.data() ?? {};
    cardNumber = user['cardNumber'] ?? "";
    int money = user['money'] ?? 0;

    if (cardNumber.isEmpty || cardNumber == "") {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.red,
          content: "Please enter card number in payment screen!".text.make()));
    } else if (money < cart.TotalPrice.toInt()) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.red,
          content: "Not enough money!".text.make()));
    } else {
      PurchaseModel purchase = PurchaseModel(
          items: cart.items,
          totalPrice: cart.TotalPrice,
          purchasingTime: DateTime.now().toString());

      final userDoc =
          FirebaseFirestore.instance.collection("users").doc(userEmail);
      final purchaseCollection = userDoc.collection("purchases");
      try {
        await FirebaseFirestore.instance.runTransaction((transaction) async {
          transaction.set(purchaseCollection.doc(), purchase.toJson());
          transaction.update(userDoc, {
            "money": money - cart.TotalPrice.toInt(),
          });
        });
        Navigator.pop(context);

        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.green,
            content: "Purchased Successful".text.white.make()));
        setState(() {
          cart.emptyCart();
        });
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.red, content: e.toString().text.make()));
      }
    }
  }

  Future cashOnDeliveryPurchase(String userEmail, BuildContext context) async {
    PurchaseModel purchase = PurchaseModel(
        items: cart.items,
        totalPrice: cart.TotalPrice,
        purchasingTime: DateTime.now().toString());

    final userDoc =
        FirebaseFirestore.instance.collection("users").doc(userEmail);
    final purchaseCollection = userDoc.collection("purchases");
    try {
      await FirebaseFirestore.instance.runTransaction((transaction) async {
        transaction.set(purchaseCollection.doc(), purchase.toJson());
      });
      Navigator.pop(context);

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.green,
          content: "Purchased Successful".text.white.make()));
      setState(() {
        cart.emptyCart();
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.red, content: e.toString().text.make()));
    }
  }
}
