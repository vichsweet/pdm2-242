import 'package:flutter/material.dart';
import '../models/item.dart';

class ShoppingCart extends StatefulWidget {
  @override
  _ShoppingCartState createState() => _ShoppingCartState();
}

class _ShoppingCartState extends State<ShoppingCart> {
  List<Item> items = [
    Item(name: 'Item 1', price: 10),
    Item(name: 'Item 2', price: 15),
    Item(name: 'Item 3', price: 12),
    Item(name: 'Item 4', price: 20),
  ];

  void _showSnackBar() {
    List<Item> selectedItems = items.where((item) => item.selected).toList();

    if (selectedItems.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Nenhum item selecionado!')),
      );
      return;
    }

    String message = selectedItems
        .map((item) => "${item.name} - \$ ${item.price}")
        .join(' + ');

    int total = selectedItems.fold(0, (sum, item) => sum + item.price);
    message += " = Total \$ $total";

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('$message - Desenvolvido por Cauã Icaro')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Carrinho de Compras')),
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          return CheckboxListTile(
            title: Text("${items[index].name} - \$${items[index].price}"),
            value: items[index].selected,
            onChanged: (bool? value) {
              setState(() {
                items[index].selected = value ?? false;
              });
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showSnackBar,
        child: Icon(Icons.shopping_cart),
      ),
    );
  }
}
