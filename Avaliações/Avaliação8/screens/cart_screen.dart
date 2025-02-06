import 'package:flutter/material.dart';
import '../models/item.dart';

class CartScreen extends StatelessWidget {
  final List<Item> items;

  CartScreen({required this.items});

  void _showSnackBar(BuildContext context) {
    List<Item> selectedItems =
        items.where((item) => item.quantity > 0).toList();

    if (selectedItems.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Nenhum item no carrinho!')),
      );
      return;
    }

    String message = selectedItems
        .map((item) => "${item.name} - \$${item.price} x ${item.quantity}")
        .join(' + ');

    int total = selectedItems.fold(
        0, (sum, item) => sum + (item.price * item.quantity));
    message += " = Total \$ $total";

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('$message - Desenvolvido por Victor Moura  ')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Carrinho')),
      body: ListView(
        children: items
            .where((item) => item.quantity > 0)
            .map((item) => ListTile(
                  title:
                      Text("${item.name} - \$${item.price} x ${item.quantity}"),
                ))
            .toList(),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ElevatedButton(
          onPressed: () => _showSnackBar(context),
          child: Text("BUY"),
        ),
      ),
    );
  }
}
