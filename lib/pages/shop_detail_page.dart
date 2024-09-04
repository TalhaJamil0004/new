// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:veterinary_application/models/cart.dart';
import 'package:veterinary_application/models/catalog.dart';

class ShopDetailPage extends StatelessWidget {
  const ShopDetailPage({
    Key? key,
    required this.catalog,
  })  : assert(catalog != null),
        super(key: key);
  final Item catalog;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: context.primaryColor,
        bottomNavigationBar: Container(
          color: context.canvasColor,
          child: ButtonBar(
            alignment: MainAxisAlignment.spaceBetween,
            buttonPadding: EdgeInsets.zero,
            children: [
              "Rs ${catalog.price}".text.color(Colors.red[800]).bold.xl4.make(),
              _AddToCart(Catalog: catalog),
         
            ],
          ).p32(),
        ),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          iconTheme: IconThemeData(color: context.canvasColor),
        ),
        body: SafeArea(
          bottom: false,
          child: Column(
            children: [
              Hero(
                      tag: Key(catalog.id.toString()),
                      child: Image.network(catalog.image))
                  .h32(context),
              Expanded(
                  child: VxArc(
                height: 30.0,
                arcType: VxArcType.convey,
                edge: VxEdge.top,
                child: Container(
                  width: context.screenWidth,
                  color: context.canvasColor,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        catalog.name.text.xl4.bold
                            .color(context.primaryColor)
                            .make(),
                        catalog.description.text.xl
                            .textStyle(context.captionStyle)
                            .make(),
                        10.heightBox,
                        catalog.detail.text.lg
                            .textStyle(context.captionStyle)
                            .make()
                            .p12()
                      ],
                    ).py64(),
                  ),
                ),
              ))
            ],
          ),
        ));
  }
}

class _AddToCart extends StatefulWidget {
  final Item Catalog;
  const _AddToCart({
    Key? key,
    required this.Catalog,
  }) : super(key: key);

  @override
  State<_AddToCart> createState() => _AddToCartState();
}

class _AddToCartState extends State<_AddToCart> {
  final _cart = CartModel();
  @override
  Widget build(BuildContext context) {
    bool isInCart = _cart.items.contains(widget.Catalog) ?? false;
    return ElevatedButton(
        onPressed: () {
          if (!isInCart) {
            isInCart = isInCart.toggle();
            setState(
              () {},
            );
            final _catalog = CatalogModel();

            _cart.Catalog = _catalog;
            _cart.add(widget.Catalog);
          }
        },
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(context.primaryColor),
            shape: MaterialStateProperty.all(const StadiumBorder())),
        child: isInCart
            ? const Icon(Icons.done).iconColor(Colors.white)
            : "Buy".text.white.make());
  }
}
