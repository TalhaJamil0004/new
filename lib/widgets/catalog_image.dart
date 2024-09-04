import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class CatalogImage extends StatelessWidget {
  const CatalogImage({
    super.key,
    required this.image,
  });

  final String image;

  @override
  Widget build(BuildContext context) {
   // print("image---->$image");
    return image.contains("http")
        ? Image.network(
            image,
            // placeholder: (context, url) =>
            //     const SizedBox(width: 30, child: CircularProgressIndicator()),
           // errorWidget: (context, url, error) => Icon(Icons.error), // Display an error icon or message
          ).box.rounded.p8.color(context.canvasColor).make().p16().w32(context)
        : Image.asset(image) // Use AssetImage for assets
            .box
            .rounded
            .p8
            .color(context.canvasColor)
            .make()
            .p16()
            .w32(context);
  }
}
