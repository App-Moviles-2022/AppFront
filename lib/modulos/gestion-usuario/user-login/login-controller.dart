import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:flutter/foundation.dart';
import 'dart:async';
import 'package:appfront/modulos/gestion-usuario/user-login/validate-login.dart';
class LoginController extends GetxController{
  String mensaje ='';
  void iniciarSesion(String correo, String password){
    //cuando termine de procesar me haga esta accion(then)
    Modelo.iniciarSesion(correo, password).then((value){
      if(value){
        mensaje="Bienvenido";
        update();
      }
      else{
        mensaje="Correo o mensaje no valido";
        update();
      }
      update();
    });
    update();
  }

}