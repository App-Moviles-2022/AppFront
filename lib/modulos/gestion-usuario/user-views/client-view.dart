import 'package:appfront/modulos/gestion-notificaciones/list-notifications.dart';
import 'package:flutter/material.dart';
import 'package:appfront/modulos/gestion-announcements/announcements.dart';
import 'package:appfront/modulos/gestion-usuario/perfil-usuario.dart';
import 'package:appfront/modulos/gestion-publicaciones/list-publications.dart';
import 'package:appfront/modulos/gestion-pet/my_pets.dart';
class ClientView extends StatefulWidget {
  const ClientView({Key? key}) : super(key: key);
  @override
  State<ClientView> createState() => _ClientViewState();
}

class _ClientViewState extends State<ClientView> {
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

  static List<Widget> _widgetOptions = <Widget>[
    PerfilUsuario(),
    ListPublications(),
    Announcements(),
    MyPets(),
    Notifications()
  ];

  Future<bool> _onWillPop() async {
    return (await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Back'),
            content: const Text('Are you sure you want to go back?\nIf you continue you will log out'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(false);
                }, //<-- SEE HERE
                child: Text('No'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(true);
                }, //<-- SEE HERE
                child: const Text('Yes'),
              ),
            ],
          );
        }) ??
        false);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {print("gatooon");return _onWillPop();},
        child: Scaffold(
      // appBar: AppBar(
      //   title: const Text("Flutter App"),
      // ),
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
        backgroundColor: Colors.indigoAccent,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "My Profile", backgroundColor: Colors.indigoAccent),
          BottomNavigationBarItem(icon: Icon(Icons.public), label: "Publications", backgroundColor: Colors.indigoAccent),
          BottomNavigationBarItem(icon: Icon(Icons.announcement), label: "Announcements", backgroundColor: Colors.indigoAccent),
          BottomNavigationBarItem(icon: Icon(Icons.pets), label: "My Pets" ,backgroundColor: Colors.indigoAccent),
          BottomNavigationBarItem(icon: Icon(Icons.add_alert), label: "Notifications", backgroundColor: Colors.indigoAccent)
        ],
        onTap: _onItemTapped,
        currentIndex: _selectedIndex,
      ),
    ),
        )
      ;
  }



}