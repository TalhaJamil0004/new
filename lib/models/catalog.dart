class CatalogModel {
  static final catModel = CatalogModel._internal();
  CatalogModel._internal();
  factory CatalogModel() => catModel;
  static List<Item>? items;
  //get items by id
  Item getById(int id) =>
      // ignore: null_closures
      items!.firstWhere((element) => element.id == id, orElse: null);
  //get items by position
  Item getByPosition(position) => items![position];
}

class Item {
  final int id;
  final String name;
  final String description;
  final num price;
  final String detail;
  final String image;

  Item(
      {required this.id,
      required this.name,
      required this.description,
      required this.price,
      required this.detail,
      required this.image});
//decoding (string to map)
  factory Item.fromMap(Map<String, dynamic> map) {
    return Item(
        id: map["id"],
        name: map["name"],
        description: map["description"],
        price: map["price"],
        detail: map["detail"],
        image: map["image"]);
  }
  //encoding (map to string)
  toMap() => {
        "id": id,
        "name": name,
        "description": description,
        "price": price,
        "detail": detail,
        "image": image
      };
}
