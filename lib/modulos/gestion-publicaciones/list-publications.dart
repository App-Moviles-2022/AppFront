import 'dart:convert';
import 'dart:io';
import 'package:appfront/database/db_helper.dart';
import 'package:appfront/modulos/gestion-publicaciones/custom-widgets/publication-card.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'list-publications.service.dart';
import 'models/publication.dart';

class ListPublications extends StatefulWidget {
  const ListPublications({Key? key}) : super(key: key);

  @override
  State<ListPublications> createState() => _ListPublicationsState();
}


class _ListPublicationsState extends State<ListPublications> {
  late ListPublicationsService listPublicationsService = ListPublicationsService();

  late http.Response temp;
  List<Publication> publications = [];


  @override
  void initState(){
    super.initState();
    listPublicationsService.getAllPets().then((value) => {
      setState(() {
      String body = utf8.decode(value.bodyBytes);
      for(var element in jsonDecode(body)){
        publications.add(
            Publication(
                'Can',
                'http://c.files.bbci.co.uk/48DD/production/_107435681_perro1.jpg',
                'Name',
                element['comment']
            )
        );
      }
      }),

    });
  }

  @override
  Widget build(BuildContext context) {
    // DBHelper helper = DBHelper();
    // helper.testDB();
    return MaterialApp(
      theme: ThemeData.from(colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo)),
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            bottom: const TabBar(
              tabs: [
                Tab(icon: Icon(Icons.newspaper), text: "All Publications"),
                Tab(icon: Icon(Icons.pets), text: "My Publications"),
              ],
            ),
            title: const Text('Publications'),
          ),
          body: TabBarView(
            children: [
              ListView.builder(
                  itemCount: publications.length,
                  itemBuilder: (BuildContext context, int index) {
                    return CardPublication(publications[index]);
                  }
              ),
              ListView.builder(
                  itemCount: publications.length,
                  itemBuilder: (BuildContext context, int index) {
                    return CardPublication(publications[index]);
                  }
              ),
            ],
          ),
        ),
      ),

    );
  }
}
