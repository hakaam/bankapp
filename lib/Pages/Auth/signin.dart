import 'package:bankapp/Home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../OTP/screens/phone_number/phone_number_form.dart';
import '../../Providers/Authprovider/auth_provider.dart';

class SignInScreen extends StatefulWidget {
  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  bool passwordVisible = false;
  bool hasText = false; // Initialize it in your state class
  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  void _signIn(BuildContext context) async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    emailController.text = "ali@gmail.com";
    passwordController.text = "123456";

    try {
      await authProvider.signIn(
        email: emailController.text,
        password: passwordController.text,
      );
      // Navigate to the home screen after successful signin
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => HomeScreen()));
    } catch (e) {
      // Handle signin errors, show error message
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
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.blue.shade200,

      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
                child:  Text(
                  "Straton Bank",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 34),
                ),),
            SizedBox(
              height: 10,
            ),
            Center(
              child:  Text(
                "Banking Made Easy",
                style: TextStyle(
                    color: Colors.white,
                    ),
              ),),

            SizedBox(
              height: 50,
            ),
            TextFormField(
              controller: emailController,
              decoration: InputDecoration(
                hintText: 'Username',
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
            SizedBox(
              height: 25,
            ),
            TextFormField(
              controller: passwordController,
              obscureText:
              !passwordVisible, // Set obscureText based on passwordVisible
              decoration: InputDecoration(
                suffixIcon: IconButton(
                  icon: Icon(
                    passwordVisible ? Icons.visibility : Icons.visibility_off,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    setState(() {
                      passwordVisible = !passwordVisible;
                    });
                  },
                ),
                labelText: 'Password',
                hintStyle: TextStyle(color: Colors.white),
                labelStyle: TextStyle(color: Colors.white, fontSize: 22),
                focusedBorder: UnderlineInputBorder(
                  borderSide:
                  BorderSide(color: Colors.white), // Change the color here
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide:
                  BorderSide(color: Colors.white), // Change the color here
                ),
              ),
              // onChanged: (value) {
              //   setState(() {
              //     hasText = value.isNotEmpty;
              //   });
              // },
              style: TextStyle(color: hasText ? Colors.grey : Colors.white),
            ),
            SizedBox(
              height: 40,
            ),

            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () => _signIn(context),
                    child: Container(
                      height: 50.0,
                      decoration: new BoxDecoration(
                        color: Colors.blue.shade600,
                        border:
                        new Border.all(color: Colors.white, width: 2.0),
                        borderRadius: new BorderRadius.circular(7.0),
                      ),
                      child: new Center(
                        child: new Text(
                          'Login',
                          style: new TextStyle(
                              fontSize: 18.0,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 15,
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pushReplacementNamed(context, '/signup');
                    },
                    child: Container(
                      height: 50.0,
                      decoration: new BoxDecoration(
                        color: Colors.blue.shade600,
                        border:
                        new Border.all(color: Colors.white, width: 2.0),
                        borderRadius: new BorderRadius.circular(7.0),
                      ),
                      child: new Center(
                        child: new Text(
                          'Register',
                          style: new TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}