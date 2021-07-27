import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Choice {
  final String title;
  final IconData icon;
  Choice(this.title, this.icon);
}

class ChoicePage extends StatelessWidget {
  final Choice choice;
  const ChoicePage({required this.choice});

  @override
  Widget build(BuildContext context) {
    // final TextStyle textStyle = Theme.of(context).textTheme.display1;
    return Card(
      color: Colors.white,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(choice.icon, size: 150.0, color: Colors.black),
            Text(
              choice.title,
              style: TextStyle(color: Colors.black),
            )
          ],
        ),
      ),
    );
  }
}
