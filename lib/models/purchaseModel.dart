import 'package:veterinary_application/models/catalog.dart';

class PurchaseModel {
  List<Item>? items;
  String? purchasingTime;
  num? totalPrice;

  PurchaseModel({this.items, this.purchasingTime, this.totalPrice});

  PurchaseModel.fromJson(Map<String, dynamic> json) {
    if (json['items'] != null) {
      items = <Item>[];
      json['items'].forEach((v) {
        items!.add(v);
      });
    }
    purchasingTime = json['purchasingTime'];
    totalPrice = json['totalPrice'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (items != null) {
      data["items"] = items!.map((v) {
        return {
          "itemId": v.id,
          "itemDescription": v.description,
          "name": v.name,
          "price": v.price,
        };
      }).toList();
    }
    data['purchasingTime'] = purchasingTime;
    data['totalPrice'] = totalPrice;
    return data;
  }
}
