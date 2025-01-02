import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main(){
  runApp(LoginScreen());
}

class LoginScreen extends StatefulWidget{
  @override
  _LoginScreenState createState()=> _LoginScreenState() ;

  

}

class _LoginScreenState extends State<LoginScreen>{
  // Create TextEditingControllers to capture input from the user
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
   return Scaffold(
     appBar: AppBar(title: Text('Login page'),),
     body: Padding(
       padding: const EdgeInsets.all(8.0),
       child: Center(
         child: Column(
           crossAxisAlignment: CrossAxisAlignment.stretch,
           children: [
              Padding(padding:const EdgeInsets.all(16.0) ),
             Row(
               mainAxisAlignment: MainAxisAlignment.center,

               children: [
                 CircleAvatar(
                   radius: 40,
                   backgroundColor: Colors.blueGrey,
                   child: Icon(Icons.home,color: Colors.white,size: 40,),
                 ),

               ],
             ),
             TextField(
              controller: _emailController,
               decoration: InputDecoration(
                 border: OutlineInputBorder(),
                 labelText: 'Email',
                 hintText: 'Enter Your Email',

               ),

             ),
             SizedBox(height: 20),
             TextField(
               controller: _passwordController,
               decoration: InputDecoration(
                 border: OutlineInputBorder(),
                 labelText: 'Password',
                 hintText: 'Enter Your Password',
               ),
             ),
             SizedBox(height: 20),
             ElevatedButton(onPressed: (){
               String email=_emailController.text;
               String password=_passwordController.text;
               Navigator.pushNamed(context, 'page2',arguments: {'email':email,'password':password},);
             }, child: Text('Login')),

             ElevatedButton(onPressed: (){
               Navigator.pushNamed(context, 'home');
             }, child: Icon(Icons.arrow_back)),

           ],
         ),
       ),
     ),
       
     );
  
  }

}

