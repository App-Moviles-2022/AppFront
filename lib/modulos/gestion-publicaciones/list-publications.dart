import 'dart:convert';
import 'dart:io';
import 'package:appfront/database/db_helper.dart';
import 'package:appfront/modulos/gestion-publicaciones/custom-widgets/publication-card.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:rflutter_alert/rflutter_alert.dart';
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
      print(body);
      for(var element in jsonDecode(body)){
        publications.add(
            Publication(
                element['publicationId'],
                element['petId'],
                element['type'],
                element['image'],
                element['name'],
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

                    // return CardPublication(publications[index]);
                    return Card(
                      color: Colors.indigo,
                      child: Column(
                        children: <Widget>[
                          Container(
                            child: Ink.image(
                              image: NetworkImage(publications[index].image),
                              height: 200,
                              fit: BoxFit.cover,
                            ),
                          ),
                          padding(Text(publications[index].name, style: const TextStyle(fontSize: 18.0,
                              fontFamily: "Roboto", fontWeight: FontWeight.bold, color: Colors.white),)),
                          Row(
                            children: <Widget>[
                              // padding(const Icon(Icons.pets, color: Colors.white70,)),
                              // padding(Text(publication.type, style: const TextStyle(fontSize: 16.0,
                              //     fontFamily: "Roboto", fontWeight: FontWeight.normal, color: Colors.white),)),
                              padding(ElevatedButton.icon(
                                icon: Icon(Icons.edit),
                                onPressed: (){
                                  _openPopup(context, publications[index]);
                                }, label: Text('Editar'),
                              ),),
                              padding(ElevatedButton.icon(
                                icon: Icon(Icons.delete),
                                onPressed: (){
                                  listPublicationsService.deletePublication(publications[index].publicationId).then((value) => {
                                    publications.remove(publications[index]),
                                    setState(() {
                                      publications = publications;
                                    })
                                  });
                                }, label: Text('Eliminar'),
                              ),),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
              ),
              ListView.builder(
                  itemCount: publications.length,
                  itemBuilder: (BuildContext context, int index) {

                    return CardPublication(publications[index]);
                  },
              ),
            ],
          ),
        ),
      ),

    );
  }
  Widget padding(Widget widget) {
    return Padding(padding: const EdgeInsets.all(7.0), child: widget);
  }

  _openPopup(context, Publication _publication) {
    Publication publication = _publication;
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
            onPressed: () => {listPublicationsService.updatePublication(publication.petId, {"name": publication.name, "urlseToImage": publication.image}).then((res){setState(() {
              publications = publications;
            }); }) } ,
            child: Text(
              "Actualizar",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          )
        ]).show();
  }
}
