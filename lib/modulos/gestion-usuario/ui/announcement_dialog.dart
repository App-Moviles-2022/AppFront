

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../gestion-announcements/models/announcement.dart';

class AnnouncementDialog{
  final txtTitle= TextEditingController();
  final txtDescription = TextEditingController();
  final txtUrlImage= TextEditingController();
  final txtDate= TextEditingController();

  Future<String> saveAnnouncement() async{
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
          'userId':3
        }),
        encoding: Encoding.getByName("utf-8")
    );
    return response.body;
  }
  Future<String> updateAnnouncement(int id) async{
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
          'userId':3
        }),
        encoding: Encoding.getByName("utf-8")
    );
    return response.body;
  }

  Widget buildDialog(BuildContext context,Announcement announcement, bool isNew ){
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