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


  Future<http.Response> getReservas() async{
    final response = await http.get(Uri.parse("https://676g5lt3y5.execute-api.us-east-1.amazonaws.com/dev/obtener-reservas-cliente?id_persona=4"));
    setState(() {
      String body = utf8.decode(response.bodyBytes);
      print(jsonDecode(body)[0]['id_reserva']);
    });

    return response;
  }

  @override
  void initState(){
    super.initState();
    getReservas();
  }

  List<Publication> publications = [
    Publication("Pedrito es un gran amigo", "https://image.cnbcfm.com/api/v1/image/106686172-1598966433320-gettyimages-1152439648-istockalypse-home-office-00062.jpeg?v=1599013160",
        DateTime(2022, 1, 1, 24, 0, 0), Colors.white60,
        "Pedrito", "Subtitle demo"
    ),
    Publication("A Loqui le encanta jugar", "https://image.cnbcfm.com/api/v1/image/106686172-1598966433320-gettyimages-1152439648-istockalypse-home-office-00062.jpeg?v=1599013160",
        DateTime(2022, 1, 1, 24, 0, 0), Colors.white60,
        "Loqui", "Subtitle demo"
    ),
    Publication("Siempre te recibirá con una sonrisa", "https://image.cnbcfm.com/api/v1/image/106686172-1598966433320-gettyimages-1152439648-istockalypse-home-office-00062.jpeg?v=1599013160",
        DateTime(2022, 1, 1, 24, 0, 0), Colors.white60,
        "Duno", "Subtitle demo"
    )
  ];
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
