import 'dart:convert';

import 'package:appfront/modulos/gestion-announcements/announcement_details.dart';
import 'package:appfront/modulos/gestion-announcements/manage_announcements.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:open_street_map_search_and_pick/open_street_map_search_and_pick.dart';

import 'models/announcement.dart';

class Announcements extends StatefulWidget{
  const Announcements({Key? key}) : super(key: key);
  @override
  State<Announcements> createState()=>_AnnouncementsState();

}

class _AnnouncementsState extends State<Announcements> {

  String defaultImage = "https://definicion.de/wp-content/uploads/2009/07/descuento.jpg";
  List<bool> imageValidator = [];

  final List<Announcement> announcements = <Announcement>[];
  final TextStyle biggerFont = TextStyle(fontSize: 18);

  final Set<Announcement> saved= Set<Announcement>();


  /////////////////////////////////

  List<Announcement> dataAnounsement=[];
  Future<http.Response> getadds() async{
    final response = await http.get(Uri.parse("https://timexp.xempre.com/api/v1/advertisements"));
    // setState(() {
    //   String body = utf8.decode(response.bodyBytes);
    //   print(jsonDecode(body)[0]['id']);
    // });



    return response;
  }

  Future reloadAdds() async {

    getadds().then((value) => {

      setState(() {
        dataAnounsement = [];
        String body = utf8.decode(value.bodyBytes);
        for(var element in jsonDecode(body)){
          print(element['title']);
          dataAnounsement.add(Announcement(
              id: element['id'],
              discount: element['discount'],
              dateTime: element['dateTime'],
              description: element['description'],
              promoted: element['promoted'],
              title: element['title'],
              urlToImage: element['urlToImage'],
              latitude: element['latitude']??'0',
              longitude: element['longitude']??'0'
          ));
        }
        imageValidator = List.filled(dataAnounsement.length, true, growable: true);
      }),

    });
  }

  @override
  void initState(){
    super.initState();
    reloadAdds();
  }

  /////////////////////////////
  @override
  Widget build(BuildContext context){
    return
    MaterialApp(
      theme: ThemeData.from(colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo)),
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: Text("Announcements"),
            bottom: TabBar(
              onTap: (a){reloadAdds();},
            tabs: [
              Tab(icon: Icon(Icons.announcement),text: "All Announcements",),
              Tab(icon: Icon(Icons.person_pin_sharp),text: "My Announcements")
            ],
          ),
          ),
          body: TabBarView(children: [
            RefreshIndicator(child: buildAnnouncements(), onRefresh: ()async{await reloadAdds();})
            ,
            Manage_Announcements()
          ],),
        ),
      ),
    );
  }




  Widget buildAnnouncements(){
    return ListView.builder(
      padding: EdgeInsets.all(15),
      itemBuilder: (BuildContext context, int i) {
        print(i);
        Announcement item1 = dataAnounsement[i];
        announcements.add(item1);
        return buildRow(dataAnounsement[i], i);
      },
      itemCount: dataAnounsement.length,
    );
  }


  void goToManage() {
    Navigator.push(context, MaterialPageRoute(builder: (context)=> Manage_Announcements()));
  }
  void pushEdit(){}

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
              alignment: MainAxisAlignment.end,
              buttonPadding: EdgeInsets.all(16).copyWith(bottom: 5),
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(shape: CircleBorder()),
                    child: Icon(Icons.location_on,),
                    onPressed: (){
                      try{
                        LatLong latLongAnnouncement = LatLong(double.parse(announcement.latitude), double.parse(announcement.longitude));
                        Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => AnnouncementDetails(latLongAnnouncement)));
                      } catch (e){
                        Fluttertoast.showToast(msg: "Location could not be loaded.");
                      }

                    }
                )
              ],
            )

          ],)

        );
  }
}