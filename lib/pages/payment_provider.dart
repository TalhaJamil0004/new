import 'package:flutter/foundation.dart';

enum PaymentMethod { COD, Online }

class PaymentProvider extends ChangeNotifier {
  PaymentMethod? _selectedPaymentMethod;
  PaymentMethod? get selectedPaymentMethod => _selectedPaymentMethod;

  void selectPaymentMethod(PaymentMethod method) {
    _selectedPaymentMethod = method;
    notifyListeners();
  }
}
