import 'dart:convert';

import 'package:http/http.dart' as http;

class ListPublicationsService{
  Future<http.Response> getAllPets() async{
    final response = await http.get(Uri.parse("https://timexp.xempre.com/api/v1/publications"));

    return response;
  }

  Future<http.Response> getPublicationsByUserId(id) async{
    final response = await http.get(Uri.parse('https://timexp.xempre.com/api/v1/pets/userid=$id'));
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
}