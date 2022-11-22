import 'dart:convert';

import 'package:appfront/modulos/gestion-usuario/ui/announcement_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'models/announcement.dart';



class Manage_Announcements extends StatefulWidget{
  const Manage_Announcements({Key? key}) : super(key: key);
  @override
  State<Manage_Announcements> createState()=>Manage_AnnouncementsState();

}

class Manage_AnnouncementsState extends State<Manage_Announcements>{
  String defaultImage = "https://definicion.de/wp-content/uploads/2009/07/descuento.jpg";
  List<bool> imageValidator = [];

  final List<Announcement> announcements = <Announcement>[];
  final TextStyle biggerFont = TextStyle(fontSize: 18);

  final Set<Announcement> saved= Set<Announcement>();

  List<Announcement> data=[];
  AnnouncementDialog? dialog;
  Future<http.Response> getAdds() async{
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getInt('userId') ?? 0;
    final response = await http.get(Uri.parse("https://timexp.xempre.com/api/v1/users/${userId}/advertisements"));
    return response;
  }
  Future<http.Response> deleteAnnouncement(int id) async{
    final response = await http.delete(
        Uri.parse("https://timexp.xempre.com/api/v1/advertisements/${id}"),
        headers: {'Content-type': 'application/json'},
        encoding: Encoding.getByName("utf-8")
    );
    return response;
  }
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: null,
      body: RefreshIndicator(child: buildAnnouncements(),onRefresh: ()async{await reloadAnnouncements();},),
      floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.indigo,
          child: const Icon(Icons.add,),
          onPressed: addAnnouncement)

    );
  }

  Future reloadAnnouncements() async{
    getAdds().then((value) => {
      setState(() {
        data = [];
        String body = utf8.decode(value.bodyBytes);
        for(var element in jsonDecode(body)){
          print(element['title']);
          data.add(Announcement(
              dateTime: element['dateTime'],
              id: element['id'],
              discount: element['discount'],
              description: element['description'],
              promoted: element['promoted'],
              title: element['title'],
              urlToImage: element['urlToImage'],
              latitude: element['latitude'],
              longitude: element['longitude']
          ));
        }
        imageValidator = List.filled(data.length, true, growable: true);
      }),

    });
  }

  @override
  void initState(){
    dialog = AnnouncementDialog();
    super.initState();
    reloadAnnouncements();
  }
  void addAnnouncement(){
    showDialog(context: context, builder: (BuildContext context)=>
        dialog!.buildDialog(context, Announcement(
            dateTime: '',
            description: '',
            promoted: false,
            title: '',
            id: 0,
            discount: 0,
            urlToImage: '',
          latitude: "0",
          longitude: "0"
        ),
            true)
    );
  }

  buildAnnouncements() {

    return ListView.builder(
      padding: EdgeInsets.all(15),
      itemBuilder: (BuildContext context, int i) {
        print(i);
        Announcement item1 = data[i];
        announcements.add(item1);
        return buildRow(data[i], i);
      },
      itemCount: data.length,
    );
  }

  Widget buildRow(Announcement announcement, int i) {
    return Card(
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        child: Column(children: [
          Stack(
            children: [
              Ink.image(image:
              NetworkImage(
                  imageValidator[i] ? announcement.urlToImage.toString() : defaultImage
              ),
                onImageError: (a,b){
                  setState(() {
                    imageValidator[i] = false;
                  });
                },


                height: 300,
                fit: BoxFit.cover,
              )
            ],
          ),
          Text(announcement.title??"", style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.indigo,
            fontSize: 24,
          )),
          Padding(
            padding: EdgeInsets.all(16).copyWith(bottom: 0),
            child: Text(announcement.description,
              style: TextStyle(fontSize: 16),
            ),
          ),
          ButtonBar(
            alignment: MainAxisAlignment.start,
            buttonPadding: EdgeInsets.all(16).copyWith(bottom: 5),
            children: [
              ElevatedButton.icon(
                  icon: Icon(Icons.edit),
                  onPressed: (){
                    showDialog(context: context, builder: (BuildContext context)=>
                        dialog!.buildDialog(context, announcement, false)
                    );
                  }, label: Text('Edit'),
              ),
              ElevatedButton.icon(
                icon: Icon(Icons.delete),
                onPressed: (){
                  deleteAnnouncement(announcement.id);
                }, label: Text('Delete'),
              ),
            ],
          )

        ],)

    );
  }

}