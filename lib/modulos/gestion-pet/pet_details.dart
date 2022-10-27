import 'package:flutter/material.dart';

class PetDetails extends StatelessWidget {
  PetDetails(this.pet);
  final pet;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Pet Detail"),),
      body: Center(
        child:
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(padding: EdgeInsets.only(bottom:10), child: Text(pet['name'] ?? "", style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold), textAlign: TextAlign.center)),
            Container(
            width: 250,
            height: 250,
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: const BorderRadius.all(Radius.circular(125)),
              border: Border.all(color: Colors.blueAccent, width: 2),
              image: DecorationImage(
                  image: NetworkImage(pet['image']['url']),
                  fit: BoxFit.cover),
            )),
            Padding(padding: EdgeInsets.only(bottom:10, top: 10), child: Text(pet['bred_for'] ?? "", style: TextStyle(fontSize: 20), textAlign: TextAlign.center)),
            Padding(padding: EdgeInsets.only(bottom:10), child: Text(pet['temperament'] ?? "", style: TextStyle(fontSize: 20), textAlign: TextAlign.center,))

        ],)
      ),
    );
  }
}