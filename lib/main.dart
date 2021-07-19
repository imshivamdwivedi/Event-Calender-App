import 'package:calender/calendar_screen.dart';

import 'package:calender/event_provider.dart';
import 'package:calender/searchBar/serach_screen.dart';
import 'package:calender/share/share_data.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => EventProvider(),
      child: MaterialApp(
        title: 'Flutter Demo',
        home: MainPage(),
      ),
    );
  }
}

class MainPage extends StatelessWidget {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calender'),
        centerTitle: true,
        backgroundColor: Colors.pink,
      ),
      body: CalenderScreen(),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
        backgroundColor: Colors.pink,
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => ShareData()));
        },
      ),
    );
  }
}
