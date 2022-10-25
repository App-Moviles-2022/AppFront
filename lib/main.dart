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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Flutter App"),
      ),
      body: ListView(
        children: <Widget>[
          ElevatedButton(onPressed: (){
            Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const PerfilUsuario())
            );
          }, child: Text("Perfil de Usuario")),
          ElevatedButton(onPressed: (){
            Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const PerfilUsuario())
            );
          }, child: Text("Mis Publicaciones")),
          ElevatedButton(onPressed: (){
            Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const PerfilUsuario())
            );
          }, child: Text("Publicaciones General")),
          ElevatedButton(onPressed: (){
            Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const PerfilUsuario())
            );
          }, child: Text("Mis Anuncios")),
          ElevatedButton(onPressed: (){
            Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const PerfilUsuario())
            );
          }, child: Text("Anuncios General")),
          ElevatedButton(onPressed: (){
            Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const PerfilUsuario())
            );
          }, child: Text("Subscripciones")),
          ElevatedButton(onPressed: (){
            Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const PerfilUsuario())
            );
          }, child: Text("Mis Mascotas"))
        ],
      ),
    );
  }
}
