import 'package:appfront/modulos/gestion-publicaciones/custom-widgets/publication-card.dart';
import 'package:flutter/material.dart';

import 'models/publication.dart';

class ListPublications extends StatefulWidget {
  const ListPublications({Key? key}) : super(key: key);

  @override
  State<ListPublications> createState() => _ListPublicationsState();
}

class _ListPublicationsState extends State<ListPublications> {
  List<Publication> publications = [
    Publication("Pedrito es un gran amigo", "../../img/pet1.jpg",
        DateTime(2022, 1, 1, 24, 0, 0), Colors.white60,
        "Pedrito", "Subtitle demo"
    ),
    Publication("A Loqui le encanta jugar", "../../img/pet2.jpg",
        DateTime(2022, 1, 1, 24, 0, 0), Colors.white60,
        "Loqui", "Subtitle demo"
    ),
    Publication("Siempre te recibirá con una sonrisa", "../../img/pet3.jfif",
        DateTime(2022, 1, 1, 24, 0, 0), Colors.white60,
        "Duno", "Subtitle demo"
    )
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: publications.length,
        itemBuilder: (BuildContext context, int index) {
          return CardPublication(publications[index]);
        }
      ),
    );
  }
}
