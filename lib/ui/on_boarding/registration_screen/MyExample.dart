import 'package:flutter/material.dart';

class MyWidget extends StatefulWidget {
  @override
  _MyWidgetState createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  double spacing = 100.0;

  void reduceSpacing() {
    setState(() {
      spacing -= 5.0;
      if(spacing == 0){
        spacing = 100;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.all(spacing),
              child: Text("Widget 1"),
            ),
            Container(
              margin: EdgeInsets.all(spacing),
              child: Text("Widget 2"),
            ),
            Container(
              margin: EdgeInsets.all(spacing),
              child: Text("Widget 3"),
            ),
            ElevatedButton(
              child: Text("Reduce Spacing"),
              onPressed: reduceSpacing,
            ),
          ],
        ),
      ),
    );
  }
}
