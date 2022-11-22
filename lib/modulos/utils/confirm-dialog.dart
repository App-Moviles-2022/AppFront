import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';


class ConfirmDialogWidget extends StatelessWidget {
  final String title;
  final String body;

  final VoidCallback acceptCallback;
  const ConfirmDialogWidget({Key? key, required this.title, required this.body, required this.acceptCallback}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget cancelButton = TextButton(
      child: Text("Cancel"),
      onPressed:  (){ Navigator.pop(context); },
    );
    Widget continueButton = TextButton(
      child: Text("Accept"),
      onPressed:  (){ acceptCallback();
        Navigator.pop(context); },
    );  // set up the AlertDialog
    return AlertDialog(
      title: Text(this.title),
      content: Text(this.body),
      actions: [
        cancelButton,
        continueButton,
      ],
    );  // show the dialog
  }
}


showConfirmDialog(BuildContext context, String title, String body, VoidCallback acceptCallback) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return ConfirmDialogWidget(title: title, body: body, acceptCallback: acceptCallback);
    },
  );
}
