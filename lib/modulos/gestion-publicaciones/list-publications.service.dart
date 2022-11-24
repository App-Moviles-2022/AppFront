import 'dart:convert';

import 'package:appfront/modulos/gestion-pet/models/pet.dart';
import 'package:appfront/modulos/gestion-publicaciones/models/publication.dart';
import 'package:http/http.dart' as http;

class ListPublicationsService{
  Future<http.Response> getPublicationsPetsInfo() async{
    final response = await http.get(Uri.parse("https://timexp.xempre.com/api/v1/publications/petsinfo"));
    return response;
  }

  Future<http.Response> getPetsByUserId(userId) async{
    final response = await http.get(Uri.parse("https://timexp.xempre.com/api/v1/pets/userid=$userId"));
    return response;
  }

  Future<http.Response> getPublicationsByUserId(id) async{
    final response = await http.get(Uri.parse('https://timexp.xempre.com/api/v1/publications/petsinfo/$id'));
    return response;
  }

  Future<http.Response> getPetById(id) async{
    final response = await http.get(Uri.parse('https://timexp.xempre.com/api/v1/pets/$id'));
    return response;
  }
  Future<http.Response> updatePet(Pet pet) async{
    final response = await http.put(Uri.parse("https://timexp.xempre.com/api/v1/pets/${pet.id}"),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: jsonEncode(
            {
          "type": pet.type,
          "name": pet.name,
          "attention": pet.attention,
          "age": pet.age,
          "race": pet.race,
          "isAdopted": pet.isAdopted,
          "userId": pet.userId,
          "isPublished": pet.isPublished,
          "gender": pet.gender,
          "urlToImage": pet.urlToImage
        }),
        encoding: utf8
    );
    return response;
  }

  Future<http.Response> postPublication(publication) async{
    final response = await http.post(Uri.parse("https://timexp.xempre.com/api/v1/publications"),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: jsonEncode(publication),
        encoding: utf8
    );
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

  Future<http.Response> updatePublication(publicationId, Publication data) async{
    print(data.petId);
    print(data.publicationId);
    print(data.userId);
    print(data.comment);
    final response = await http.put(Uri.parse("https://timexp.xempre.com/api/v1/publications/${data.publicationId}"),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        "petId": data.petId,
        "userId": data.userId,
        "dateTime": "2022-05-05",
        "comment": data.comment
      }),
      encoding: utf8
    );
    print(data);
    print(jsonEncode(data));
    // String body = utf8.decode(response.bodyBytes);
    // print(jsonDecode(body));
    return response;
  }

  Future<http.Response> enviarSolicitud(AdoptionRequest solicitud) async{
    final response = await http.post(Uri.parse("https://timexp.xempre.com/api/v1/adoptionsrequests"),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          "message": solicitud.message,
          "status": 0,
          "userIdFrom": solicitud.userIdFrom,
          "userIdAt": solicitud.userIdAt,
          "publicationId": solicitud.publicationId
        }),
        encoding: utf8
    );

    return response;
  }

}
