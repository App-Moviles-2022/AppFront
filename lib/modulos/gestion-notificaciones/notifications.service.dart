import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class NotificationsService{
  Future<http.Response> getAllNotificationsFrom() async{
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getInt('userId');

    final response = await http.get(Uri.parse("https://timexp.xempre.com/api/v1/adoptionsrequests/useridfrom=$userId"));
    return response;
  }

  Future<http.Response> getAllNotificationsAt() async{
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getInt('userId');

    final response = await http.get(Uri.parse("https://timexp.xempre.com/api/v1/adoptionsrequests/useridat=$userId"));
    return response;
  }

  Future<http.Response> markAdoptionRequestAsAccepted(id) async{
    final response = await http.put(Uri.parse('https://timexp.xempre.com/api/v1/adoptionsrequests/$id'),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: '{"message": "The owner accepted your adoption request.", "status": 1}',
        encoding: utf8);

    print(utf8.decode(response.bodyBytes));
    return response;
  }

  Future<http.Response> markAdoptionRequestAsRejected(id) async{
    final response = await http.put(Uri.parse('https://timexp.xempre.com/api/v1/adoptionsrequests/$id'),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: '{"message": "The owner accepted your adoption request.", "status": 2}',
        encoding: utf8);
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
