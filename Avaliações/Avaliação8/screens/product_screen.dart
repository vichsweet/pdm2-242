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
      appBar: AppBar(title: Text('Produtos')),
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text("${items[index].name} - \$${items[index].price}"),
            trailing: IconButton(
              icon: Icon(Icons.add_circle, color: Colors.green, size: 30),
              onPressed: () {
                setState(() {
                  items[index].quantity++;
                });
              },
            ),
          );
        },
      ),
      floatingActionButton: Stack(
        children: [
          FloatingActionButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CartScreen(items: items),
                ),
              );
            },
            child: Icon(Icons.shopping_cart, size: 40),
            backgroundColor: Colors.blue,
          ),
          if (cartItemCount > 0)
            Positioned(
              right: 0,
              top: 0,
              child: Container(
                padding: EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: Colors.red,
                  shape: BoxShape.circle,
                ),
                child: Text(
                  '$cartItemCount',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
