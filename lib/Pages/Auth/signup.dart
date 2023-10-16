import 'package:bankapp/Home/home_screen.dart';
import 'package:bankapp/Pages/Auth/signin.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Providers/Authprovider/auth_provider.dart';

class SignUpScreen extends StatefulWidget {
  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool hasText = false; // Initialize it in your state class
  bool isSigningUp =
      false; // Add a state variable for tracking the sign-up process

  void _signUp(BuildContext context) async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    try {
      // Set the state variable to true to show the progress indicator
      setState(() {
        isSigningUp = true;
      });

      await authProvider.signUp(
        name: nameController.text,
        email: emailController.text,
        password: passwordController.text,
      );
      // Navigate to the home screen after successful signup
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => HomeScreen()));
    } catch (e) {
      // Handle signup errors, show error message
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text(e.toString()),
            actions: <Widget>[
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    } finally {
      // Set the state variable back to false to hide the progress indicator
      setState(() {
        isSigningUp = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade200,
      appBar: AppBar(
        automaticallyImplyLeading: true,
        leading: IconButton(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => SignInScreen()));
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
            size: 24,
          ),
        ),
        title: Text(
          'Register',
          style: TextStyle(
            letterSpacing: 2,
            fontSize: 22,
          ),
        ),
        backgroundColor: Colors.blue.shade600,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 15,
                ),
                Text(
                  'Enter details below to register',
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 30),
                TextFormField(
                  controller: nameController,
                  decoration: InputDecoration(
                    hintText: 'Name',
                    hintStyle: TextStyle(color: Colors.white, fontSize: 20),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                  ),
                  style: TextStyle(color: hasText ? Colors.grey : Colors.white),
                ),
                SizedBox(height: 30),
                TextFormField(
                  controller: emailController,
                  decoration: InputDecoration(
                    hintText: 'Email',
                    hintStyle: TextStyle(color: Colors.white, fontSize: 20),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                  ),
                  // onChanged: (value) {
                  //   setState(() {
                  //     hasText = value.isNotEmpty;
                  //   });
                  // },
                  style: TextStyle(color: hasText ? Colors.grey : Colors.white),
                ),
                SizedBox(height: 30),
                TextFormField(
                  controller: passwordController,
                  decoration: InputDecoration(
                    hintText: 'Password',
                    hintStyle: TextStyle(color: Colors.white, fontSize: 20),
                    labelStyle: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                  ),
                  // onChanged: (value) {
                  //   setState(() {
                  //     hasText = value.isNotEmpty;
                  //   });
                  // },
                  style: TextStyle(color: hasText ? Colors.grey : Colors.white),
                ),
              ],
            ),
          ),
          Container(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue.shade600,
              ),
              onPressed: isSigningUp ? null : () => _signUp(context),
              // Disable the button when signing up
              child: isSigningUp
                  ? Center(
                      child:
                          CircularProgressIndicator()) // Show the progress indicator when signing up
                  : Text(
                      'Next',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
