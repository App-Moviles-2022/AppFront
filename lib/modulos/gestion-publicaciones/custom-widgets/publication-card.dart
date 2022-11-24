import 'package:appfront/modulos/gestion-publicaciones/models/publication.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../gestion-pet/models/pet.dart';
import '../list-publications.service.dart';

class CardPublication extends StatefulWidget {
  // const CardPublication({Key? key}) : super(key: key);

  late Function callback;
  late Function setStatePublications;
  late Publication publication;
  late int index;

  CardPublication(
      this.publication, this.index, this.callback, this.setStatePublications,);

  @override
  State<CardPublication> createState() => _CardPublicationState(this.publication, this.index, this.callback, this.setStatePublications);
}

// class _CardPublicationState extends State<CardPublication> {
//   @override
//   Widget build(BuildContext context) {
//     return Container();
//   }
// }


class _CardPublicationState extends State<CardPublication> {

  late Function callback;
  late Function setStatePublications;
  late Publication publication;
  late int index;
  bool imageValidator = true;
  String defaultPetImage = "https://img.freepik.com/vector-gratis/pata-diseno-logotipo-mascota-vector-negocio-tienda-animales_53876-136741.jpg?w=2000";


  _CardPublicationState(
      this.publication, this.index, this.callback, this.setStatePublications,);
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.indigo,
      child: Column(
        children: <Widget>[
          Container(
            child: Ink.image(
              image: NetworkImage(imageValidator?publication.image:defaultPetImage),
              onImageError: (a,b){
                setState(() {
                  imageValidator = false;
                });
              },
              height: 200,
              fit: BoxFit.cover,
            ),
          ),
          padding(Text(
            publication.comment,
            style: const TextStyle(
                fontSize: 18.0,
                fontFamily: "Roboto",
                fontWeight: FontWeight.bold,
                color: Colors.white),
          )),
          Row(
            children: <Widget>[
              padding(
                ElevatedButton.icon(
                  icon: Icon(Icons.edit),
                  onPressed: () {
                    _openPopup(
                        context, publication, index, setStatePublications);
                  },
                  label: Text('Editar'),
                ),
              ),
              padding(
                ElevatedButton.icon(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    print(publication);
                    print(index);
                    callback(publication, index);
                  },
                  label: Text('Eliminar'),
                ),
              ),
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

_openPopup(
    context, Publication _publication, int index, _setStatePublications) async {
  Function setStatePublications;
  setStatePublications = _setStatePublications;
  Publication publication = _publication;

  Alert(
      context: context,
      title: "Editar mascota",
      content: Column(
        children: <Widget>[
          TextField(
            decoration: InputDecoration(
              labelText: 'comentario',
            ),
            controller: TextEditingController(text: publication.comment),
            onChanged: (comment) => {publication.comment = comment},
          ),
        ],
      ),
      buttons: [
        DialogButton(
          // onPressed: ()=>{print(publication.name)},
          onPressed: () => {
            Navigator.of(context, rootNavigator: true).pop(),
            setStatePublications(publication, index)
          },
          child: Text(
            "Enviar",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
        )
      ]).show();

}

_openPopupAdoptar(
    context, Publication _publication, int index, int userId,  _setStatePublications, _setStateNotifications) async {
  Function setStatePublications;
  Function setStateNotifications;
  setStateNotifications = _setStateNotifications;
  setStatePublications = _setStatePublications;
  Publication publication = _publication;
  AdoptionRequest adoptionRequest = AdoptionRequest(userId, publication.userId, publication.publicationId, "", 0, publication.petId);

  Alert(
      context: context,
      title: "Enviar Solicitud de adopción",
      content: Column(
        children: <Widget>[
          TextField(
            decoration: InputDecoration(
              labelText: 'Envie un mensaje al dueño',
            ),
            controller: TextEditingController(text: adoptionRequest.message),
            onChanged: (message) => {adoptionRequest.message = message},
          ),
        ],
      ),
      buttons: [
        DialogButton(
          // onPressed: ()=>{print(publication.name)},
          onPressed: () => {
            Navigator.of(context, rootNavigator: true).pop(),
            setStateNotifications(adoptionRequest)
          },
          child: Text(
            "Enviar",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
        )
      ]).show();

}

class CardPublicationGeneral extends StatefulWidget {
  // const CardPublicationGeneral({Key? key}) : super(key: key);

  late Function callback;
  late Function setStatePublications;
  late Function setStateNotifications;
  late Publication publication;
  late int index;
  late int userId;

  CardPublicationGeneral(
      this.publication, this.index, this.callback, this.setStatePublications, this.setStateNotifications, this.userId,
      );

  @override
  State<CardPublicationGeneral> createState() => _CardPublicationGeneralState(this.publication, this.index, this.callback, this.setStatePublications, this.setStateNotifications, this.userId,);
}

// class _CardPublicationGeneralState extends State<CardPublicationGeneral> {
//   @override
//   Widget build(BuildContext context) {
//     return Container();
//   }
// }


class _CardPublicationGeneralState extends State<CardPublicationGeneral> {
  late Function callback;
  late Function setStatePublications;
  late Function setStateNotifications;
  late Publication publication;
  late int index;
  late int userId;
  bool imageValidator = true;
  String defaultPetImage = "https://img.freepik.com/vector-gratis/pata-diseno-logotipo-mascota-vector-negocio-tienda-animales_53876-136741.jpg?w=2000";
  // final prefs = await SharedPreferences.getInstance();
  // final counter = prefs.getInt('userId') ?? 0;
  _CardPublicationGeneralState(
      this.publication, this.index, this.callback, this.setStatePublications, this.setStateNotifications, this.userId,
      );
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.indigo,
      child: Column(
        children: <Widget>[
          Container(
            child: Ink.image(
              image: NetworkImage(imageValidator?publication.image:defaultPetImage),
              onImageError: (a,b){
                setState(() {
                  imageValidator = false;
                });

              },
              height: 200,
              fit: BoxFit.cover,
            ),
          ),
          padding(Text(
            publication.comment,
            style: const TextStyle(
                fontSize: 18.0,
                fontFamily: "Roboto",
                fontWeight: FontWeight.bold,
                color: Colors.white),
          )),
          Row(
            children: <Widget>[
              padding(
                (userId == publication.userId)?Text(''):
                ElevatedButton.icon(
                  icon: Icon(Icons.add),
                  onPressed: () {
                    _openPopupAdoptar(
                        context, publication, index, userId, setStatePublications, setStateNotifications);
                  },

                  label: Text('Adoptar'),
                ),
              ),

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


