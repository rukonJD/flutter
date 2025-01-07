import 'package:flutter/material.dart';

class Dismissible_Widget extends StatelessWidget {
  const Dismissible_Widget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key('dismissible_widget'),
      onDismissed: (direction) {
        // You can perform an action when the widget is dismissed.
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Widget dismissed")));
      },
      child: Card(
        elevation: 5,
        margin: EdgeInsets.all(10),
        child: Container(
          height: 200,
          color: Colors.redAccent,
          child: Center(
            child: Text(
              "Swipe me away",
              style: TextStyle(fontSize: 20, color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}
