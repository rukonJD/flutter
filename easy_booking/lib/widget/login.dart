import 'dart:convert';
import 'package:easy_booking/widget/ui_example_03-a.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isLoading = false;

  // FocusNode to manage focus for each text field
  final FocusNode emailFocusNode = FocusNode();
  final FocusNode passwordFocusNode = FocusNode();

  // Function to handle login
  Future<void> loginUser(String email, String password) async {
    setState(() {
      isLoading = true;
    });

    // Build the URL with query parameters
    final url = Uri.parse('http://localhost:8080/user/api/login?email=$email&password=$password');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        // Successfully logged in
        final data = json.decode(response.body);
        if (data != null) {
          setState(() {
            isLoading = false;
          });
          // Navigate to the search page after successful login
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => UIEX03Ft()),
          );
        } else {
          setState(() {
            isLoading = false;
          });
          showDialog(
            context: context,
            builder: (_) => AlertDialog(
              title: Text("Login Failed"),
              content: Text("Invalid email or password."),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text("OK"),
                ),
              ],
            ),
          );
        }
      } else {
        setState(() {
          isLoading = false;
        });
        showDialog(
          context: context,
          builder: (_) => AlertDialog(
            title: Text("Error"),
            content: Text("Failed to connect to the server."),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text("OK"),
              ),
            ],
          ),
        );
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      print('Error occurred during login: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error occurred during login: $e')),
      );
    }
  }

  @override
  void dispose() {
    // Dispose the focus nodes when the widget is disposed
    emailFocusNode.dispose();
    passwordFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Easy Booking - Login'),
        backgroundColor: Color(0xffd44d57),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 30),
              // App Logo or Icon (Optional)
              Icon(
                Icons.directions_bus,
                size: 80,
                color: Color(0xffd44d57),
              ),
              SizedBox(height: 20),
              // Title
              Text(
                "Welcome to Easy Booking",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(0xffd44d57),
                ),
              ),
              SizedBox(height: 30),

              // Email Input Field
              TextField(
                controller: emailController,
                focusNode: emailFocusNode,
                decoration: InputDecoration(
                  labelText: 'Email',
                  hintText: 'Enter your email',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  filled: true,
                  fillColor: Colors.black26,
                  prefixIcon: Icon(Icons.email),
                ),
                keyboardType: TextInputType.emailAddress,
                onTap: () {
                  FocusScope.of(context).requestFocus(emailFocusNode);
                },
              ),
              SizedBox(height: 20),

              // Password Input Field
              TextField(
                controller: passwordController,
                focusNode: passwordFocusNode,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Password',
                  hintText: 'Enter your password',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  filled: true,
                  fillColor: Colors.black26,
                  prefixIcon: Icon(Icons.lock),
                ),
                keyboardType: TextInputType.visiblePassword,
                onTap: () {
                  FocusScope.of(context).requestFocus(passwordFocusNode);
                },
              ),
              SizedBox(height: 20),

              // Login Button
              isLoading
                  ? CircularProgressIndicator()
                  : ElevatedButton(
                onPressed: () {
                  String email = emailController.text;
                  String password = passwordController.text;

                  if (email.isNotEmpty && password.isNotEmpty) {
                    loginUser(email, password);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Please fill in all fields")),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 15, horizontal: 50),
                  backgroundColor: Color(0xffd44d57),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  'Login',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(height: 20),

              // Forgot Password Link (Optional)
              TextButton(
                onPressed: () {
                  // Handle forgot password action
                },
                child: Text(
                  "Forgot Password?",
                  style: TextStyle(
                    color: Color(0xffd44d57),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 30),

              // Sign Up Link (Optional)
              TextButton(
                onPressed: () {
                  // Handle sign-up action
                },
                child: Text(
                  "Don't have an account? Sign Up",
                  style: TextStyle(
                    color: Color(0xffd44d57),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
