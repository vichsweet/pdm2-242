import 'package:flutter/material.dart';
import '../models/item.dart';
import 'cart_screen.dart';

class ProductScreen extends StatefulWidget {
  @override
  _ProductScreenState createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  List<Item> items = [
    Item(name: 'Item 1', price: 10),
    Item(name: 'Item 2', price: 15),
    Item(name: 'Item 3', price: 12),
    Item(name: 'Item 4', price: 20),
  ];

  int get cartItemCount => items.fold(0, (sum, item) => sum + item.quantity);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Produtos'),
        actions: [
          Stack(
            children: [
              IconButton(
                icon: Icon(Icons.shopping_cart),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CartScreen(items: items),
                    ),
                  );
                },
              ),
              if (cartItemCount > 0)
                Positioned(
                  right: 0,
                  child: CircleAvatar(
                    radius: 10,
                    backgroundColor: Colors.red,
                    child: Text(
                      '$cartItemCount',
                      style: TextStyle(fontSize: 12, color: Colors.white),
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text("${items[index].name} - \$${items[index].price}"),
            trailing: IconButton(
              icon: Icon(Icons.add_circle, color: Colors.green),
              onPressed: () {
                setState(() {
                  items[index].quantity++;
                });
              },
            ),
          );
        },
      ),
    );
  }
}
