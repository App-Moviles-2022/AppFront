import 'dart:convert';

import 'package:appfront/modulos/gestion-notificaciones/models/Notification.dart';
import 'package:appfront/modulos/gestion-notificaciones/notifications.service.dart';
import 'package:flutter/material.dart';

import '../utils/confirm-dialog.dart';

class Notifications extends StatefulWidget {
  const Notifications({Key? key}) : super(key: key);

  @override
  State<Notifications> createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  NotificationsService notificationsService = NotificationsService();
  List<AdoptionNotification> notifications = [];

  @override
  void initState(){
    super.initState();
    loadNotifications();
  }

  void loadNotifications() {
    notifications.clear();
    notificationsService.getAllNotificationsFrom().then((valueFrom) => {
      notificationsService.getAllNotificationsAt().then((valueAt) => {
        setState(() {
          String bodyFrom = utf8.decode(valueFrom.bodyBytes);
          String bodyTo = utf8.decode(valueAt.bodyBytes);

          for(var element in jsonDecode(bodyFrom)) {
            notifications.add(
              AdoptionNotification(
                element['id'],
                element['userIdAt'],
                element['userIdFrom'],
                element['publicationId'],
                element['message'],
                element['status'],
              )
            );
          }

          for(var element in jsonDecode(bodyTo)){
            notifications.add(
              AdoptionNotification(
                element['id'],
                element['userIdAt'],
                element['userIdFrom'],
                element['publicationId'],
                element['message'],
                element['status'],
              )
            );
          }
        }),
      }),
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Notifications"), automaticallyImplyLeading: false,backgroundColor: Colors.indigo,),
      body: ListView.builder(
        itemCount: notifications.length,
        itemBuilder: (context, index) {
          final item = notifications[index];

          return Dismissible(
            // Each Dismissible must contain a Key. Keys allow Flutter to
            // uniquely identify widgets.
            key: Key(item.id.toString()),
            // Provide a function that tells the app
            // what to do after an item has been swiped away.
            onDismissed: (direction) {
              // Remove the item from the data source.
              setState(() {
                notifications.removeAt(index);
              });

              // Then show a snackbar.
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text('$item dismissed')));
            },
            child: ListTile(
              title: Text(notifications[index].message),
              leading: Image.network("https://cdn-icons-png.flaticon.com/512/147/147144.png"),
              trailing: notifications[index].status == 0 ? Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    IconButton(icon: const Icon(Icons.check_circle),
                      color: Colors.green,
                      tooltip: "Aceptar", onPressed: () {
                      showConfirmDialog(context, 'Confirm adoption request',
                          'Are you sure you want to accept the adoption request?', () {
                            // Este es el callback de confirmación
                            notificationsService.markAdoptionRequestAsAccepted(
                                notifications[index].id).then((value) =>
                            {
                              setState(() {
                                loadNotifications();
                              })
                            });
                                });
                      }),
                    IconButton(icon: const Icon(Icons.cancel),
                        color: Colors.red,
                        tooltip: "Rechazar", onPressed: () {
                        showConfirmDialog(context, 'Refuse adoption request', 'Are you sure you want to refuse the adoption request?', () {
                          // Este es el callback de confirmación

                          notificationsService.markAdoptionRequestAsRejected(
                              notifications[index].id).then((value) =>
                          {
                            setState(() {
                              loadNotifications();
                            })
                          });
                        });
                      },),
                  ]) : null

            ),
          );
        },
      )
      // Column(
      //     children: [
      //       Expanded(
      //         child: Dismissible(
      //           key: Key("2"),
      //           child: ListView.builder(
      //               itemCount: productos.length,
      //               itemBuilder: (BuildContext context, int index) {
      //                 return Card(
      //                   child: ListTile(
      //                     title: Text(productos[index]),
      //                     leading: Image.network("https://cdn-icons-png.flaticon.com/512/147/147144.png"),
      //                     trailing: IconButton(icon: const Icon(Icons.add_circle),  tooltip: "Aceptar", onPressed: () {  },),
      //                   ),
      //                 );
      //               }
      //           ),
      // )
      //       )]
      // )
    );
  }
}
