import 'package:veterinary_application/models/catalog.dart';

class CartModel {
  static final cartModel = CartModel._internal();
  CartModel._internal();
  factory CartModel() => cartModel;
  //catalog field
  late CatalogModel _catalog;
  //collection of ids- store id of each items
  final List<int> _itemIds = [];
  //get catalog
  CatalogModel get catalog => _catalog;
  set Catalog(CatalogModel newCatalog) {
    _catalog = newCatalog;
  }

  //get items in the cart
  List<Item> get items => _itemIds.map((id) => catalog.getById(id)).toList();
  //get total price
  num get TotalPrice =>
      items.fold(0, (total, current) => total + current.price);
  //add item
  void add(Item item) {
    _itemIds.add(item.id);
  }

  //remove item
  void remove(Item item, List<int> list) {
    _itemIds.remove(item.id);
  }

  void emptyCart() {
    _itemIds.clear();
  }
}
