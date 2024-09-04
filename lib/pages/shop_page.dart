import 'dart:convert';
import "package:cloud_firestore/cloud_firestore.dart";
import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "package:flutter/services.dart";
import "package:shared_preferences/shared_preferences.dart";
import "package:url_launcher/url_launcher.dart";
import 'package:velocity_x/velocity_x.dart';
import "package:veterinary_application/models/cart.dart";
import "package:veterinary_application/models/catalog.dart";
import "package:veterinary_application/components/routes.dart";
import "package:veterinary_application/widgets/catalog_header.dart";
import "package:veterinary_application/widgets/catalog_list.dart";

class ShopPage extends StatefulWidget {
  const ShopPage({super.key});

  @override
  State<ShopPage> createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage> {
  String selectedCategory = 'Accessories';
  List<String> categories = ['Accessories', 'Pets'];
  bool isLoading = false;
  final CartModel _cart = CartModel();

  @override
  void initState() {
    super.initState();
    loadData();
  }

  loadData() async {
    if (selectedCategory == 'Accessories') {
      setState(() {
        isLoading = true;
      });
      _cart.emptyCart();
      debugPrint("Cart ------>>> ${_cart.items.length}");
      final catalogJson =
          await rootBundle.loadString("assets/files/catalog.json");
      final decodedData = jsonDecode(catalogJson);
      var productsData = decodedData["products"];
      CatalogModel.items = List.from(productsData)
          .map<Item>((item) => Item.fromMap(item))
          .toList();
      debugPrint("Accessories length ----->>>> ${CatalogModel.items?.length}");

      await Future.delayed(const Duration(milliseconds: 500));
      setState(() {
        isLoading = false;
      });
    } else if (selectedCategory == 'Pets') {
      loadDummyPetsData();
    }
    // setState(() {});
  }

  void loadDummyPetsData() async {
    setState(() {
      isLoading = true;
      _cart.emptyCart();
    });
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final email = prefs.getString("userEmail");
    final snapShots =
        await FirebaseFirestore.instance.collection("sellingPet").get();
    debugPrint("snapshots length --------->>>>> ${snapShots.size}");
    if (snapShots.size != 0) {
      final docs = snapShots.docs.where((doc) {
        return doc.get('email') != email;
      }).toList();
      debugPrint("docs length --------->>>>> ${docs.length}");
      CatalogModel.items = docs.map((doc) => Item.fromMap(doc.data())).toList();
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: "Shop".text.xl2.bold.color(context.primaryColor).make(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(context, MyRoutes.cartroute),
        backgroundColor: context.primaryColor,
        child: const Icon(
          CupertinoIcons.cart,
          color: Colors.white,
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: Vx.m24,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CatalogHeader(),
              DropdownButton<String>(
                value: selectedCategory,
                onChanged: (String? newValue) {
                  selectedCategory = newValue!;
                  loadData();
                },
                items:
                    categories.map<DropdownMenuItem<String>>((String category) {
                  return DropdownMenuItem<String>(
                    value: category,
                    child: Text(category),
                  );
                }).toList(),
              ),
              if (isLoading) ...[
                const CircularProgressIndicator().centered().expand(),
              ] else if (CatalogModel.items != null &&
                  CatalogModel.items!.isNotEmpty) ...[
                const CatalogList().py16().expand()
              ] else
                const Center(child: Text("Nothing to show!")).py16().expand(),
            
             
            ],
          ),
        ),
      ),
    );
  }
}
