import 'package:flutter/material.dart';

class Notifications extends StatelessWidget {
  const Notifications({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class NotificationFul extends StatefulWidget {
  const NotificationFul({Key? key}) : super(key: key);

  @override
  State<NotificationFul> createState() => _NotificationFulState();
}

class _NotificationFulState extends State<NotificationFul> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Text("hola"),
    );
  }
}
