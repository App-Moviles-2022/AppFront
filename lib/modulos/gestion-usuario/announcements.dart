

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
    return Card(
          clipBehavior: Clip.antiAlias,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          child: Column(children: [
            Stack(
              children: [
                Ink.image(image: NetworkImage(
                    'https://image.cnbcfm.com/api/v1/image/106686172-1598966433320-gettyimages-1152439648-istockalypse-home-office-00062.jpeg?v=1599013160'
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
                ElevatedButton(
                    child: Text(
                      'Adopt pet',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 10,
                      ),
                    ),
                    onPressed: (){}
                ),
                ElevatedButton(
                    child: Text(
                      'More information',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 10),
                    ),
                    onPressed: (){}
                )
              ],
            )

          ],)

        );
  }
}