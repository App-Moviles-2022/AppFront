import 'dart:convert';
import 'package:appfront/database/db_helper.dart';
import 'package:appfront/modulos/gestion-publicaciones/custom-widgets/publication-card.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'models/publication.dart';

class ListPublications extends StatefulWidget {
  const ListPublications({Key? key}) : super(key: key);

  @override
  State<ListPublications> createState() => _ListPublicationsState();
}


class _ListPublicationsState extends State<ListPublications> {
  late http.Response temp;
  // List<Publication> publications = [
  //   Publication("Pedrito es un gran amigo", "https://image.cnbcfm.com/api/v1/image/106686172-1598966433320-gettyimages-1152439648-istockalypse-home-office-00062.jpeg?v=1599013160",
  //       DateTime(2022, 1, 1, 24, 0, 0), Colors.white60,
  //       "Pedrito", "Subtitle demo"
  //   ),
  //   Publication("A Loqui le encanta jugar", "https://image.cnbcfm.com/api/v1/image/106686172-1598966433320-gettyimages-1152439648-istockalypse-home-office-00062.jpeg?v=1599013160",
  //       DateTime(2022, 1, 1, 24, 0, 0), Colors.white60,
  //       "Loqui", "Subtitle demo"
  //   ),
  //   Publication("Siempre te recibirá con una sonrisa", "https://image.cnbcfm.com/api/v1/image/106686172-1598966433320-gettyimages-1152439648-istockalypse-home-office-00062.jpeg?v=1599013160",
  //       DateTime(2022, 1, 1, 24, 0, 0), Colors.white60,
  //       "Duno", "Subtitle demo"
  //   )
  // ];
  List<Publication> publications = [];


  Future<http.Response> getPets() async{
    final response = await http.get(Uri.parse("https://timarq.xempre.com/api/v1/pets"));
    // setState(() {
    //   String body = utf8.decode(response.bodyBytes);
    //   print(jsonDecode(body)[0]['id']);
    // });

    return response;
  }

  @override
  void initState(){
    super.initState();
    getPets().then((value) => {
      setState(() {
      String body = utf8.decode(value.bodyBytes);
      for(var element in jsonDecode(body)){
        publications.add(Publication(element['type'], element['urlToImage'], element['name']));
      }
      }),

    });
  }

  @override
  Widget build(BuildContext context) {
    DBHelper helper = DBHelper();
    helper.testDB();
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
