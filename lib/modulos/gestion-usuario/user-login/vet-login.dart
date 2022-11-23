import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:appfront/modulos/gestion-usuario/user-register/client-register.dart';
import 'package:get/get.dart';
import 'package:appfront/modulos/gestion-usuario/user-login/login-controller.dart';
import 'package:appfront/modulos/gestion-usuario/user-register/client-register.dart';
import 'package:appfront/modulos/gestion-usuario/user-views/client-view.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:appfront/modulos/gestion-usuario/user-login/validate-login.dart';
import 'package:appfront/modulos/gestion-usuario/user-terms-conditions/client-terms-conditions.dart';
import 'package:appfront/modulos/gestion-usuario/user-terms-conditions/client-terms-conditions.dart';
import 'package:appfront/modulos/gestion-usuario/models/user-terms-conditions.dart';
import 'package:appfront/modulos/gestion-usuario/models/user-accept-terms.dart';
import 'package:appfront/modulos/gestion-usuario/models/index.dart' as globals;
import 'package:appfront/modulos/gestion-usuario/user-register/vet-register.dart';
class VetLogin extends StatelessWidget {
  const VetLogin({Key? key}) : super(key: key);
  static const String _title = 'AdoptMe ya';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: _title,
      home: Scaffold(
        appBar: AppBar(title: const Text(_title)),
        body: const MyStatefulWidget(),
      ),
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({Key? key}) : super(key: key);

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  String email='';
  String password='';




  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoginController>(
        init:LoginController(),
        builder: (_){
          return Padding(
              padding: const EdgeInsets.all(10),
              child: ListView(
                children: <Widget>[
                  Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.all(10),
                      child: const Text(
                        'Veterinario',
                        style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.w500,
                            fontSize: 30),
                      )),
                  Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.all(10),
                      child: const Text(
                        'Sign in',
                        style: TextStyle(fontSize: 20),
                      )),
                  Container(
                    padding: const EdgeInsets.all(10),
                    child: TextField(
                      controller: emailController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'User Name',
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                    child: TextField(
                      obscureText: true,
                      controller: passwordController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Password',
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {

                    },
                    child: const Text('Forgot Password',),
                  ),
                  Container(
                    height: 50,
                    padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: ElevatedButton(
                      child: const Text('Login'),
                      onPressed: () {
                        _.iniciarSesion( emailController.text, passwordController.text);

                        void func() async{
                          bool validate = await Modelo.iniciarSesion(emailController.text, passwordController.text);
                          if(validate==true)
                          {globals.termsConditions=false;
                          print("ACA ESTOY");
                          Navigator.of(context, rootNavigator: true).pushAndRemoveUntil(
                            MaterialPageRoute(builder: (BuildContext context) => ClientView()),
                            ModalRoute.withName('/'),
                          );}
                        }
                        func();

                      },
                    ),


                  ),
                  SizedBox(height: 30),
                  Text(_.mensaje,
                    style: TextStyle(
                      color: Colors.orange,
                    ),),

                  Row(
                    children: <Widget>[
                      const Text('Do not have an account?'),
                      TextButton(
                        child: const Text(
                          'Sign in',
                          style: TextStyle(fontSize: 20),
                        ),
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => RegisterPageVet()));

                        },
                      )
                    ],
                    mainAxisAlignment: MainAxisAlignment.center,
                  ),
                ],
              ));
        }
    );
  }
}