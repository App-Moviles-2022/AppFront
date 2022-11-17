import 'package:appfront/modulos/gestion-publicaciones/models/publication.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../list-publications.service.dart';

class CardPublication extends StatelessWidget {
  Function callback;
  Function setStatePublications;
  Publication publication;
  int index;

  CardPublication(this.publication, this.index,  this.callback, this.setStatePublications, {super.key});
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
          padding(Text(publication.comment, style: const TextStyle(fontSize: 18.0,
              fontFamily: "Roboto", fontWeight: FontWeight.bold, color: Colors.white),)),
          Row(
            children: <Widget>[
              padding(ElevatedButton.icon(
                icon: Icon(Icons.edit),
                onPressed: (){
                  _openPopup(context, publication, index, setStatePublications);
                }, label: Text('Editar'),
              ),),
              padding(ElevatedButton.icon(
                icon: Icon(Icons.delete),
                onPressed: (){
                  print(publication);
                  print(index);
                    callback(publication, index);
                }, label: Text('Eliminar'),
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

_openPopup(context, Publication _publication, int index, _setStatePublications) async {
  Function setStatePublications;
  setStatePublications = _setStatePublications;
  Publication publication = _publication;
  // final prefs = await SharedPreferences.getInstance();
  // final counter = prefs.getInt('userId') ?? 0;
  // late ListPublicationsService listPublicationsService = ListPublicationsService();

  Alert(
      context: context,
      title: "Editar Pet",
      content: Column(
        children: <Widget>[
          TextField(
            decoration: InputDecoration(
              labelText: 'comment',
            ),
            controller: TextEditingController(text: publication.comment),
            onChanged: (comment)=>{publication.comment=comment},
          ),
          // TextField(
          //   decoration: InputDecoration(
          //     labelText: 'urlToImage',
          //   ),
          //   controller: TextEditingController(text: publication.image),
          //   onChanged: (image)=>{publication.image=image},
          // ),
        ],
      ),
      buttons: [
        DialogButton(
          // onPressed: ()=>{print(publication.name)},
          onPressed: () => {
            setStatePublications(publication, index)
          } ,
          child: Text(
            "Actualizar",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
        )
      ]).show();

  // _openPopup(context, Publication _publication, int index, setStatePublications) {
  //   Publication publication = _publication;
  //   Alert(
  //       context: context,
  //       title: "Editar Pet",
  //       content: Column(
  //         children: <Widget>[
  //           TextField(
  //             decoration: InputDecoration(
  //               labelText: 'name',
  //             ),
  //             controller: TextEditingController(text: publication.name),
  //             onChanged: (name)=>{publication.name=name},
  //           ),
  //           TextField(
  //             decoration: InputDecoration(
  //               labelText: 'urlToImage',
  //             ),
  //             controller: TextEditingController(text: publication.image),
  //             onChanged: (image)=>{publication.image=image},
  //           ),
  //         ],
  //       ),
  //       buttons: [
  //         DialogButton(
  //           // onPressed: ()=>{print(publication.name)},
  //           onPressed: () => {
  //             listPublicationsService.updatePublication(publication.petId, {
  //               "name": publication.name,
  //               "urlToImage": publication.image,
  //               "type": publication.type,
  //               "attention": "string",
  //               "race": "string",
  //               "userId": publication.userId
  //           }).then((res){
  //             publication.name = publication.name;
  //             publication.image = publication.image;
  //             setState(() {
  //               publications = publications;
  //             }
  //             ); }) } ,
  //           child: Text(
  //             "Actualizar",
  //             style: TextStyle(color: Colors.white, fontSize: 20),
  //           ),
  //         )
  //       ]).show();
  // }

}

