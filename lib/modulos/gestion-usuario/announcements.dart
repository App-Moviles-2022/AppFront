

import 'package:appfront/modulos/gestion-usuario/models/announcement.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Announcements extends StatefulWidget{
  const Announcements({Key? key}) : super(key: key);
  @override
  State<Announcements> createState()=>_AnnouncementsState();

}

class _AnnouncementsState extends State<Announcements> {
  final List<Announcement> announcements = <Announcement>[];
  final TextStyle biggerFont = TextStyle(fontSize: 18);

  final Set<Announcement> saved= Set<Announcement>();



  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text("Annuncios"),
        actions: <Widget>[IconButton(onPressed: pushSaved, icon: Icon(Icons.book))],
      ),
      body: buildAnnouncements(),

    );
  }
  Widget buildAnnouncements(){
    return ListView.builder(
      padding: EdgeInsets.all(15),
      itemBuilder: (BuildContext context, int i) {
        if (i.isOdd) {
          return Divider();
        }
        final int index=i ~/ 2;


        Announcement item1 = Announcement(dateTime: "martes",
            description: "aa",
            promoted: true,
            title: "nuevo anuncio"+"${i}",
            urlToImage: "adaiaduiaia");

        announcements.add(item1);

        return buildRow(announcements[index]);
      });
  }


  void pushSaved() {
  }

  Widget buildRow(Announcement announcement) {
    final bool alreadyView = saved.contains(announcement);
    return ListTile(
      title: Text(
        announcement.title,
        style: biggerFont,
      ),
      subtitle: Text(
        announcement.description
      )
      ,
      trailing: Icon(
        alreadyView ? Icons.read_more: Icons.read_more_outlined,
        color: alreadyView ? Colors.red : null,
      ),
      onTap: (){
        setState(() {
          alreadyView ? saved.remove(announcement) : saved.add(announcement);
        });
      },
    );

  }
}