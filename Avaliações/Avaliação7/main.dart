import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeData temaAtual = ThemeData.light();

  void alternarTema() {
    setState(() {
      temaAtual = (temaAtual == ThemeData.light()) ? ThemeData.dark() : ThemeData.light();
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: temaAtual,
      debugShowCheckedModeBanner: false,
      home: TelaInicial(alternarTema: alternarTema),
    );
  }
}

// Tela Inicial
class TelaInicial extends StatelessWidget {
  final VoidCallback alternarTema;

  TelaInicial({required this.alternarTema});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Início')),
      drawer: MenuDrawer(alternarTema: alternarTema),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Bem-vindo ao App!',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              Text(
                'Explore as funcionalidades do app acessando o menu lateral.\n'
                'Aqui você pode personalizar seu perfil, alterar configurações e ver imagens.',
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              Text(
                'Dupla: Isadora Braide e Victor Moura',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.blue),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Tela de Perfil (Stateful)
class TelaPerfil extends StatefulWidget {
  @override
  _TelaPerfilState createState() => _TelaPerfilState();
}

class _TelaPerfilState extends State<TelaPerfil> {
  String nome = "Usuário";

  void alterarNome() {
    setState(() {
      nome = nome == "Usuário" ? "Isadora" : "Usuário";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Perfil')),
      drawer: MenuDrawer(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Olá, $nome!',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: alterarNome,
              child: Text('Trocar Nome'),
            ),
          ],
        ),
      ),
    );
  }
}

// Tela de Configurações com opção de alternar tema
class TelaConfiguracoes extends StatelessWidget {
  final VoidCallback alternarTema;

  TelaConfiguracoes({required this.alternarTema});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Configurações')),
      drawer: MenuDrawer(alternarTema: alternarTema),
      body: Center(
        child: ElevatedButton(
          onPressed: alternarTema,
          child: Text('Alternar Tema'),
        ),
      ),
    );
  }
}

// Tela de Galeria com carregamento simulado
class TelaGaleria extends StatefulWidget {
  @override
  _TelaGaleriaState createState() => _TelaGaleriaState();
}

class _TelaGaleriaState extends State<TelaGaleria> {
  bool carregando = true;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 2), () {
      setState(() {
        carregando = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Galeria')),
      drawer: MenuDrawer(),
      body: carregando
          ? Center(child: CircularProgressIndicator())
          : GridView.builder(
              padding: EdgeInsets.all(10),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemCount: 6,
              itemBuilder: (context, index) {
                return Container(
                  color: Colors.blueAccent,
                  child: Center(
                    child: Text(
                      'Imagem ${index + 1}',
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ),
                );
              },
            ),
    );
  }
}

// Menu Drawer atualizado
class MenuDrawer extends StatelessWidget {
  final VoidCallback? alternarTema;

  MenuDrawer({this.alternarTema});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            decoration: BoxDecoration(color: Colors.blue),
            child: Text(
              'Menu de Navegação',
              style: TextStyle(color: Colors.white, fontSize: 22),
            ),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Início'),
            onTap: () {
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => TelaInicial(alternarTema: alternarTema!)));
            },
          ),
          ListTile(
            leading: Icon(Icons.person),
            title: Text('Perfil'),
            onTap: () {
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => TelaPerfil()));
            },
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Configurações'),
            onTap: () {
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => TelaConfiguracoes(alternarTema: alternarTema!)));
            },
          ),
          ListTile(
            leading: Icon(Icons.photo),
            title: Text('Galeria'),
            onTap: () {
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => TelaGaleria()));
            },
          ),
        ],
      ),
    );
  }
}
