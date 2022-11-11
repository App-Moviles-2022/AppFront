import 'dart:convert';

import 'package:appfront/modulos/gestion-usuario/ui/announcement_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../gestion-announcements/models/announcement.dart';



class Manage_Announcements extends StatefulWidget{
  const Manage_Announcements({Key? key}) : super(key: key);
  @override
  State<Manage_Announcements> createState()=>Manage_AnnouncementsState();

}

class Manage_AnnouncementsState extends State<Manage_Announcements>{
  final List<Announcement> announcements = <Announcement>[];
  final TextStyle biggerFont = TextStyle(fontSize: 18);

  final Set<Announcement> saved= Set<Announcement>();

  final List<Announcement> data=[];
  AnnouncementDialog? dialog;
  Future<http.Response> getadds() async{
    final response = await http.get(Uri.parse("https://timexp.xempre.com/api/v1/advertisements"));
    return response;
  }
  Future<String> deleteAnnouncement(int id) async{
    final response = await http.delete(
        Uri.parse("https://timexp.xempre.com/api/v1/advertisements/${id}"),
        headers: {'Content-type': 'application/json'},
        encoding: Encoding.getByName("utf-8")
    );
    return response.body;
  }
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text("Mis Anuncios"),
        actions: <Widget>[
          IconButton(onPressed: addAnnouncement, icon: Icon(Icons.add)),
        ],
      ),
      body: buildAnnouncements(),

    );
  }

  @override
  void initState(){
    dialog = AnnouncementDialog();
    super.initState();
    getadds().then((value) => {
      setState(() {
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
          ));
        }
      }),

    });
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
        return buildRow(announcements[i]);
      },
      itemCount: data.length,
    );
  }

  Widget buildRow(Announcement announcement) {
    return Card(
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        child: Column(children: [
          Stack(
            children: [
              Ink.image(image: NetworkImage(
                  announcement.urlToImage
              ),
                height: 300,
                fit: BoxFit.cover,
              ),
              Positioned(
                  bottom: 16,
                  right: 16,
                  left: 16,
                  child: Text(announcement.title,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                      fontSize: 24,
                    ),
                  )
              )

            ],
          ),
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