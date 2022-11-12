import 'dart:convert';

import 'package:appfront/modulos/gestion-publicaciones/models/publication.dart';
import 'package:http/http.dart' as http;

class NotificationsService{
  Future<http.Response> getAllNotifications() async{
    final response = await http.get(Uri.parse("https://timexp.xempre.com/api/v1/adoptionsrequests"));
    return response;
  }

  Future<http.Response> getNotificationsByUserId(id) async{
    final response = await http.get(Uri.parse('https://timexp.xempre.com/api/v1/publications/petsinfo/$id'));
    return response;
  }

  Future<http.Response> postNotification(publication) async{
    final response = await http.post(Uri.parse("https://timexp.xempre.com/api/v1/publications"),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: jsonEncode(publication),
        encoding: utf8
    );
    return response;
  }

  Future<http.Response> deleteNotification(id) async{
    final response = await http.delete(Uri.parse("https://timexp.xempre.com/api/v1/publications/$id"),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
    );
    // String body = utf8.decode(response.bodyBytes);
    // print(jsonDecode(body));
    return response;
  }

  Future<http.Response> updateNotification(petId, data) async{
    final response = await http.put(Uri.parse("https://timexp.xempre.com/api/v1/pets/$petId"),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: jsonEncode(data),
        encoding: utf8
    );
    print(data);
    print(jsonEncode(data));
    // String body = utf8.decode(response.bodyBytes);
    // print(jsonDecode(body));
    return response;
  }

}
