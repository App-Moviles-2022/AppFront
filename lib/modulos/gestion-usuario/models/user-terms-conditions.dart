import 'package:appfront/modulos/gestion-pet/add_pet.dart';
import 'package:appfront/modulos/gestion-pet/models/pet.dart';
import 'package:appfront/modulos/gestion-pet/pet_details.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:appfront/modulos/gestion-usuario/user-terms-conditions/client-terms-conditions.dart';
import 'package:appfront/modulos/gestion-usuario/models/user-terms-conditions.dart';
import 'package:appfront/modulos/gestion-usuario/models/user-accept-terms.dart';
class ListTerms{
  int id;
  int userId;

  ListTerms(this.id, this.userId);

  Map<String, dynamic> toMap(){
    return{
      'id': (id == 0)? null : id,
      'userId': userId,

    };
  }
}


