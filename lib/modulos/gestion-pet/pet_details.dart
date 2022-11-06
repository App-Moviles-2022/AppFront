import 'package:flutter/material.dart';

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
      body: Center(
          child:
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(padding: EdgeInsets.only(bottom:10), child: Text(pet.name ?? "", style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold), textAlign: TextAlign.center)),
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
              Padding(padding: EdgeInsets.only(bottom:10, top: 10), child: Text(pet.type ?? "", style: TextStyle(fontSize: 20), textAlign: TextAlign.center)),
              Padding(padding: EdgeInsets.only(bottom:10), child: Text(pet.attention ?? "", style: TextStyle(fontSize: 20), textAlign: TextAlign.center,))

            ],)
      ),
    );
  }
}


//
// class PetDetails extends StatelessWidget {
//
// }