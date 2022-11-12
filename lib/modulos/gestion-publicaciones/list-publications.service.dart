import 'dart:convert';

import 'package:http/http.dart' as http;

class ListPublicationsService{
  Future<http.Response> getAllPets() async{
    final response = await http.get(Uri.parse("https://timexp.xempre.com/api/v1/publications/petsinfo"));
    return response;
  }

  Future<http.Response> getPublicationsByUserId(id) async{
    final response = await http.get(Uri.parse('https://timexp.xempre.com/api/v1/publications/petsinfo/$id'));
    return response;
  }

  Future<http.Response> postPublication(data) async{
    final response = await http.post(Uri.parse("https://timexp.xempre.com/api/v1/users/auth/sign-in"),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: jsonEncode(data),
        encoding: utf8
    );
    // String body = utf8.decode(response.bodyBytes);
    // print(jsonDecode(body));
    return response;
  }

  Future<http.Response> deletePublication(id) async{
    final response = await http.delete(Uri.parse("https://timexp.xempre.com/api/v1/publications/$id"),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
    );
    // String body = utf8.decode(response.bodyBytes);
    // print(jsonDecode(body));
    return response;
  }

  Future<http.Response> updatePublication(petId, data) async{
    final response = await http.put(Uri.parse("https://timexp.xempre.com/api/v1/pets/$petId"),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(data),
      encoding: utf8
    );
    // String body = utf8.decode(response.bodyBytes);
    // print(jsonDecode(body));
    return response;
  }

}
