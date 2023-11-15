import 'package:flutter/material.dart';
import 'package:united_squad/models/item.dart';

class ProductListPage extends StatelessWidget {
  final List<Item> items;

  const ProductListPage({Key? key, required this.items}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daftar Item'),
      ),
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              title: Text(items[index].name),
              subtitle: Text(
                  'Harga: ${items[index].price}\nDeskripsi: ${items[index].description}'),
            ),
          );
        },
      ),
    );
  }
}