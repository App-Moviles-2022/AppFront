import 'package:appfront/modulos/gestion-notificaciones/list-notifications.dart';
import 'package:appfront/modulos/gestion-publicaciones/list-publications.dart';
import 'package:appfront/modulos/gestion-pet/my_pets.dart';
import 'package:appfront/modulos/gestion-usuario/perfil-usuario.dart';
import 'package:flutter/material.dart';
import 'package:appfront/modulos/gestion-notificaciones/list-notifications.dart';
import 'package:appfront/modulos/gestion-usuario/user-login/user-login-type.dart';
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
      home: const TypeUserLogin(),
    );
  }
}


