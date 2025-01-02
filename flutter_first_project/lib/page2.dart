import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main(){
  runApp(Page2());
}

class Page2 extends StatefulWidget{
  @override
  _Page2State createState()=> _Page2State() ;



}

class _Page2State extends State<Page2> {


  @override
  Widget build(BuildContext context) {
   Map<String,dynamic> myMap= ModalRoute.of(context)!.settings.arguments as Map<String,dynamic>;
   String email = myMap['email'];
   String password= myMap['password'];
    return Scaffold(
        appBar: AppBar(title: Row(
          children: [
            Icon(Icons.person, size: 28),
            SizedBox(width: 10),
            Text(
              'HI: $email\n Welcome to this app! ',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
        ),
      body: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
                'Hi : $email',
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 20),
            Text(
                'Welcome to this app !',
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 20),
            Text('Password : $password',style: TextStyle(fontSize: 18,color: Colors.grey),),

            ElevatedButton(onPressed: (){
              Navigator.pushNamed(context, 'page3',arguments: {'name':'Rukon'});
            }, child: Text('page3')),
            ElevatedButton(onPressed: (){
              Navigator.pushNamed(context, 'page1');
            }, child: Icon(Icons.arrow_back)),
          ],

        ),

      ),




    );
  }
}