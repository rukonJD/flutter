import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_first_project/user.dart';
import 'package:http/http.dart' as http;


List<User> userFromJson(String str){
  return List<User>.from(json.decode(str).map((x){
    return User.fromJson(x);
  }));
}

Future<List<User>> findFutureUsers() async {
  // final respons = await http.get(Uri.parse('https://jsonplaceHolder.typicode.com/posts'));
  final respons = await http.get(Uri.parse('http://localhost:8080/api/androidUser'));
  if(respons.statusCode == 200){

    return userFromJson(respons.body);
  }else{
    throw Exception('Failed to load student');
  }
}

class Usershow extends StatefulWidget {
  const Usershow({super.key});

  @override
  State<Usershow> createState() => _UsershowState();
}

class _UsershowState extends State<Usershow> {
  late List<User>? listUser=[];
  void findListUser()async{
    listUser=await findFutureUsers();
    if(listUser!= null){
      setState(() {

      });
    }
  }
  @override
  void initState(){
    super.initState();
    findListUser();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 10,),
          Divider(color: Colors.black,),
          Container(
            height: 250,
              margin: EdgeInsets.only(left:10,right:10),
            child: ListView.builder(
              itemCount: listUser!.length,
                itemBuilder:  (context,index){
                if(listUser!=null){
                  return ListTile(
                    leading: CircleAvatar(child: FlutterLogo(),),
                    title: Text(listUser![index].userId.toString()),
                    subtitle: Text(listUser![index].body.toString()),
                    trailing: CircleAvatar(child: Text(listUser![index].title.toString(),style: TextStyle(color: Colors.white),),
                      backgroundColor: Colors.red,),
                  );
                }else{
                  return Center(child: CircularProgressIndicator());
                }
                }
            ),
          ),
          SizedBox(height: 10,),
        ],
      ),
    );
  }
}


