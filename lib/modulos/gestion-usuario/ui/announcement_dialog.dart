

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:open_street_map_search_and_pick/open_street_map_search_and_pick.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:location/location.dart';
import 'package:syncfusion_flutter_maps/maps.dart';

import '../../gestion-announcements/models/announcement.dart';


class AnnouncementDialog{
  final txtTitle= TextEditingController();
  final txtDescription = TextEditingController();
  final txtUrlImage= TextEditingController();
  final txtDate= TextEditingController();

  double latitude = -12.0621065;
  double longitude = -77.0365256;



  Future<LocationData?> _currentLocation() async {
    bool serviceEnabled;
    PermissionStatus permissionGranted;

    Location location = new Location();

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return null;
      }
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return null;
      }
    }

    return await location.getLocation();
  }



  Future<String> saveAnnouncement() async{
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getInt('userId') ?? 0;
    final response = await http.post(
        Uri.parse("https://timexp.xempre.com/api/v1/advertisements"),
        headers: {'Content-type': 'application/json'},
        body:jsonEncode(<String, dynamic>{
          'dateTime': txtDate.text,
          'title': txtTitle.text,
          'description':txtDescription.text,
          'discount':0,
          'urlToImage':txtUrlImage.text,
          'promoted':true,
          'userId':userId,
          'latitude': latitude.toString(),
          'longitude': longitude.toString()
        }),
        encoding: Encoding.getByName("utf-8")
    );
    return response.body;
  }
  Future<String> updateAnnouncement(int id) async{
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getInt('userId') ?? 0;
    final response = await http.put(
        Uri.parse("https://timexp.xempre.com/api/v1/advertisements/${id}"),
        headers: {'Content-type': 'application/json'},
        body:jsonEncode(<String, dynamic>{
          'dateTime': txtDate.text,
          'title': txtTitle.text,
          'description':txtDescription.text,
          'discount':0,
          'urlToImage':txtUrlImage.text,
          'promoted':true,
          'userId':userId,
          'latitude': latitude.toString(),
          'longitude': longitude.toString()
        }),
        encoding: Encoding.getByName("utf-8")
    );
    return response.body;
  }

  Widget buildDialog(BuildContext context,Announcement announcement, bool isNew ){

    var gato = _currentLocation().then((value) {latitude=value?.latitude as double; longitude=value?.longitude as double;});
    print(gato);
    print("PERRRRRRRO");

    if(!isNew){
      txtTitle.text=announcement.title;
      txtDate.text=announcement.dateTime;
      txtDescription.text=announcement.description;
      txtUrlImage.text=announcement.urlToImage;

    }
    else{
      txtTitle.text="";
      txtDescription.text="";
      txtUrlImage.text="";
      txtDate.text="";
    }
    return AlertDialog(
      title: Text((isNew)?"New Announcement" : "Edit Announcement"),
      content: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            TextField(
              controller: txtTitle,
              decoration: InputDecoration(
                hintText:"Title"
              ),
            ),
            TextField(
              controller: txtDescription,
              decoration: InputDecoration(
                hintText: "Description"
              ),
            ),
            TextField(
              controller: txtDate,
              decoration: InputDecoration(
                hintText: "Date"
              ),
            ),
            TextField(
              controller: txtUrlImage,
              decoration: InputDecoration(
                hintText: "Url of Image"
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 10),
              height: 300,
              child: OpenStreetMapSearchAndPick(center: LatLong(latitude??0,longitude??0), onPicked: (pickedData){
                latitude = pickedData.latLong.latitude;
                longitude = pickedData.latLong.longitude;
                print(pickedData.latLong.latitude);
                print(pickedData.latLong.longitude);
              },),
            ),

            ElevatedButton(onPressed: (){
              if(isNew){
                saveAnnouncement();
              }
              else{
                updateAnnouncement(announcement.id);
              }
              Navigator.pop(context);
              }, child: Text("Save"))

          ],
        ),
      ),
    );
  }


}