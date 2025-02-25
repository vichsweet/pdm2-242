import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:app/cart.dart';
import 'package:app/catalog.dart';
import 'package:app/settings.dart';
import 'package:app/theme.dart';
import 'package:app/models/cart.dart';
import 'package:app/models/catalog.dart';
import 'package:app/cep.dart';


void main() {
  runApp(
    MultiProvider(
      providers: [
        Provider(create: (_) => CatalogModel()), // Cria o CatalogModel
        ChangeNotifierProvider(
          create: (context) =>
              CartModel(catalog: context.read<CatalogModel>()), // Passa o catálogo
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<StatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isDarkMode = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'App',
      debugShowCheckedModeBanner: false,
      darkTheme: darkmode,
      theme: lightmode,
      themeMode: _isDarkMode ? ThemeMode.dark : ThemeMode.light,
      initialRoute: '/',
      routes: {
        '/': (context) => const CepSearchPage(), // Define a página inicial como a consulta de CEP
        '/settings': (context) => SettingsPage(
              title: 'Settings Screen',
              isDarkMode: _isDarkMode,
              onThemeChanged: (value) {
                setState(() {
                  _isDarkMode = value;
                });
              },
            ),
        '/cart': (context) => MyCart(
              title: 'Cart Screen',
              isDarkMode: _isDarkMode,
              onThemeChanged: (value) {
                setState(() {
                  _isDarkMode = value;
                });
              },
            ),
        '/catalog': (context) => MyCatalog(
              title: 'Catalog Screen',
              isDarkMode: _isDarkMode,
              onThemeChanged: (value) {
                setState(() {
                  _isDarkMode = value;
                });
              },
            ),
      },
    );
  }
}
