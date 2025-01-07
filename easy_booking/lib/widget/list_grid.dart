import 'package:flutter/material.dart';

class List_Grid extends StatelessWidget {
  const List_Grid({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('List/Grid Example')),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,  // Number of items per row
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemCount: 20,  // Number of items in the grid
        itemBuilder: (context, index) {
          return Card(
            color: Colors.blueAccent,
            child: Center(
              child: Text(
                'Item $index',
                style: TextStyle(color: Colors.white),
              ),
            ),
          );
        },
      ),
    );
  }
}
