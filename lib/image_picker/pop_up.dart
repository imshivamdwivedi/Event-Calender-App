import 'package:flutter/material.dart';

class PopUp extends StatefulWidget {
  const PopUp({Key? key}) : super(key: key);

  @override
  _PopUpState createState() => _PopUpState();
}

class _PopUpState extends State<PopUp> {
  bool init = true;

  @override
  Widget build(BuildContext context) {
    if (init) {}
    Size size = MediaQuery.of(context).size;
    return AlertDialog(
      title: Text("Create"),
      content: SingleChildScrollView(
        child: Container(
          height: size.height * 0.5,
          width: double.infinity,
          child: Column(
            children: <Widget>[],
          ),
        ),
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.black87,
                ),
                onPressed: () {},
                child: Text(
                  "Create",
                  style: TextStyle(color: Colors.white),
                )),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.black87,
                ),
                onPressed: () => Navigator.pop(context),
                child: Text(
                  "Close",
                  style: TextStyle(color: Colors.white),
                )),
          ],
        )
      ],
    );
  }
}
