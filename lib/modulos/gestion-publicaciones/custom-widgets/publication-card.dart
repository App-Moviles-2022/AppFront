import 'package:appfront/modulos/gestion-publicaciones/models/publication.dart';
import 'package:flutter/material.dart';

class CardPublication extends StatelessWidget {
  Publication publication;
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
          padding(Text(publication.title, style: const TextStyle(fontSize: 18.0,
              fontFamily: "Roboto", fontWeight: FontWeight.bold, color: Colors.white),)),
          Row(
            children: <Widget>[
              padding(const Icon(Icons.pets, color: Colors.white70,)),
              padding(Text(publication.message, style: const TextStyle(fontSize: 16.0,
                  fontFamily: "Roboto", fontWeight: FontWeight.normal, color: Colors.white),))
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
