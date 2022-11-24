import 'dart:convert';
import 'package:appfront/modulos/gestion-publicaciones/custom-widgets/publication-card.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../gestion-pet/models/pet.dart';
import 'list-publications.service.dart';
import 'models/publication.dart';

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
                loadData();
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
    Pet pet;
    retrieveUser().then((value) {
    adoptionRequest.userIdFrom = value;
        listPublicationsService
        .enviarSolicitud(adoptionRequest)
        .then((value) => {

        listPublicationsService.getPetById(adoptionRequest.petId).then((responsePet) => {
          setState(() {
            String petBody = utf8.decode(responsePet.bodyBytes);
            pet = Pet(
                jsonDecode(petBody)["id"],
                jsonDecode(petBody)["type"],
                jsonDecode(petBody)["name"],
                jsonDecode(petBody)["attention"],
                jsonDecode(petBody)["age"],
                jsonDecode(petBody)["race"],
                jsonDecode(petBody)["userId"],
                jsonDecode(petBody)["publicationId"],
                jsonDecode(petBody)["gender"],
                jsonDecode(petBody)["urlToImage"],
                jsonDecode(petBody)["isAdopted"],
                true);
            listPublicationsService.updatePet(pet).then((val) => {
              print("ACTUALIZACIÓN DEL PET EXITOSA")
            });
          }),
        }),
        setState(() {
          publications = publications;
        })
    });

    });


  }
  Future<void> loadData() async {
    int userId = await retrieveUser();
    http.Response myPublications = await listPublicationsService.getPublicationsByUserId(userId);
    http.Response myPets = await listPublicationsService.getPetsByUserId(userId);
    http.Response allPubs = await listPublicationsService.getPublicationsPetsInfo();
    setState(() {
      publications = [];
      allPublications = [];
      pets = [];

      String body = utf8.decode(myPublications.bodyBytes);
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

      body = utf8.decode(myPets.bodyBytes);

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

      body = utf8.decode(allPubs.bodyBytes);
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
    });
  }

  @override
  void initState() {
    super.initState();
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    // DBHelper helper = DBHelper();
    // helper.testDB();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
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
                RefreshIndicator(child: ListView.builder(
                  itemCount: allPublications.length,
                  itemBuilder: (BuildContext context, int index) {
                    return CardPublicationGeneral(allPublications[index], index, callback,
                        setStatePublications,setStateNotifications, userId);
                  },
                ), onRefresh: ()async{await loadData();}),
                RefreshIndicator(child: ListView.builder(
                  itemCount: publications.length,
                  itemBuilder: (BuildContext context, int index) {
                    return CardPublication(publications[index], index, callback,
                        setStatePublications);
                  },
                ), onRefresh: ()async{await loadData();})
              ],
            ),
            floatingActionButton: FloatingActionButton(
              backgroundColor: Colors.indigo,
              child: const Icon(Icons.add),
              onPressed: () async {
                await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ListPetsState()),
                );
                await loadData();
                // _openPopupAddPub(context);
              },
            )),
      ),
    );
  }


  Widget padding(Widget widget) {
    return Padding(padding: const EdgeInsets.all(7.0), child: widget);
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

  List<bool> imageValidator = [];
  String defaultPetImage = "https://img.freepik.com/vector-gratis/pata-diseno-logotipo-mascota-vector-negocio-tienda-animales_53876-136741.jpg?w=2000";

  Future<void> listPets() async {
    int userId = await retrieveUser();
    http.Response publications = await listPublicationsService.getPetsByUserId(userId);
    setState(() {
      String body = utf8.decode(publications.bodyBytes);
      imageValidator = [];
      for (var element in jsonDecode(body)) {
        imageValidator.add(true);
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
    });
  }

  @override
  void initState() {
    super.initState();
    listPets();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Pet'),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              itemCount: pets.length,
              itemBuilder: (BuildContext context, int index){
                return padding(ListTile(
                  title: Text(pets[index].name.toString()),
                  leading: CircleAvatar(backgroundImage:
                  NetworkImage(imageValidator[index]?pets[index].urlToImage.toString():defaultPetImage),
                    onBackgroundImageError: (a,b){
                    setState(() {
                      imageValidator[index] = false;
                    });

                    },),
                  trailing: IconButton(
                    icon: const Icon(Icons.add_circle),
                    tooltip: "Aceptar",
                    onPressed: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => FormNewPublication(pets[index]))
                      ).then((val) {
                        Navigator.pop(context);
                      });
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
              decoration: const InputDecoration(
                labelText: 'Nombre de la mascota',
              ),
              controller: TextEditingController(text: pet.name),
              onChanged: (comment) => {},
            ),
            TextField(
              decoration: const InputDecoration(
                labelText: 'Comentario adicional',
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
              Navigator.pop(context);
            });
          },
        )
    );
  }
}


