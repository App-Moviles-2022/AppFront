import 'package:appfront/modulos/gestion-usuario/announcements.dart';
import 'package:appfront/modulos/gestion-usuario/my_pets.dart';
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
      home: AdoptmeStull(),
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
    MyPets(),
    Announcements(),
    MyPets(),
  ];


  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          bottom: const TabBar(
            tabs: [
              Tab(icon: Icon(Icons.flight)),
              Tab(icon: Icon(Icons.flight)),
              Tab(icon: Icon(Icons.flight)),
            ],
          ),
          title: const Text("Flutter App"),
        ),
        body: _widgetOptions.elementAt(_selectedIndex),
        // ListView(
        //   children: <Widget>[
        //     ElevatedButton(onPressed: (){
        //       Navigator.push(
        //           context,
        //           MaterialPageRoute(builder: (context) => const PerfilUsuario())
        //       );
        //     }, child: Text("Perfil de Usuario")),
        //     ElevatedButton(onPressed: (){
        //       Navigator.push(
        //           context,
        //           MaterialPageRoute(builder: (context) => const PerfilUsuario())
        //       );
        //     }, child: Text("Mis Publicaciones")),
        //     ElevatedButton(onPressed: (){
        //       Navigator.push(
        //           context,
        //           MaterialPageRoute(builder: (context) => const PerfilUsuario())
        //       );
        //     }, child: Text("Publicaciones General")),
        //     ElevatedButton(onPressed: (){
        //       Navigator.push(
        //           context,
        //           MaterialPageRoute(builder: (context) => const PerfilUsuario())
        //       );
        //     }, child: Text("Mis Anuncios")),
        //     ElevatedButton(onPressed: (){
        //       Navigator.push(
        //           context,
        //           MaterialPageRoute(builder: (context) => const PerfilUsuario())
        //       );
        //     }, child: Text("Anuncios General")),
        //     ElevatedButton(onPressed: (){
        //       Navigator.push(
        //           context,
        //           MaterialPageRoute(builder: (context) => const PerfilUsuario())
        //       );
        //     }, child: Text("Subscripciones")),
        //     ElevatedButton(onPressed: (){
        //       Navigator.push(
        //           context,
        //           MaterialPageRoute(builder: (context) => const MyPets())
        //       );
        //     }, child: Text("Mis Mascotas"))
        //   ],
        // ),
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
      )
    );
  }
}
