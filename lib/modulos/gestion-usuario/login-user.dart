import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class TypeUserLogin extends StatefulWidget {
  const TypeUserLogin({Key? key}) : super(key: key);

  @override
  _TypeUserLoginState createState() => _TypeUserLoginState();
}

class _TypeUserLoginState extends State<TypeUserLogin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold (
        body: Center(
            child: ListView(
                children: <Widget>[
                  Container(
                      padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                      child: Row(
                        children: <Widget>[
                          Expanded(child: Card(
                            elevation: 50,
                            shadowColor: Colors.black,
                            color: Colors.lightBlue[200],
                            child: SizedBox(
                              width: 300,
                              height: 500,
                              child: Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Column(
                                  children: [
                                    CircleAvatar(
                                      backgroundColor: Colors.lightBlue[900],
                                      radius: 108,
                                      child: const CircleAvatar(
                                        backgroundImage: NetworkImage(
                                            "https://www.wearetesters.com/wp-content/uploads/2018/11/MASCOTAS.jpg"), //NetworkImage
                                        radius: 100,
                                      ), //CircleAvatar
                                    ), //CircleAvatar
                                    const SizedBox(
                                      height: 10,
                                    ), //SizedBox
                                    Text(
                                      'Cliente',
                                      style: TextStyle(
                                        fontSize: 30,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500,
                                      ), //Textstyle
                                    ), //Text
                                    const SizedBox(
                                      height: 10,
                                    ), //SizedBox
                                    const Text(
                                      'Si estás interesado y te  gustaría adoptar a una mascota de forma rápida y segura ingresa aquí',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 15,
                                        color: Colors.white,
                                      ), //Textstyle
                                    ), //Text
                                    const SizedBox(
                                      height: 10,
                                    ), //SizedBox
                                    SizedBox(
                                      width: 120,

                                      child: ElevatedButton(
                                        onPressed: () => 'Null',
                                        style: ButtonStyle(
                                            backgroundColor:
                                            MaterialStateProperty.all(Colors.green)),
                                        child: Padding(
                                          padding: const EdgeInsets.all(4),
                                          child: Row(
                                            children: const [
                                              Icon(Icons.touch_app),
                                              Text('Ingresar')
                                            ],
                                          ),
                                        ),
                                      ),
                                      // RaisedButton is deprecated and should not be used
                                      // Use ElevatedButton instead

                                      // child: RaisedButton(
                                      //   onPressed: () => null,
                                      //   color: Colors.green,
                                      //   child: Padding(
                                      //     padding: const EdgeInsets.all(4.0),
                                      //     child: Row(
                                      //       children: const [
                                      //         Icon(Icons.touch_app),
                                      //         Text('Visit'),
                                      //       ],
                                      //     ), //Row
                                      //   ), //Padding
                                      // ), //RaisedButton
                                    ) //SizedBox
                                  ],
                                ), //Column
                              ), //Padding
                            ), //SizedBox
                          ), //Card//Card
                          ),//Card)
                        ],
                      )
                  ),
                  Container(
                      padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                      child: Row(
                        children: <Widget>[
                          Expanded(child: Card(
                            elevation: 50,
                            shadowColor: Colors.black,
                            color: Colors.lightBlue[200],
                            child: SizedBox(
                              width: 300,
                              height: 500,
                              child: Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Column(
                                  children: [
                                    CircleAvatar(
                                      backgroundColor: Colors.lightBlue[900],
                                      radius: 108,
                                      child: const CircleAvatar(
                                        backgroundImage: NetworkImage(
                                            "https://papelmatic.com/wp-content/uploads/2019/09/papelmatic-higiene-profesional-limpieza-desinfeccion-clinicas-veterinarias-1200x900.jpg"), //NetworkImage
                                        radius: 100,
                                      ), //CircleAvatar
                                    ), //CircleAvatar
                                    const SizedBox(
                                      height: 10,
                                    ), //SizedBox
                                    Text(
                                      'Veterinario',
                                      style: TextStyle(
                                        fontSize: 30,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500,
                                      ), //Textstyle
                                    ), //Text
                                    const SizedBox(
                                      height: 10,
                                    ), //SizedBox
                                    const Text(
                                      'Si eres veterinario y te gustaría promocionar tu negocio y ayudar a los animales. !Ingresa aquí!',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 15,
                                        color: Colors.white,
                                      ), //Textstyle
                                    ), //Text
                                    const SizedBox(
                                      height: 10,
                                    ), //SizedBox
                                    SizedBox(
                                      width: 120,

                                      child: ElevatedButton(
                                        onPressed: () => 'Null',
                                        style: ButtonStyle(
                                            backgroundColor:
                                            MaterialStateProperty.all(Colors.green)),
                                        child: Padding(
                                          padding: const EdgeInsets.all(4),
                                          child: Row(
                                            children: const [
                                              Icon(Icons.touch_app),
                                              Text('Ingresar')
                                            ],
                                          ),
                                        ),
                                      ),
                                      // RaisedButton is deprecated and should not be used
                                      // Use ElevatedButton instead

                                      // child: RaisedButton(
                                      //   onPressed: () => null,
                                      //   color: Colors.green,
                                      //   child: Padding(
                                      //     padding: const EdgeInsets.all(4.0),
                                      //     child: Row(
                                      //       children: const [
                                      //         Icon(Icons.touch_app),
                                      //         Text('Visit'),
                                      //       ],
                                      //     ), //Row
                                      //   ), //Padding
                                      // ), //RaisedButton
                                    ) //SizedBox
                                  ],
                                ), //Column
                              ), //Padding
                            ), //SizedBox
                          ), //Card//Card
                          ),//Card)
                        ],
                      )
                  ),
                  Container(
                      padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                      child: Row(
                        children: <Widget>[
                          Expanded(child: Card(
                            elevation: 50,
                            shadowColor: Colors.black,
                            color: Colors.lightBlue[200],
                            child: SizedBox(
                              width: 300,
                              height: 500,
                              child: Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Column(
                                  children: [
                                    CircleAvatar(
                                      backgroundColor: Colors.lightBlue[900],
                                      radius: 108,
                                      child: const CircleAvatar(
                                        backgroundImage: NetworkImage(
                                            "https://gimnasiocaninocampestre.com/wp-content/uploads/2020/08/hotel-para-perros-gimnasio-canino-campestre-300x225.jpg"), //NetworkImage
                                        radius: 100,
                                      ), //CircleAvatar
                                    ), //CircleAvatar
                                    const SizedBox(
                                      height: 10,
                                    ), //SizedBox
                                    Text(
                                      'Proveedor',
                                      style: TextStyle(
                                        fontSize: 30,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500,
                                      ), //Textstyle
                                    ), //Text
                                    const SizedBox(
                                      height: 10,
                                    ), //SizedBox
                                    const Text(
                                      'Si eres proveedor de un albergue, dueño de un albergue o ayudante de uno, ingresa aquí para que publicites a las mascotas que tienen en adopción, te promociones y recibas ayuda ',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 15,
                                        color: Colors.white,
                                      ), //Textstyle
                                    ), //Text
                                    const SizedBox(
                                      height: 10,
                                    ), //SizedBox
                                    SizedBox(
                                      width: 120,

                                      child: ElevatedButton(
                                        onPressed: () => 'Null',
                                        style: ButtonStyle(
                                            backgroundColor:
                                            MaterialStateProperty.all(Colors.green)),
                                        child: Padding(
                                          padding: const EdgeInsets.all(4),
                                          child: Row(
                                            children: const [
                                              Icon(Icons.touch_app),
                                              Text('Ingresar')
                                            ],
                                          ),
                                        ),
                                      ),
                                      // RaisedButton is deprecated and should not be used
                                      // Use ElevatedButton instead

                                      // child: RaisedButton(
                                      //   onPressed: () => null,
                                      //   color: Colors.green,
                                      //   child: Padding(
                                      //     padding: const EdgeInsets.all(4.0),
                                      //     child: Row(
                                      //       children: const [
                                      //         Icon(Icons.touch_app),
                                      //         Text('Visit'),
                                      //       ],
                                      //     ), //Row
                                      //   ), //Padding
                                      // ), //RaisedButton
                                    ) //SizedBox
                                  ],
                                ), //Column
                              ), //Padding
                            ), //SizedBox
                          ), //Card//Card
                          ),//Card)
                        ],
                      )
                  ),
                ]
            )

          /** Card Widget **/

        )
    );
  }}
