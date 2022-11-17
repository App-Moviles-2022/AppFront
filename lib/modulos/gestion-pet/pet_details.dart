import 'package:flutter/material.dart';
import 'package:path/path.dart';

import 'models/pet.dart';

class PetDetails extends StatefulWidget {

  Pet pet;
  PetDetails(this.pet);
  @override
  State<PetDetails> createState() => _PetDetailsState(this.pet);

}

class _PetDetailsState extends State<PetDetails> {
  String defaultPet = "https://img.freepik.com/vector-gratis/pata-diseno-logotipo-mascota-vector-negocio-tienda-animales_53876-136741.jpg?w=2000";
  _PetDetailsState(this.pet);
  Pet pet;
  bool imageValidator = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Pet Detail"),),
      body: SingleChildScrollView(
          child:
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(padding: EdgeInsets.only(top: 10)),
              Container(
                  width: 250,
                  height: 250,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: const BorderRadius.all(Radius.circular(125)),
                    border: Border.all(color: Colors.blueAccent, width: 2),
                    image: DecorationImage(
                        image: NetworkImage(imageValidator ? pet.urlToImage.toString() : defaultPet),
                        onError: (a,b){

                          setState(() {
                            imageValidator = false;
                          });

                        },
                        fit: BoxFit.cover),
                  )),
              Padding(padding: EdgeInsets.only(bottom:10, top: 10), child: Text(pet.name ?? "", style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.indigo), textAlign: TextAlign.center)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Chip(label: Text("Published", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),), backgroundColor: pet.isPublished!?Colors.green:Colors.red,),
                  Chip(label: Text("Adopted",style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),), backgroundColor: pet.isAdopted!?Colors.green:Colors.red,),
              ],),
              Divider(),
              ListTile(
                title: Text(
                  'Id to publication',
                  style: TextStyle(
                    color: Colors.indigo,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Text(
                  pet.id.toString()??"",
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
              ),
              Divider(),
              ListTile(
                title: Text(
                  'Age',
                  style: TextStyle(
                    color: Colors.indigo,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Text(
                  pet.age.toString()??"",
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
              ),
              Divider(),
              ListTile(
                title: Text(
                  'Race',
                  style: TextStyle(
                    color: Colors.indigo,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Text(
                  pet.race??"",
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
              ),
              Divider(),
              ListTile(
                title: Text(
                  'Type',
                  style: TextStyle(
                    color: Colors.indigo,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Text(
                  pet.type??"",
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
              ),
              Divider(),
              ListTile(
                title: Text(
                  'Gender',
                  style: TextStyle(
                    color: Colors.indigo,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Text(
                  pet.gender??"",
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
              ),
              Divider(),
              ListTile(
                title: Text(
                  'Attention',
                  style: TextStyle(
                    color: Colors.indigo,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Text(
                  pet.attention??"",
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
              ),


            ],)
      ),
    );
  }
}


//
// class PetDetails extends StatelessWidget {
//
// }