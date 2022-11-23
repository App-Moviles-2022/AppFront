import 'dart:convert';
import 'dart:io';
import 'package:appfront/database/db_helper.dart';
import 'package:appfront/modulos/gestion-publicaciones/custom-widgets/publication-card.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../gestion-pet/models/pet.dart';
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
  List<Publication> allPublications = [];
  List<Pet> pets = [];

  void callback(publication, index) {
    listPublicationsService
        .deletePublication(publication.publicationId)
        .then((value) => {
          publications.removeAt(index),
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

  void setStateNotifications(AdoptionRequest adoptionRequest) {
    listPublicationsService
        .enviarSolicitud(adoptionRequest)
        .then((value) => {
      setState(() {
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
                  }),
          listPublicationsService.getPetsByUserId(userId).then((value) => {
                setState(() {
                  String body = utf8.decode(value.bodyBytes);
                  print(body);
                  for (var element in jsonDecode(body)) {
                    pets.add(Pet(
                        element['id'],
                        element['type'],
                        element['name'],
                        element['attention'],
                        element['age'],
                        element['race'],
                        element['userId'],
                        element['publicationId'],
                        element['gender'],
                        element['urlToImage'],
                        element['isAdopted'],
                        element['isPublished']));
                  }
                }),
              }),
      listPublicationsService
          .getPublicationsPetsInfo()
          .then((value) => {
        setState(() {
          String body = utf8.decode(value.bodyBytes);
          for (var element in jsonDecode(body)) {
            allPublications.add(Publication(
                element['publicationId'],
                element['petId'],
                element['userId'],
                element['type'],
                element['image'],
                element['name'],
                element['comment']));
          }
        }),
      }),

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
                  itemCount: allPublications.length,
                  itemBuilder: (BuildContext context, int index) {
                    return CardPublicationGeneral(allPublications[index], index, callback,
                        setStatePublications,setStateNotifications, userId);
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
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ListPetsState()),
                );
                // _openPopupAddPub(context);
              },
            )),
      ),
    );
  }


  Widget padding(Widget widget) {
    return Padding(padding: const EdgeInsets.all(7.0), child: widget);
  }

  _openPopupAddPub(context) async {
    late ListPublicationsService listPublicationsService =
        ListPublicationsService();

    Publication publication = Publication(0, 0, 0, "", "", "", "");
    final prefs = await SharedPreferences.getInstance();
    final counter = prefs.getInt('userId') ?? 0;
    String petId = "0";
    final List<String> list = ["a", "b"];
    String? dropdownValue = list.first;

    Alert(
        context: context,
        title: "Agregar Publicación",
        content: Column(
          children: <Widget>[

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

class ListPetsState extends StatefulWidget {
  const ListPetsState({Key? key}) : super(key: key);

  @override
  State<ListPetsState> createState() => _ListPetsState();
}

class _ListPetsState extends State<ListPetsState> {
  late ListPublicationsService listPublicationsService =
  ListPublicationsService();
  int userId = 0;
  List<Pet> pets = [];

  Future<int> retrieveUser() async {
    final prefs = await SharedPreferences.getInstance();
    final counter = prefs.getInt('userId') ?? 0;
    return counter;
  }

  @override
  void initState() {
    super.initState();
    retrieveUser().then((value) => {
      userId = value,
      listPublicationsService.getPetsByUserId(userId).then((value) => {
        setState(() {
          String body = utf8.decode(value.bodyBytes);
          print(body);
          for (var element in jsonDecode(body)) {
            pets.add(Pet(
                element['id'],
                element['type'],
                element['name'],
                element['attention'],
                element['age'],
                element['race'],
                element['userId'],
                element['publicationId'],
                element['gender'],
                element['urlToImage'],
                element['isAdopted'],
                element['isPublished']));
          }
        }),
      })
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Second Route'),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              itemCount: pets.length,
              itemBuilder: (BuildContext context, int index){
                return padding(ListTile(
                  title: Text(pets[index].name.toString()),
                  leading: Image.network("https://blog.mystart.com/wp-content/uploads/shutterstock_224423782-1-e1527774744419.jpg"),
                  trailing: IconButton(
                    icon: const Icon(Icons.add_circle),
                    tooltip: "Aceptar",
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => FormNewPublication(pets[index]))
                      );
                  },),
                ));
              },
            ),
          ),
        ],
      ),

    );
  }

  Widget padding(Widget widget) {
    return Padding(padding: const EdgeInsets.all(7.0), child: widget);
  }
}
class FormNewPublication extends StatelessWidget {
  Pet pet;
  Publication publication = Publication(0, 0, 0, "", "", "", "");
  FormNewPublication(this.pet, {Key? key}) : super(key: key);
  late ListPublicationsService listPublicationsService =
  ListPublicationsService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Form"),
        ),
        body: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                labelText: 'Nombre del pet',
              ),
              controller: TextEditingController(text: pet.name),
              onChanged: (comment) => {},
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
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.red,
          child: const Icon(
            Icons.check,
            color: Colors.white,
            size: 36.0,
          ),
          onPressed: () {

            listPublicationsService.postPublication({
              "petId": pet.id,
              "userId": pet.userId,
              "dateTime": "2022/11/12",
              "comment": publication.comment
            }).then((res) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ListPublications()),
              );
            });
          },
        )
    );
  }
}


