import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:veterinary_application/models/cart.dart';
import 'package:veterinary_application/models/catalog.dart';
import 'package:veterinary_application/pages/shop_detail_page.dart';
import 'package:veterinary_application/widgets/catalog_image.dart';

class CatalogList extends StatelessWidget {
  const CatalogList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: CatalogModel.items?.length,
      itemBuilder: (context, index) {
        final catalog = CatalogModel.items![index];
        return InkWell(
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ShopDetailPage(
                      catalog: catalog,
                    )),
          ),
          child: CatalogItem(catalog: catalog),
        );
      },
    );
  }
}

class CatalogItem extends StatelessWidget {
  final Item catalog;
  const CatalogItem({
    super.key,
    required this.catalog,
  });
  @override
  Widget build(BuildContext context) {
    return VxBox(
        child: Row(
      children: [
        Hero(
          tag: Key(catalog.id.toString()),
          child: CatalogImage(
            image: catalog.image,
          ),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              catalog.name.text.lg.bold.color(context.primaryColor).make(),
              catalog.description.text.textStyle(context.captionStyle).make(),
              10.heightBox,
              ButtonBar(
                alignment: MainAxisAlignment.spaceBetween,
                buttonPadding: EdgeInsets.zero,
                children: [
                  "Rs ${catalog.price}".text.bold.xl.make(),
                  _AddToCart(Catalog: catalog)
                ],
              ).pOnly(right: 8.0)
            ],
          ),
        )
      ],
    )).color(context.cardColor).rounded.square(150).make().py16();
  }
}

class _AddToCart extends StatefulWidget {
  final Item Catalog;
  const _AddToCart({
    super.key,
    required this.Catalog,
  });

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
            final catalog = CatalogModel();

            _cart.Catalog = catalog;
            _cart.add(widget.Catalog);
          }
        },
        style: ButtonStyle(
            backgroundColor: WidgetStateProperty.all(context.primaryColor),
            shape: WidgetStateProperty.all(const StadiumBorder())),
        child: isInCart
            ? const Icon(Icons.done).iconColor(Colors.white)
            : "Buy".text.white.make());
  }
}
