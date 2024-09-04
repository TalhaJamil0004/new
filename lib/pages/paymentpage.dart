import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:veterinary_application/components/mybutton.dart';
import 'package:veterinary_application/pages/payment_detail.dart';
import 'package:veterinary_application/pages/payment_provider.dart';

class PaymentPage extends StatelessWidget {
  const PaymentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: "Payment Page".text.xl2.bold.color(context.primaryColor).make(),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(CupertinoIcons.money_dollar)
                .iconColor(context.primaryColor)
                .iconSize(200),
            const SizedBox(height: 80),
            ElevatedButton(
              onPressed: () => _showPaymentOptions(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: context.primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6), // Rounded corners
                ),
              ),
              child: 'Choose Payment Method'
                  .text
                  .bold
                  .color(context.canvasColor)
                  .make(),
            ),
            const SizedBox(height: 20),
            const PaymentDetails(),
          ],
        ),
      ),
    ).color(context.canvasColor);
  }

  void _showPaymentOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
      ),
      builder: (context) {
        return Container(
          decoration: BoxDecoration(
            color: Theme.of(context).canvasColor,
            borderRadius:
                const BorderRadius.vertical(top: Radius.circular(25.0)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: Text(
                  'Cash on Delivery',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                onTap: () {
                  Provider.of<PaymentProvider>(context, listen: false)
                      .selectPaymentMethod(PaymentMethod.COD);
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: Text(
                  'Online Payment',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                onTap: () {
                  Provider.of<PaymentProvider>(context, listen: false)
                      .selectPaymentMethod(PaymentMethod.Online);
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
