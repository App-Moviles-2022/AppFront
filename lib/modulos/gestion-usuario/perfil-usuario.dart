import 'dart:convert';
import 'dart:html';

import 'package:appfront/modulos/gestion-usuario/user-login/validate-login.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'login-user.dart';
import 'models/user.dart';

class PerfilUsuario extends StatefulWidget {
  // const PerfilUsuario({Key? key}) : super(key: key);
  @override
  State<PerfilUsuario> createState() => _PerfilUsuarioState();
}

// class _PerfilUsuarioState extends State<PerfilUsuario> {
//   @override
//   Widget build(BuildContext context) {
//     return Container();
//   }
// }



class _PerfilUsuarioState extends State<PerfilUsuario> {

  var user;
  bool imageValidator = false;
  String defaultProfileImage = "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png";

  Future get_user() async{
    final prefs = await SharedPreferences.getInstance();
    final userString = prefs.getString('user');

    var userMap = jsonDecode(userString!) ;
    user = userMap;
  }

  @override
  Widget build(BuildContext context) {

    get_user().then((value) {
      setState(() {
        user = user;
      });
    });

    try{
      return Scaffold(
        appBar: AppBar(title: Text("Profile"), backgroundColor: Colors.indigo,automaticallyImplyLeading: false,),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () async {
            Modelo.logout();
            Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => const TypeUserLogin()));
          },
          icon: Icon(Icons.close),
          label: Text("Logout"),
        ),
        body: ListView(
          children: <Widget>[
            Container(
              height: 250,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.indigo, Colors.indigo.shade300],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  stops: [0.5, 0.9],
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    user['type']??"",
                    style: TextStyle(
                      fontSize: 35,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      // CircleAvatar(
                      //   backgroundColor: Colors.indigo.shade300,
                      //   minRadius: 35.0,
                      //   child: Icon(
                      //     Icons.call,
                      //     size: 30.0,
                      //   ),
                      // ),
                      // CircleAvatar(
                      //   backgroundColor: Colors.white70,
                      //   minRadius: 60.0,
                      //   child: CircleAvatar(
                      //     radius: 50.0,
                      //     backgroundImage:
                      //     NetworkImage('https://scontent-lim1-1.xx.fbcdn.net/v/t1.6435-9/92951292_255301308960382_4037712537519652864_n.jpg?_nc_cat=106&ccb=1-7&_nc_sid=174925&_nc_eui2=AeE1Mu_bGS_3DUMlTvADPeMnMURlGSP4xzsxRGUZI_jHO1StJUARCUPAA5NxugFueET0Di4tZvmK6XrSpeKOaBfq&_nc_ohc=Vv1x6wrUirAAX8FgjgL&_nc_ht=scontent-lim1-1.xx&oh=00_AT9XEMEK2klgfu_QTBVMj-qOyok1lOKasD4cHflNCc2nrA&oe=637B81D2'),
                      //   ),
                      // ),

                      Container(
                          width: 120,
                          height: 120,
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: const BorderRadius.all(Radius.circular(60)),
                            border: Border.all(color: Colors.blueAccent, width: 2),
                            image: DecorationImage(
                                image: NetworkImage(imageValidator ? user.urlToImageProfile.toString() : defaultProfileImage),
                                onError: (a,b){

                                  setState(() {
                                    imageValidator = false;
                                  });

                                },
                                fit: BoxFit.cover),
                          )),

                      // CircleAvatar(
                      //   backgroundColor: Colors.indigo,
                      //   minRadius: 35.0,
                      //   child: Icon(
                      //     Icons.message,
                      //     size: 30.0,
                      //   ),
                      // ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    user['userNick']??"",
                    style: TextStyle(
                      fontSize: 35,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    "${user['name'] ?? ""} ${user['lastName']?? ""}",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                    ),
                  ),
                ],
              ),
            ),
            // Container(
            //   child: Row(
            //     children: <Widget>[
            //       Expanded(
            //         child: Container(
            //           color: Colors.indigo.shade300,
            //           child: ListTile(
            //             title: Text(
            //               '165',
            //               textAlign: TextAlign.center,
            //               style: TextStyle(
            //                 fontWeight: FontWeight.bold,
            //                 fontSize: 30,
            //                 color: Colors.white,
            //               ),
            //             ),
            //             subtitle: Text(
            //               'dias registrado',
            //               textAlign: TextAlign.center,
            //               style: TextStyle(
            //                 fontSize: 20,
            //                 color: Colors.white70,
            //               ),
            //             ),
            //           ),
            //         ),
            //       ),
            //       Expanded(
            //         child: Container(
            //           color: Colors.indigo,
            //           child: ListTile(
            //             title: Text(
            //               '2',
            //               textAlign: TextAlign.center,
            //               style: TextStyle(
            //                 fontWeight: FontWeight.bold,
            //                 fontSize: 30,
            //                 color: Colors.white,
            //               ),
            //             ),
            //             subtitle: Text(
            //               'mascotas adoptadas',
            //               textAlign: TextAlign.center,
            //               style: TextStyle(
            //                 fontSize: 20,
            //                 color: Colors.white70,
            //               ),
            //             ),
            //           ),
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
            Container(
              child: Column(
                children: <Widget>[
                  ListTile(
                    title: Text(
                      'Email',
                      style: TextStyle(
                        color: Colors.indigo,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                      user['email']??"",
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  ),
                  Divider(),
                  ListTile(
                    title: Text(
                      'Teléfono',
                      style: TextStyle(
                        color: Colors.indigo,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                      user['phone']??"",
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  ),
                  Divider(),
                  ListTile(
                    title: Text(
                      'DNI',
                      style: TextStyle(
                        color: Colors.indigo,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                      user['dni']??"",
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  ),
                  Divider(),
                  ListTile(
                    title: Text(
                      'RUC',
                      style: TextStyle(
                        color: Colors.indigo,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                      user['ruc']??"",
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  ),
                  Divider(),
                ],
              ),
            ),
          ],
        ),
      );
    }
    catch (e){
      return Container();
    }
  }
}

