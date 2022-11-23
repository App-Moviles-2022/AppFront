import 'dart:convert';

import 'package:appfront/modulos/gestion-pet/models/pet.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class AddPet extends StatefulWidget {
/**trabajar aqui*/
  Pet pet = Pet.empty();
  AddPet(this.pet);
  @override
  State<AddPet> createState() => _AddPetState(this.pet);
}

class _AddPetState extends State<AddPet> {
  // final _urlToImageController = TextEditingController();

  Pet pet = Pet.empty();
  _AddPetState(this.pet);

  String appBarTitle = "Add Pet";

  double v_padding = 20;
  bool isEdit = false;

  final typeController = TextEditingController();
  final nameController = TextEditingController();
  final ageController = TextEditingController();
  final raceController = TextEditingController();
  final genderController = TextEditingController();
  final attentionController = TextEditingController();
  final urlToImageController = TextEditingController();



  Future<String> saveRequest() async {
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getInt('userId') ?? 0;

    String url = "https://timexp.xempre.com/api/v1/pets";
    final data = jsonEncode(<String, dynamic>{
      'type': typeController.text,
      'name': nameController.text,
      'attention': attentionController.text,
      'age': int.parse(ageController.text),
      'race': raceController.text,
      'userId': userId,
      'publicationId': null,
      'gender': genderController.text,
      'urlToImage': urlToImageController.text,
      'isAdopted': false,
      'isPublished': false
    });
    final response = await http.post(
      Uri.parse(url),
      headers: {'Content-type': 'application/json'},
      body: data,
      encoding: Encoding.getByName("utf-8")
    );
    setState(() {
    });
    return response.body;
  }

  Future<String> updateRequest() async {
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getInt('userId') ?? 0;

    String url = "https://timexp.xempre.com/api/v1/pets/${pet.id}";
    final data = jsonEncode(<String, dynamic>{
      'type': typeController.text,
      'name': nameController.text,
      'attention': attentionController.text,
      'age': int.parse(ageController.text),
      'race': raceController.text,
      'userId': userId,
      'publicationId': null,
      'gender': genderController.text,
      'urlToImage': urlToImageController.text,
      'isAdopted': false,
      'isPublished': false
    });
    final response = await http.put(
        Uri.parse(url),
        headers: {'Content-type': 'application/json'},
        body: data,
        encoding: Encoding.getByName("utf-8")
    );
    setState(() {
    });
    return response.body;
  }


  @override
  void initState(){
    super.initState();
    if(pet.id != null){
      appBarTitle = "Edit Pet";
      isEdit = true;
      typeController.text = pet.type.toString();
      nameController.text = pet.name.toString();
      attentionController.text = pet.attention.toString();
      ageController.text = pet.age.toString();
      raceController.text = pet.race.toString();
      genderController.text = pet.gender.toString();
      urlToImageController.text = pet.urlToImage.toString();
    }


  }

  @override
  void dispose(){
    typeController.dispose();
    nameController.dispose();
    attentionController.dispose();
    ageController.dispose();
    raceController.dispose();
    genderController.dispose();
    urlToImageController.dispose();
    super.dispose();
  }

  ImageProvider<Object> getPetImage(String url) {
    final image = Image.network(url, errorBuilder: (context, object, trace) {
      setState(() {
        Fluttertoast.showToast(msg: "msg");
      });
      return Image(image: NetworkImage('https://img.freepik.com/vector-gratis/pata-diseno-logotipo-mascota-vector-negocio-tienda-animales_53876-136741.jpg'));
    },).image;
    return image;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text(appBarTitle)),
        body: SafeArea(child: SingleChildScrollView(child:
        Column(
          children: [
            SizedBox(height: v_padding,),
            Container(child:           Padding(padding: EdgeInsets.symmetric(horizontal: 20),
              child: TextField(
                controller: typeController,
                decoration: InputDecoration(
                  hintText: "Type",
                  filled: true,
                ),
              ),),),
            SizedBox(height: v_padding,),
            Container(child:           Padding(padding: EdgeInsets.symmetric(horizontal: 20),
              child: TextField(
                controller: nameController,
                decoration: InputDecoration(
                  hintText: "Name",
                  filled: true,
                ),
              ),),),
            SizedBox(height: v_padding,),
            Container(child:           Padding(padding: EdgeInsets.symmetric(horizontal: 20),
              child: TextField(
                keyboardType: TextInputType.number,
                controller: ageController,
                decoration: InputDecoration(
                  hintText: "Age",
                  filled: true,
                ),
              ),),),
            SizedBox(height: v_padding,),
            Container(child:           Padding(padding: EdgeInsets.symmetric(horizontal: 20),
              child: TextField(
                controller: raceController,
                decoration: InputDecoration(
                  hintText: "Race",
                  filled: true,
                ),
              ),),),
            SizedBox(height: v_padding,),
            Container(child:           Padding(padding: EdgeInsets.symmetric(horizontal: 20),
              child: TextField(
                controller: genderController,
                decoration: InputDecoration(
                  hintText: "Gender",
                  filled: true,
                ),
              ),),),
            SizedBox(height: v_padding,),
            Container(child:           Padding(padding: EdgeInsets.symmetric(horizontal: 20),
              child: TextField(
                controller: attentionController,
                decoration: InputDecoration(
                  hintText: "Attention",
                  filled: true,
                ),
              ),),),
            SizedBox(height: v_padding,),

            Padding(padding: EdgeInsets.symmetric(horizontal: 20),
              child: TextField(
                onChanged: (text){setState(() {
                  urlToImageController.text;
                });},
                controller: urlToImageController,
                decoration: const InputDecoration(
                  hintText: "Image Url",
                  filled: true,
                ),
              ),),
            SizedBox(height: v_padding,),
            Container(

              child: CachedNetworkImage(
                imageUrl: urlToImageController.text,
                imageBuilder: (context, imageProvider) => Container(
                    width: urlToImageController.text == "" ? 0 : 250,
                    height: urlToImageController.text == "" ? 0 : 250,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: const BorderRadius.all(Radius.circular(125)),
                      border: Border.all(color: Colors.blueAccent, width: 2),
                      image:
                      DecorationImage(
                        image: imageProvider,
                        fit: BoxFit.cover,),
                    )

                ),
                placeholder: (context, url) => const CircularProgressIndicator(),
                errorWidget: (context, url, error){
                  Fluttertoast.showToast(msg: "Invalid Url.");
                  return const Icon(Icons.error);},
              ),

              // ),
            ),
            SizedBox(height: v_padding,),
            ElevatedButton(onPressed: (){

              !isEdit ? saveRequest() : updateRequest();

              // if (response() == null){
              //   Fluttertoast.showToast(msg: "Error, ");
              // } else {
              Fluttertoast.showToast(msg: "Pet added successful.");
              Navigator.pop(context);
              // }

            }, child: Text("Save", style: TextStyle(fontSize: 20),))

          ],
        ),),)

      );
  }
}
