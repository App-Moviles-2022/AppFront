import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:appfront/modulos/gestion-usuario/models/user.dart';
import 'package:appfront/modulos/gestion-usuario/user-login/client-login.dart';
import 'package:appfront/modulos/gestion-usuario/user-login/vet-login.dart';
import 'package:appfront/modulos/gestion-usuario/user-login/provider-login.dart';
import 'package:http/http.dart' as http;

class RegisterPageClient extends StatefulWidget {
  RegisterPageClient({Key? key}) : super(key: key);

  @override
  _RegisterPageClientState createState() => _RegisterPageClientState();
}
class _RegisterPageClientState extends State<RegisterPageClient> {
  final storage = const FlutterSecureStorage();
  final name = TextEditingController();
  final lastName = TextEditingController();
  final type = TextEditingController();
  final userNick = TextEditingController();
  final ruc = TextEditingController();
  final dni = TextEditingController();
  final phone = TextEditingController();
  final urlToImageBackground = TextEditingController();
  final urlToImageProfile = TextEditingController();
  final email = TextEditingController();
  final password = TextEditingController();
  final password2 = TextEditingController();
  final url = Uri.parse("https://timexp.xempre.com/api/v1/users/auth/sign-up");

  final headers = {"Content-Type": "application/json;charset=UTF-8"};

  String? claveError;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.05,
              ),
              Text(
                "AdoptMe app",
                style: TextStyle(
                    fontSize: 50, color: Theme.of(context).primaryColor),
              ),
              const Text(
                "Cliente",
                style: TextStyle(fontSize: 20, color: Colors.grey),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.10,
              ),
              Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)),
                margin: const EdgeInsets.all(10),
                padding: const EdgeInsets.all(10),
                child: TextField(
                  controller: name,
                  decoration: const InputDecoration(
                      hintText: "Nombre", border: InputBorder.none),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)),
                margin: const EdgeInsets.all(10),
                padding: const EdgeInsets.all(10),
                child: TextField(
                  controller: lastName,
                  decoration: const InputDecoration(
                      hintText: "Apellido", border: InputBorder.none),
                ),
              ),

              Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)),
                margin: const EdgeInsets.all(10),
                padding: const EdgeInsets.all(10),
                child: TextField(
                  controller: userNick,
                  decoration: const InputDecoration(
                      hintText: "Nick", border: InputBorder.none),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)),
                margin: const EdgeInsets.all(10),
                padding: const EdgeInsets.all(10),
                child: TextField(
                  controller: ruc,
                  decoration: const InputDecoration(
                      hintText: "Ruc", border: InputBorder.none),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)),
                margin: const EdgeInsets.all(10),
                padding: const EdgeInsets.all(10),
                child: TextField(
                  controller: dni,
                  decoration: const InputDecoration(
                      hintText: "Dni", border: InputBorder.none),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)),
                margin: const EdgeInsets.all(10),
                padding: const EdgeInsets.all(10),
                child: TextField(
                  controller: phone,
                  decoration: const InputDecoration(
                      hintText: "Telefono", border: InputBorder.none),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)),
                margin: const EdgeInsets.all(10),
                padding: const EdgeInsets.all(10),
                child: TextField(
                  controller: urlToImageBackground,
                  decoration: const InputDecoration(
                      hintText: "Imagen de fondo de perfil", border: InputBorder.none),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)),
                margin: const EdgeInsets.all(10),
                padding: const EdgeInsets.all(10),
                child: TextField(
                  controller: urlToImageProfile,
                  decoration: const InputDecoration(
                      hintText: "Imagen de perfil", border: InputBorder.none),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)),
                margin: const EdgeInsets.all(10),
                padding: const EdgeInsets.all(10),
                child: TextField(
                  keyboardType: TextInputType.emailAddress,
                  controller: email,
                  decoration: const InputDecoration(
                      hintText: "Email", border: InputBorder.none),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)),
                margin: const EdgeInsets.all(10),
                padding: const EdgeInsets.all(10),
                child: TextField(
                  keyboardType: TextInputType.visiblePassword,
                  controller: password,
                  obscureText: true,
                  decoration: InputDecoration(
                      errorText: claveError,
                      hintText: "Contraseña",
                      border: InputBorder.none),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)),
                margin: const EdgeInsets.all(10),
                padding: const EdgeInsets.all(10),
                child: TextField(
                  keyboardType: TextInputType.visiblePassword,
                  controller: password2,
                  obscureText: true,
                  decoration: const InputDecoration(
                      hintText: "Confirmar Contraseña",
                      border: InputBorder.none),
                ),
              ),
              ElevatedButton(

                  onPressed: () {
                    register();
                    Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => ClientLogin()));
                  },


                  child: const Text("Crear cuenta")),
              TextButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => ClientLogin()));
                  },
                  child: const Text("Ya tengo una cuenta"))
            ],
          ),
        ),
      ),
    );
  }

  Future<void> register() async {
    if (password.text != password2.text) {
      setState(() {
        claveError = "Contraseñas no coinciden";
      });
      return;
    }
    setState(() {
      claveError = null;
    });

    final user = {
      "name": name.text,
      "pass": password.text,
      "type": "Veterinario",
      "lastName": lastName.text,
      "userNick": userNick.text,
      "ruc": ruc.text,
      "dni": dni.text,
      "phone": phone.text,
      "email": email.text,
      "urlToImageBackground": urlToImageBackground.text,
      "urlToImageProfile":urlToImageProfile.text,
      "districtId":0,
    };
    final res = await http.post(url, headers: headers, body: jsonEncode(user));

    if (res.statusCode == 401) {
      final data = Map.from((jsonDecode(res.body)));
      showSnackBar(data["error"]);
      return;
    }

    if (res.statusCode != 200) {
      showSnackBar("Ups hubo un error, intente de nuevo");
      return;
    }
    final data = Map.from(jsonDecode(res.body));
    final usuario = User.fromJson(data);
    //await storage.write(key: 'refresh-token', value: usuario.refreshToken);
    //await storage.write(key: 'access-token', value: usuario.refreshToken);
    Navigator.of(context).pushNamed('home');
  }

  void showSnackBar(String msg) {
    final snack = SnackBar(content: Text(msg));
    ScaffoldMessenger.of(context).showSnackBar(snack);
  }
}
