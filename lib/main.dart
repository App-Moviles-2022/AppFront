import 'package:appfront/modulos/gestion-notificaciones/list-notifications.dart';
import 'package:appfront/modulos/gestion-publicaciones/list-publications.dart';
import 'package:appfront/modulos/gestion-usuario/announcements.dart';
import 'package:appfront/modulos/gestion-pet/my_pets.dart';
import 'package:appfront/modulos/gestion-usuario/perfil-usuario.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const AdoptmeStless());
}

class AdoptmeStless extends StatelessWidget {
  const AdoptmeStless({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Flutter App",
      theme: ThemeData(
          primarySwatch:Colors.indigo
      ),
      home: const AdoptmeStull(),
    );
  }
}

class AdoptmeStull extends StatefulWidget {
  const AdoptmeStull({Key? key}) : super(key: key);
  @override
  State<AdoptmeStull> createState() => _AdoptmeStullState();
}

class _AdoptmeStullState extends State<AdoptmeStull> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      // if(index == 1){
      //   Navigator.push(
      //       context,
      //       MaterialPageRoute(builder: (context) => const MyPets())
      //   );
      // }
    });
  }

  static const List<Widget> _widgetOptions = <Widget>[
    PerfilUsuario(),
    ListPublications(),
    Announcements(),
    MyPets(),
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.blueAccent,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "My Profile", backgroundColor: Colors.blueAccent),
          BottomNavigationBarItem(icon: Icon(Icons.public), label: "Publications", ),
          BottomNavigationBarItem(icon: Icon(Icons.announcement), label: "Announcements"),
          BottomNavigationBarItem(icon: Icon(Icons.pets), label: "My Pets")
        ],
        onTap: _onItemTapped,
        currentIndex: _selectedIndex,
      ),
    );
  }
}
