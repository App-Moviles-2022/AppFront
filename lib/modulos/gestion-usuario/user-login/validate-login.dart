/*import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:flutter/foundation.dart';
import 'dart:async';

class User {
  int userId;
  String name;
  String email;
  String phone;
  String type;
  String token;
  String renewalToken;

  User({ required this.userId, required this.name, required this.email, required this.phone,required  this.type, required this.token,required  this.renewalToken});

  factory User.fromJson(Map<String, dynamic> responseData) {
    return User(
        userId: responseData['id'],
        name: responseData['name'],
        email: responseData['email'],
        phone: responseData['phone'],
        type: responseData['type'],
        token: responseData['access_token'],
        renewalToken: responseData['renewal_token']
    );
  }
}

class AppUrl {
  static const String liveBaseURL = "https://remote-ur/api/v1";
  static const String localBaseURL = "http://10.0.2.2:4000/api/v1";

  static const String baseURL = liveBaseURL;
  static const String login = baseURL + "/session";
  static const String register = baseURL + "/registration";
  static const String forgotPassword = baseURL + "/forgot-password";
}

enum Status {
  NotLoggedIn,
  NotRegistered,
  LoggedIn,
  Registered,
  Authenticating,
  Registering,
  LoggedOut
}

class AuthProvider with ChangeNotifier {

  Status _loggedInStatus = Status.NotLoggedIn;
  Status _registeredInStatus = Status.NotRegistered;

  Status get loggedInStatus => _loggedInStatus;
  Status get registeredInStatus => _registeredInStatus;


  Future<Map<String, dynamic>> login(String email, String password) async {
    var result;

    final Map<String, dynamic> loginData = {
      'user': {
        'email': email,
        'password': password
      }
    };

    _loggedInStatus = Status.Authenticating;
    notifyListeners();
   // final response = await http.get(Uri.parse("https://timarq.xempre.com/api/v1/pets"));
    Response response = await post(
      Uri.parse(AppUrl.login),
      body: json.encode(loginData),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);

      var userData = responseData['data'];

      User authUser = User.fromJson(userData);

      UserPreferences().saveUser(authUser);

      _loggedInStatus = Status.LoggedIn;
      notifyListeners();

      result = {'status': true, 'message': 'Successful', 'user': authUser};
    } else {
      _loggedInStatus = Status.NotLoggedIn;
      notifyListeners();
      result = {
        'status': false,
        'message': json.decode(response.body)['error']
      };
    }
    return result;
  }

  Future<Map<String, dynamic>> register(String email, String password, String passwordConfirmation) async {

    final Map<String, dynamic> registrationData = {
      'user': {
        'email': email,
        'password': password,
        'password_confirmation': passwordConfirmation
      }
    };


    _registeredInStatus = Status.Registering;
    notifyListeners();

    return await post(AppUrl.register,
        body: json.encode(registrationData),
        headers: {'Content-Type': 'application/json'})
        .then(onValue)
        .catchError(onError);
  }

  static Future<FutureOr> onValue(Response response) async {
    var result;
    final Map<String, dynamic> responseData = json.decode(response.body);

    if (response.statusCode == 200) {

      var userData = responseData['data'];

      User authUser = User.fromJson(userData);

      UserPreferences().saveUser(authUser);
      result = {
        'status': true,
        'message': 'Successfully registered',
        'data': authUser
      };
    } else {

      result = {
        'status': false,
        'message': 'Registration failed',
        'data': responseData
      };
    }

    return result;
  }

  static onError(error) {
    print("the error is $error.detail");
    return {'status': false, 'message': 'Unsuccessful Request', 'data': error};
  }

}

class UserProvider with ChangeNotifier {
  User _user = new User();

  User get user => _user;

  void setUser(User user) {
    _user = user;
    notifyListeners();
  }
}


class UserPreferences {
  Future<bool> saveUser(User user) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setInt("userId", user.userId);
    prefs.setString("name", user.name);
    prefs.setString("email", user.email);
    prefs.setString("phone", user.phone);
    prefs.setString("type", user.type);
    prefs.setString("token", user.token);
    prefs.setString("renewalToken", user.renewalToken);

    return prefs.commit();
  }

  Future<User> getUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    int userId = prefs.getInt("userId");
    String name = prefs.getString("name");
    String email = prefs.getString("email");
    String phone = prefs.getString("phone");
    String type = prefs.getString("type");
    String token = prefs.getString("token");
    String renewalToken = prefs.getString("renewalToken");

    return User(
        userId: userId,
        name: name,
        email: email,
        phone: phone,
        type: type,
        token: token,
        renewalToken: renewalToken);
  }

  void removeUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.remove("name");
    prefs.remove("email");
    prefs.remove("phone");
    prefs.remove("type");
    prefs.remove("token");
  }

  Future<String> getToken(args) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString("token");
    return token;
  }
}*/
import 'package:appfront/modulos/gestion-usuario/models/client.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class Modelo {
  static Future<bool> iniciarSesion(String email, String password) async {
    final response = await http.post(
        Uri.parse("https://timexp.xempre.com/api/v1/users/auth/sign-in"),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: jsonEncode(<String, String>{
          'userNick': email,
          'pass': password,
        }),
        encoding: utf8
    );
    var body = json.decode(response.body);
    print(body);
    // print(jsonDecode(body));
    // print(response.statusCode);
    if (response.statusCode == 200) {
  // obtain shared preferences
        final prefs = await SharedPreferences.getInstance();
  // set value
        await prefs.setInt('userId', body['id']);

        // User user = User.fromJson(body);
        // print("PERRRRRRO");
        // print(user);

        await prefs.setString('user', jsonEncode(body));


      return true;
    }
    else{
      return false;
  }

}










/*static Future<bool> registrar(String name, String password) async {
    var response = await http.post(
        Uri.parse('https://timexp.xempre.com/api/v1/users/auth/sign-in'),
        headers: {"Content-type": "application/json"},
        body: json.encode({"name": name}));
    if (response.statusCode == 200) {
      if (response.body.length > 0) {
        var usuario = json.decode(response.body);
        print("Usuario: " + usuario.toString());
        return true;
      }
    }
    return false;
  }*/
}

Future<http.Response> postPublication() async{

  String email="Camilo";
//https://timarq.xempre.com/api/v1/users"
  var response = await http.post(Uri.parse("https://timarq.xempre.com/api/v1/pets"),
      encoding: utf8
  );
  // String body = utf8.decode(response.bodyBytes);
  // print(jsonDecode(body));
  print("tercerintento");
  print(response.statusCode);
  return response;
}


Future<http.Response> funcionaporfa() async {

  String email="user";
  final responsefinal = await http.post(
    encoding: utf8,
    Uri.parse(
        'https://timarq.xempre.com/api/v1/users'),
    headers: {
      'Content-type': 'application/json',
      'Accept': 'application/json',
    },

    body: jsonEncode(<String, String>{
      'userNick': email,
    }),

  );


  // if (responsefinal.statusCode == 200) {}

  print("ola");
  print(responsefinal.statusCode);
  return responsefinal;
}
