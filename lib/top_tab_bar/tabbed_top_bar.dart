import 'package:calender/top_tab_bar/choice.dart';
import 'package:flutter/material.dart';

class TabbedTopBar extends StatefulWidget {
  const TabbedTopBar({Key? key}) : super(key: key);

  @override
  _TabbedTopBarState createState() => _TabbedTopBarState();
}

class _TabbedTopBarState extends State<TabbedTopBar> {
  List<Choice> choices = [
    Choice('Car', Icons.directions_car),
    Choice('Bike', Icons.directions_bike),
    Choice('Train', Icons.directions_train),
    Choice('Boat', Icons.directions_boat),
  ];
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: choices.length,
        child: Scaffold(
          appBar: AppBar(
            title: Text("Tabbed AppBar"),
            centerTitle: true,
            bottom: TabBar(
              isScrollable: true,
              tabs: choices.map((Choice choice) {
                return Tab(
                  text: choice.title,
                  icon: Icon(choice.icon),
                );
              }).toList(),
            ),
          ),
          body: TabBarView(
            children: choices.map((Choice choice) {
              return Padding(
                padding: const EdgeInsets.all(20.0),
                child: ChoicePage(
                  choice: choice,
                ),
              );
            }).toList(),
          ),
        ));
  }
}
