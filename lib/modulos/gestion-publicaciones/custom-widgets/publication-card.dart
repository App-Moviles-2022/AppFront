import 'package:appfront/modulos/gestion-publicaciones/models/publication.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../list-publications.service.dart';

class CardPublication extends StatelessWidget {
  Publication publication;
  late ListPublicationsService listPublicationsService = ListPublicationsService();

  CardPublication(this.publication, {super.key});
  @override
  Widget build(BuildContext context) {

    return Card(
      color: Colors.indigo,
      child: Column(
        children: <Widget>[
          Container(
            child: Ink.image(
                image: NetworkImage(publication.image),
              height: 200,
              fit: BoxFit.cover,
            ),
          ),
          padding(Text(publication.name, style: const TextStyle(fontSize: 18.0,
              fontFamily: "Roboto", fontWeight: FontWeight.bold, color: Colors.white),)),
          Row(
            children: <Widget>[
              // padding(const Icon(Icons.pets, color: Colors.white70,)),
              // padding(Text(publication.type, style: const TextStyle(fontSize: 16.0,
              //     fontFamily: "Roboto", fontWeight: FontWeight.normal, color: Colors.white),)),
              padding(ElevatedButton.icon(
                icon: Icon(Icons.add_business_rounded),
                onPressed: (){
                }, label: Text('Adoptar'),
              ),),
              padding(ElevatedButton.icon(
                icon: Icon(Icons.account_circle_outlined),
                onPressed: (){
                  listPublicationsService.deletePublication(publication.publicationId).then((value) => {
                  });
                }, label: Text('Ver perfil'),
              ),),
            ],
          ),
        ],
      ),
    );
  }
  Widget padding(Widget widget) {
    return Padding(padding: const EdgeInsets.all(7.0), child: widget);
  }
}

_openPopup(context, Publication _publication, int index) async {
  Publication publication = _publication;
  final prefs = await SharedPreferences.getInstance();
  final counter = prefs.getInt('userId') ?? 0;
  AdoptionRequest adoptionRequest = new AdoptionRequest(counter, _publication.userId, _publication.publicationId, "Hola", "string");
  Alert(
      context: context,
      title: "Editar Pet",
      content: Column(
        children: <Widget>[
          TextField(
            decoration: InputDecoration(
              labelText: 'name',
            ),
            controller: TextEditingController(text: publication.name),
            onChanged: (name)=>{publication.name=name},
          ),
          TextField(
            decoration: InputDecoration(
              labelText: 'urlToImage',
            ),
            controller: TextEditingController(text: publication.image),
            onChanged: (image)=>{publication.image=image},
          ),
        ],
      ),
      buttons: [
        DialogButton(
          // onPressed: ()=>{print(publication.name)},
          onPressed: () => {} ,
          child: Text(
            "Actualizar",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
        )
      ]).show();
}
