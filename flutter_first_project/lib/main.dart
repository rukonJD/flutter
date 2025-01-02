import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_first_project/page1.dart';
import 'package:flutter_first_project/page2.dart';
import 'package:flutter_first_project/page3.dart';
import 'package:flutter_first_project/page4.dart';
import 'package:flutter_first_project/page5.dart';
import 'package:flutter_first_project/userShow.dart';

void main(){
  runApp(Class1());
}

class Class1 extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
   return MaterialApp(
     routes: {
       'page1':(context)=>LoginScreen(),
       'page2':(context)=>Page2(),
       'page3':(context)=>Page3(),
       'page4':(context)=>Page4(),
       'page5':(context)=>Page5(),
       'page6':(context)=>Usershow(),
       'home':(context)=>Class2(),

     },
     home: Class2(),
     title: 'Flutter Login',
     theme: ThemeData(
       primarySwatch: Colors.blue,
     ),
   );
  }
  
}

class Class2 extends StatefulWidget{
  @override
  State<Class2> createState() => _Class3();


  }

  class _Class3 extends State<Class2>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Text('Dhaka'),
            Text('Bangladesh'),
            ElevatedButton(onPressed: () {
              SnackBar snackBar=SnackBar(content: Text('This is eleveted Button'));
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            },
                child: Text('click'),
            ),
                Image.asset('images/a.png', width: 600, height: 300,),
              ElevatedButton(onPressed: (){
                Navigator.pushNamed(context,'page1');
              }, child: Text('Send')),

          ],
        ),
      ),


      floatingActionButton:FloatingActionButton(onPressed: (){
        SnackBar snackBar=SnackBar(content:Text("Rukon"));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      },
        child: Text("Submit"),
      ),




    );
  }


  }
  


