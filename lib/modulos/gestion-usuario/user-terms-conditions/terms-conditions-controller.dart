import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:flutter/foundation.dart';
import 'dart:async';
import 'package:appfront/modulos/gestion-usuario/user-login/validate-login.dart';
import 'package:appfront/modulos/gestion-usuario/models/index.dart' as globals;
class TermsConditionsController extends GetxController{
  String mensaje ='';
  void createCount(){

      if(globals.termsConditions==true){
        mensaje="Gracias por aceptar nuestros terminos y condiciones";
        update();
      }
      else{
        mensaje="Debe de aceptar nuestros terminos y condiciones";
        update();
      }
    update();
  }

}