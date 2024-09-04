class ProductModel {
  int? id;
  String? image;
  String? name;
  String? price;
  String? detail;
  String? description;

  ProductModel(
      {this.image,
      this.name,
      this.id,
      this.price,
      this.detail,
      this.description});

  ProductModel.fromJson(Map<String, dynamic> json) {
    image = json['image'];
    name = json['name'];
    id = json['id'];
    price = json['price'];
    detail = json['detail'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['image'] = image;
    data['name'] = name;
    data['id'] = id;
    data['price'] = price;
    data['detail'] = detail;
    data['description'] = description;
    return data;
  }
}
