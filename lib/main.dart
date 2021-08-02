import 'dart:io';

import 'package:calender/calendar_screen.dart';
import 'package:calender/emai_auth/email_auth_screen.dart';

import 'package:calender/event_provider.dart';
import 'package:calender/image_picker/image_picker.dart';
import 'package:calender/phone_auth/phone_authentication.dart';
import 'package:calender/searchBar/serach_screen.dart';
import 'package:calender/share/share_data.dart';
import 'package:calender/slivers/sliver.dart';
import 'package:calender/top_tab_bar/tabbed_top_bar.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
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
        theme: ThemeData(
          primarySwatch: Colors.purple,
        ),
        home: MainPage(),
      ),
    );
  }
}

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation degOneTranslatiionAnimation,
      degThreeTranslatiionAnimation,
      degTwoTranslatiionAnimation;
  late Animation rotateAnimation;

  double getradiusFromDegree(double degeree) {
    double unitRadius = 57.295779513;
    return degeree / unitRadius;
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    animationController =
        AnimationController(vsync: this, duration: Duration(microseconds: 250));
    degOneTranslatiionAnimation = TweenSequence<double>([
      TweenSequenceItem<double>(
          tween: Tween<double>(begin: 0.0, end: 1.2), weight: 75.0),
      TweenSequenceItem<double>(
          tween: Tween<double>(begin: 1.2, end: 1.0), weight: 25.0)
    ]).animate(animationController);
    degTwoTranslatiionAnimation = TweenSequence<double>([
      TweenSequenceItem<double>(
          tween: Tween<double>(begin: 0.0, end: 1.4), weight: 55.0),
      TweenSequenceItem<double>(
          tween: Tween<double>(begin: 1.4, end: 1.0), weight: 45.0)
    ]).animate(animationController);
    degThreeTranslatiionAnimation = TweenSequence<double>([
      TweenSequenceItem<double>(
          tween: Tween<double>(begin: 0.0, end: 1.75), weight: 35.0),
      TweenSequenceItem<double>(
          tween: Tween<double>(begin: 1.75, end: 1.0), weight: 65.0)
    ]).animate(animationController);
    rotateAnimation = Tween<double>(begin: 180.0, end: 0.0).animate(
        CurvedAnimation(parent: animationController, curve: Curves.easeOut));
    super.initState();
    animationController.addListener(() {
      setState(() {});
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: CalenderScreen(),
      // Positioned(
      //     right: 30,
      //     bottom: 30,
      //     child: Stack(
      //       children: [
      //         Transform.translate(
      //           offset: Offset.fromDirection(getradiusFromDegree(180),
      //               degOneTranslatiionAnimation.value * 100),
      //           child: Transform(
      //             alignment: Alignment.center,
      //             transform: Matrix4.rotationZ(
      //                 getradiusFromDegree(rotateAnimation.value))
      //               ..scale(degOneTranslatiionAnimation.value),
      //             child: CircularButton(
      //                 width: 50,
      //                 color: Colors.red,
      //                 height: 50,
      //                 icon: Icon(
      //                   Icons.add,
      //                   color: Colors.white,
      //                 ),
      //                 onClick: () {}),
      //           ),
      //         ),
      //         Transform.translate(
      //           offset: Offset.fromDirection(getradiusFromDegree(225),
      //               degTwoTranslatiionAnimation.value * 100),
      //           child: Transform(
      //             alignment: Alignment.center,
      //             transform: Matrix4.rotationZ(
      //                 getradiusFromDegree(rotateAnimation.value))
      //               ..scale(degTwoTranslatiionAnimation.value),
      //             child: CircularButton(
      //                 width: 50,
      //                 color: Colors.pink,
      //                 height: 50,
      //                 icon: Icon(
      //                   Icons.delete,
      //                   color: Colors.white,
      //                 ),
      //                 onClick: () {}),
      //           ),
      //         ),
      //         Transform.translate(
      //           offset: Offset.fromDirection(getradiusFromDegree(270),
      //               degThreeTranslatiionAnimation.value * 100),
      //           child: Transform(
      //             alignment: Alignment.center,
      //             transform: Matrix4.rotationZ(
      //                 getradiusFromDegree(rotateAnimation.value))
      //               ..scale(degThreeTranslatiionAnimation.value),
      //             child: CircularButton(
      //                 width: 50,
      //                 color: Colors.black,
      //                 height: 50,
      //                 icon: Icon(
      //                   Icons.report,
      //                   color: Colors.white,
      //                 ),
      //                 onClick: () {}),
      //           ),
      //         ),
      //         Transform(
      //           alignment: Alignment.center,
      //           transform: Matrix4.rotationZ(
      //               getradiusFromDegree(rotateAnimation.value)),
      //           child: CircularButton(
      //               width: 60,
      //               color: Colors.purple,
      //               height: 60,
      //               icon: Icon(
      //                 Icons.menu,
      //                 color: Colors.white,
      //               ),
      //               onClick: () {
      //                 if (animationController.isCompleted) {
      //                   animationController.reverse();
      //                 } else {
      //                   animationController.forward();
      //                 }
      //               }),
      //         ),
      //       ],
      //     ))
      // ]),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
        backgroundColor: Colors.purple,
        onPressed: () {
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => PhoneAuthenticate()));
        },
      ),
    );
  }
}

class CircularButton extends StatelessWidget {
  final double width;
  final double height;
  final Color color;
  final Icon icon;
  final VoidCallback onClick;

  CircularButton(
      {required this.width,
      required this.color,
      required this.height,
      required this.icon,
      required this.onClick});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
      width: width,
      height: height,
      child: IconButton(
        icon: icon,
        enableFeedback: true,
        onPressed: onClick,
      ),
    );
  }
}
