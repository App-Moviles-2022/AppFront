import 'dart:convert';
import 'dart:io';
import 'package:appfront/database/db_helper.dart';
import 'package:appfront/modulos/gestion-publicaciones/custom-widgets/publication-card.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'list-publications.service.dart';
import 'models/publication.dart';
import 'package:intl/intl.dart';

class ListPublications extends StatefulWidget {
  const ListPublications({Key? key}) : super(key: key);

  @override
  State<ListPublications> createState() => _ListPublicationsState();
}

class _ListPublicationsState extends State<ListPublications> {
  late ListPublicationsService listPublicationsService =
      ListPublicationsService();
  int userId = 0;
  late http.Response temp;
  List<Publication> publications = [];

  void callback(publication) {
    listPublicationsService
        .deletePublication(publication.publicationId)
        .then((value) => {
              publications.remove(publication),
              setState(() {
                publications = publications;
              }),
            });
  }

  Future<int> retrieveUser() async {
    final prefs = await SharedPreferences.getInstance();
    final counter = prefs.getInt('userId') ?? 0;
    return counter;
  }

  void setStatePublications(Publication publication, index) {
    listPublicationsService
        .updatePublication(publication.publicationId, publication)
        .then((value) => {
              setState(() {
                publications[index] = publication;
                publications = publications;
              })
            });
  }

  @override
  void initState() {
    super.initState();
    retrieveUser().then((value) => {
      userId = value,
          listPublicationsService
              .getPublicationsByUserId(value)
              .then((value) => {
                    setState(() {
                      String body = utf8.decode(value.bodyBytes);
                      print(body);
                      for (var element in jsonDecode(body)) {
                        publications.add(Publication(
                            element['publicationId'],
                            element['petId'],
                            element['userId'],
                            element['type'],
                            element['image'],
                            element['name'],
                            element['comment']));
                      }
                    }),
                  })
        });
  }

  @override
  Widget build(BuildContext context) {
    // DBHelper helper = DBHelper();
    // helper.testDB();
    return MaterialApp(
      theme: ThemeData.from(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo)),
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
                    return CardPublication(publications[index], index, callback,
                        setStatePublications);
                  },
                ),
                ListView.builder(
                  itemCount: publications.length,
                  itemBuilder: (BuildContext context, int index) {
                    return CardPublication(publications[index], index, callback,
                        setStatePublications);
                  },
                ),
              ],
            ),
            floatingActionButton: FloatingActionButton(
              backgroundColor: Colors.indigo,
              child: const Icon(Icons.add),
              onPressed: () {
                _openPopupAddPub(context);
              },
            )),
      ),
    );
  }

  Widget padding(Widget widget) {
    return Padding(padding: const EdgeInsets.all(7.0), child: widget);
  }

  _openPopupAddPub(context) async {
    Publication publication = Publication(0, 0, 0, "", "", "", "");
    final prefs = await SharedPreferences.getInstance();
    final counter = prefs.getInt('userId') ?? 0;
    String petId = "0";
    DateFormat dateFormat = DateFormat("yyyy-MM-dd HH:mm:ss");
    Alert(
        context: context,
        title: "Agregar Publicación",
        content: Column(
          children: <Widget>[
            TextField(
              decoration: InputDecoration(
                labelText: 'petId',
              ),
              controller: TextEditingController(text: petId),
              onChanged: (_petId) => {petId = _petId},
            ),
            TextField(
              decoration: InputDecoration(
                labelText: 'comment',
              ),
              controller: TextEditingController(text: publication.comment),
              onChanged: (comment) => {publication.comment = comment},
            ),
          ],
        ),
        buttons: [
          DialogButton(
            onPressed: () => {
              listPublicationsService.postPublication({
                "petId": int.parse(petId),
                "userId": counter,
                "dateTime": "2022/11/12",
                "comment": publication.comment
              }).then((res) {
                setState(() {
                  String body = utf8.decode(res.bodyBytes);
                  print(jsonDecode(body));
                  publications.add(Publication(
                      jsonDecode(body)["id"],
                      jsonDecode(body)["petId"],
                      jsonDecode(body)["userId"],
                      "",
                      "",
                      "",
                      jsonDecode(body)["comment"]));
                });
              }),
            },
            child: Text(
              "Postear",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          )
        ]).show();
  }
}

class DemoPublication extends StatelessWidget {
  Function callback;
  DemoPublication(this.callback, {super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.indigo,
      child: ElevatedButton.icon(
        icon: Icon(Icons.account_circle_outlined),
        onPressed: () {
          this.callback();
        },
        label: Text('Ver perfil'),
      ),
    );
  }
}
