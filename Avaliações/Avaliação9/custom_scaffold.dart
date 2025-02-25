import 'package:flutter/material.dart';

class CustomScaffold extends StatelessWidget{
  final String title;
  final Widget body;
  final Widget? floatingActionButton;

  const CustomScaffold({
    super.key,
    required this.title,
    required this.body,
    this.floatingActionButton
  });

  @override
  Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      title: Text(title),
    ),drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                "Menu",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text("Home"),
              onTap: (){
                  Navigator.popUntil(context, ModalRoute.withName('/'));
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text("Settings"),
              onTap: (){
                  Navigator.pushNamed(context, '/settings');
                  
              },
            ),
            ListTile(
              leading: const Icon(Icons.shopping_cart),
              title: const Text("Cart"),
              onTap: (){
                  Navigator.pushNamed(context, '/cart');
                  
              },
            ),
            ListTile(
              leading: const Icon(Icons.menu),
              title: const Text("Catalog"),
              onTap: (){
                  Navigator.pushNamed(context, '/catalog');
                  
              },
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text("Logout"),
              onTap: (){
                //Lógica de logout a ser implementada
              },
            )
          ],
        ),
      ),
      body: body,
      floatingActionButton: floatingActionButton,
  );

  } 
}