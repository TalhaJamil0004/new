import 'package:flutter/material.dart';
import 'package:veterinary_application/models/catalog.dart';

class ItemWidget extends StatelessWidget {
  final Item item;

  const ItemWidget({Key? key, required this.item})
      : assert(item != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        onTap: () {
          print("${item.name} pressed");
        },
        leading: Image.network(item.image),
        title: Text(item.name),
        subtitle: Text(item.description),
        trailing: Text(
          "\$ ${item.price}",
          textScaler: TextScaler.linear(2),
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
