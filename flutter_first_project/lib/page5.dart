import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_first_project/product.dart';

void main(){
  runApp(Page5());
}

class Page5 extends StatefulWidget{


  @override
  _Page5State createState()=> _Page5State() ;



}

class _Page5State extends State<Page5> {
  var products=[
    Product(1,'product1','Hbrand',5,500,'images/flutter.png'),
    Product(2,'product2','Hbrand',5,600,'images/android_t1.png'),
    Product(3,'product3','Hbrand',5,8520,'images/a.png'),
    Product(4,'product4','Hbrand',5,650,'images/a.png'),
  ];

  // Variable for DropdownButton
  String? selectedCategory = 'Products';

  String? reValue='female';

  bool cb1=false;
  bool cb2=false;
  bool cb3=false;
  void m1(){
    print('Checkbox state change $cb1,$cb2,$cb3');
  }
  void onCheckBoxChange(int index){
    setState(() {
      if(index==1){
        cb1=!cb1;

      } else if(index==2){
        cb2 = !cb2;

      } else if(index==3){
        cb3= !cb3;

      }
      m1();
    });
  }

  String getSelectedCheckboxText(){
    List<String> selected= [];
    if (cb1) selected.add('Flutter');
    if (cb2) selected.add('Dart');
    if (cb3) selected.add('Firebase');

    if(selected.isEmpty){
      return 'No checkBox selected!';
    }else{
      return 'you have selected (${selected.join(", ")})';
    }
  }
  @override
Widget build(BuildContext context) {
return Scaffold(
  appBar: AppBar(title: Text('product page'),backgroundColor: Colors.blueGrey,),
  body: SingleChildScrollView(
    child:Column(
      children:[
        Row(
          children: [
            Radio<String>(
              value:'female',
              groupValue:reValue,
              onChanged:(String? value){
                setState(() {
                  reValue = value;
                });
              },
            ),
            Text('Female'),


            Radio<String>(
              value:'male',
              groupValue:reValue,
              onChanged:(String? value){
                setState(() {
                  reValue = value;
                });
              },
            ),
            Text('Male'),

          ],
        ),
      Row(
        children: [
          Container(
            width: 200,
            child: CheckboxListTile(
                value: cb1,
                onChanged: (bool? value){
                  onCheckBoxChange(1);
                },
              title: Text('Flutter'),
                
            ),
          ),
          Container(
            width: 200,
            child: CheckboxListTile(
              value: cb2,
              onChanged: (bool? value){
               onCheckBoxChange(2);
              },
              title: Text('Dart'),

            ),
          ),
          Container(
            width: 200,
            child: CheckboxListTile(
              value: cb3,
              onChanged: (bool? value){
                onCheckBoxChange(3);
              },
              title: Text('Firebase'),

            ),
          ),
        ],
      ),
        Text(
          getSelectedCheckboxText(),
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 20),

      Padding(
          padding: const EdgeInsets.all(8.0),
        child: DropdownButton<String>(
          value: selectedCategory,
          onChanged: (String? newValue){
            setState(() {
              selectedCategory=newValue!;
            });
          },
          items:<String>[ 'Products', 'Service','Others']
              .map<DropdownMenuItem<String>>((String value){
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),

            );
          }).toList(),
          ),
             
        ),

      // Display the selected category
        Text(
          'You have Selected Category : $selectedCategory',
          style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),
        ),



      ...products.map((product) {
              return Column(
                children: [
                 Row(
                   children: [
                     Text(
                       'ID: ${product.pid} \n Product Name : ${product.name} \n Price: ${product.price}',
                       style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),
                     ),
                     SizedBox(height: 10),
                     Image.asset(
                       product.img1,height: 250,width: 250,
                     ),
                     SizedBox(height: 10),
                   ],
                 ),


                ],
              );
    }

      ).toList(),
        ElevatedButton(onPressed: (){
          Navigator.pushNamed(context, 'page6');
        }, child: Icon(Icons.skip_next)),
      ],
    ),


  ),
);
  }
  }