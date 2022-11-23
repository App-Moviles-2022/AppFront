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

  CardPublication(
      this.publication, this.index, this.callback, this.setStatePublications,
      {super.key});
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
      title: "Enviar Solicitud de adopción",
      content: Column(
        children: <Widget>[
          TextField(
            decoration: InputDecoration(
              labelText: 'Envie un mensaje al dueño',
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
            setStatePublications(publication, index)
          },
          child: Text(
            "Adoptar!",
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
  AdoptionRequest adoptionRequest = AdoptionRequest(userId, publication.userId, publication.publicationId, "", 1);

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



class CardPublicationGeneral extends StatelessWidget {
  Function callback;
  Function setStatePublications;
  Function setStateNotifications;
  Publication publication;
  int index;
  int userId;
  // final prefs = await SharedPreferences.getInstance();
  // final counter = prefs.getInt('userId') ?? 0;
  CardPublicationGeneral(
      this.publication, this.index, this.callback, this.setStatePublications, this.setStateNotifications, this.userId,
      {super.key});
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


