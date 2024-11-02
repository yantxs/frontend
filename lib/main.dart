import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'LouveApp',
      theme: ThemeData(
        primaryColor: Colors.teal,
        scaffoldBackgroundColor: Colors.black,
        brightness: Brightness.dark,
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.black,
          elevation: 0,
        ),
        textTheme: TextTheme(
          headlineSmall: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          titleLarge: TextStyle(color: Colors.white),
        ),
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth > 600) {
            return _buildWideLayout(context);
          } else {
            return _buildNarrowLayout(context);
          }
        },
      ),
    );
  }

  Widget _buildWideLayout(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 250,
          color: Colors.teal[700],
          child: _buildSidebar(),
        ),
        Expanded(
          child: _buildMainContent(context),
        ),
      ],
    );
  }

  Widget _buildNarrowLayout(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('LouveApp'),
        backgroundColor: Colors.teal[700],
      ),
      drawer: Drawer(
        child: _buildSidebar(),
      ),
      body: _buildMainContent(context),
    );
  }

  Widget _buildSidebar() {
    return ListView(
      children: [
        UserAccountsDrawerHeader(
          accountName: Text('Yan Teixeira'),
          accountEmail: Text('teixeira.yan@gmail.com'),
          currentAccountPicture: CircleAvatar(
            backgroundColor: Colors.white,
            child: Text('YT', style: TextStyle(fontSize: 24, color: Colors.teal[700])),
          ),
          decoration: BoxDecoration(color: Colors.teal[700]),
        ),
        ListTile(title: Text('Início'), leading: Icon(Icons.home)),
        ListTile(title: Text('Escalas'), leading: Icon(Icons.calendar_today)),
        ListTile(title: Text('Repertório'), leading: Icon(Icons.music_note)),
        ListTile(title: Text('Mensagens'), leading: Icon(Icons.message)),
        ListTile(title: Text('Ministério'), leading: Icon(Icons.group)),
        // Adicione os outros itens do menu aqui
      ],
    );
  }

  Widget _buildMainContent(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Ministérios', style: Theme.of(context).textTheme.headlineSmall),
                TextButton(
                  onPressed: () {},
                  child: Text('Adicionar', style: TextStyle(color: Colors.teal)),
                ),
              ],
            ),
          ),
          SizedBox(height: 16),
          _buildMinisteriosGrid(),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 24),
                _buildSection(context, 'Minhas escalas', 'Próximas', 'Ver todas'),
                SizedBox(height: 24),
                _buildSection(context, 'Aniversariantes', 'Outubro', 'Ver todos'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMinisteriosGrid() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          SizedBox(width: 16), // Espaço no início
          _buildMinisterioCard('Teste', true),
          SizedBox(width: 12), // Espaço entre os cards
          _buildMinisterioCard('Teste 2', false),
          SizedBox(width: 12), // Espaço entre os cards
          _buildMinisterioCard('Teste 3', false),
          SizedBox(width: 12), // Espaço entre os cards
          _buildAddCard(),
          SizedBox(width: 16), // Espaço no final
        ],
      ),
    );
  }

  Widget _buildMinisterioCard(String title, bool isActive) {
    return Container(
      width: 220,
      //margin: EdgeInsets.only(right: 16),
      child: Card(
        color: Colors.grey[900],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
              child: Image.network(
                'https://via.placeholder.com/150',
                height: 150, // Aumentado de 100 para 150
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    height: 150, // Aumentado de 100 para 150
                    color: Colors.grey[800],
                    child: Center(
                      child: Icon(Icons.error, color: Colors.white),
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 4),
                  Row(
                    children: [
                      Text('0/0', style: TextStyle(fontSize: 12, color: Colors.grey)),
                      SizedBox(width: 4),
                      Icon(Icons.music_note, size: 12, color: Colors.grey),
                      SizedBox(width: 4),
                      Text('1', style: TextStyle(fontSize: 12, color: Colors.grey)),
                      SizedBox(width: 4),
                      Icon(Icons.person, size: 12, color: Colors.grey),
                      SizedBox(width: 4),
                      Text('1', style: TextStyle(fontSize: 12, color: Colors.grey)),
                      if (isActive) ...[
                        SizedBox(width: 4),
                        Icon(Icons.check, size: 12, color: Colors.teal),
                      ],
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAddCard() {
    return Container(
      width: 220, // Ajustando a largura para corresponder aos outros cards
      //margin: EdgeInsets.only(right: 16),
      child: Card(
        color: Colors.grey[800],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: SizedBox(
          height: 150, // Aumentado de 120 para 150
          child: Center(child: Icon(Icons.add, size: 32)),
        ),
      ),
    );
  }

  Widget _buildSection(BuildContext context, String title, String subtitle, String action) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title, style: Theme.of(context).textTheme.titleLarge),
            Text(action, style: TextStyle(color: Colors.teal)),
          ],
        ),
        Text(subtitle, style: TextStyle(color: Colors.grey)),
        SizedBox(height: 8),
        Card(
          color: Colors.grey[800],
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Center(child: Text('Lista vazia.')),
          ),
        ),
      ],
    );
  }
}
