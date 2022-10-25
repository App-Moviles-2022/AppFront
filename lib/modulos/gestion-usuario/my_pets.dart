import 'package:appfront/modulos/gestion-usuario/pet_details.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class MyPets extends StatefulWidget {
  const MyPets({Key? key}) : super(key: key);

  @override
  State<MyPets> createState() => _MyPetsState();
}

class _MyPetsState extends State<MyPets> {
  String defaultPet = "https://img.freepik.com/vector-gratis/pata-diseno-logotipo-mascota-vector-negocio-tienda-animales_53876-136741.jpg?w=2000";
  String url = "https://api.thedogapi.com/v1/breeds?limit=10";
  String apiKey = "";
  List pets = [];

  Future<String> makeRequest() async {
    final response = await http.get(
        Uri.parse(url),
        headers: {'x-api-key': apiKey}
    );

    setState(() {
      var extractData =  json.decode(response.body);
      pets = extractData;
    });

    return response.body;
  }

  @override
  void initState(){
    super.initState();
    makeRequest();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: pets.isEmpty ? 0 : pets.length,
        itemBuilder: (BuildContext context, i){
          return Card(child: ListTile(
            title: Text(pets[i]['name'] ?? ""),
            subtitle: Text(  pets[i]['bred_for'] ?? "" ),
            leading: CircleAvatar(backgroundImage: NetworkImage(pets[i]['image']['url'] ?? defaultPet),),
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => PetDetails(pets[i])));
            },
          ),);
        });
  }

}

