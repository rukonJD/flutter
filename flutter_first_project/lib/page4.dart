import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main(){
  runApp(Page4());
}

class Page4 extends StatefulWidget{
  @override
  _Page4State createState()=> _Page4State() ;



}

class _Page4State extends State<Page4> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     body: Column(
       children: [
         
         Flexible(
           child: Container(
             child: Center(child: Text('page4'),),
             color: Colors.blueGrey,
           ),
         ),
         Flexible(
             child: Container(
            color: Colors.black,
               child: Column(
                 children: [
                   Text("show text white",style: TextStyle()),
                   ElevatedButton(onPressed: (){
                     Navigator.pushNamed(context, 'page5');
                   }, child: Icon(Icons.next_plan_outlined)),

                 ],
               ),
             )),
         Flexible(
           child: Container(
             child: Center(child: Text('container2'),),
             color: Colors.green,
           ),
         ),
         ElevatedButton(onPressed: (){
           Navigator.pushNamed(context, 'page3');
         }, child: Icon(Icons.arrow_back)),

       ],
     ),
    );
  }
  }