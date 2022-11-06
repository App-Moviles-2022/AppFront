// import 'dart:html';

import 'package:appfront/modulos/gestion-pet/add_pet.dart';
import 'package:appfront/modulos/gestion-pet/models/pet.dart';
import 'package:appfront/modulos/gestion-pet/pet_details.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class MyPets extends StatefulWidget {
  const MyPets({Key? key}) : super(key: key);

  @override
  State<MyPets> createState() => _MyPetsState();
}

class _MyPetsState extends State<MyPets>{
  String defaultPet = "https://img.freepik.com/vector-gratis/pata-diseno-logotipo-mascota-vector-negocio-tienda-animales_53876-136741.jpg?w=2000";

  String apiKey = "";
  List<Pet> pets = [];
  List<bool> imageValidator = [];

  Future<String> getMyPetsRequest() async {
    String url = "https://timexp.xempre.com/api/v1/pets/userid=5";
    final response = await http.get(
        Uri.parse(url),
        // headers: {'x-api-key': apiKey}
    );

    setState(() {
      pets = [];
      var extractData =  json.decode(response.body) as List;
      for (var i = 0; i<extractData.length; i++){
        pets.add(Pet.fromJson(extractData[i]));
      }
      //
      // pets = extractData;

      imageValidator = List.filled(pets.length, true, growable: true);

    });

    return response.body;
  }

  Future<String> deletePetRequest(id) async {
    String url = "https://timexp.xempre.com/api/v1/pets/$id";
    final response = await http.delete(
      Uri.parse(url),
      // headers: {'x-api-key': apiKey}
    );

    getMyPetsRequest();

    return response.body;
  }

  @override
  void initState(){
    super.initState();
    getMyPetsRequest();
  }

  Future<Null> refresh() async{
    getMyPetsRequest();
  }



  @override
  Widget build(BuildContext context) {
    return
      Scaffold(
          appBar: AppBar(title: const Text("Mis mascotas"),),
          body:RefreshIndicator(key: UniqueKey(),child: ListView.builder(
          itemCount: pets.isEmpty ? 0 : pets.length,
          itemBuilder: (BuildContext context, i){
            return Dismissible(
                key: UniqueKey(),
                direction: DismissDirection.endToStart,
                onDismissed: (direction){
                  if(direction == DismissDirection.endToStart){
                    deletePetRequest(pets[i].id);
                  }
                },
                background: Container(alignment: Alignment.centerRight,padding: EdgeInsets.only(right: 20),color: Colors.transparent,child: Icon(Icons.delete, color: Colors.red,)) ,
                child: Card(child: ListTile(
                  title: Text(pets[i].name ?? ""),
                  subtitle: Text(  pets[i].type ?? "" ),
                  leading: CircleAvatar(backgroundImage: NetworkImage(imageValidator[i] ? pets[i].urlToImage.toString() : defaultPet), onBackgroundImageError: (a,b){
                    setState(() {
                      imageValidator[i] = false;
                    });
                  },),
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => PetDetails(pets[i])));
                  },
                  trailing: IconButton(icon: Icon(Icons.edit), onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => AddPet(pets[i]))).then((value) => {refresh()});
                    },),

                ),)
            );
          }),onRefresh: ()async{await refresh();},),

      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.red,
        child: const Icon(Icons.add),
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => AddPet(Pet.empty()))).then((value) => {refresh()});
        },));

  }

}

