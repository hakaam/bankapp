import 'package:bankapp/Home/home_screen.dart';
import 'package:bankapp/OTP/screens/phone_number/phone_number_form.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Providers/Authprovider/auth_provider.dart';

class SignInScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void _signIn(BuildContext context) async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    try {
      await authProvider.signIn(
        email: emailController.text,
        password: passwordController.text,
      );
      // Navigate to the home screen after successful signin
      Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeScreen()));
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

      child: Padding(
        padding: const EdgeInsets.all(20),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20,),
            IconButton(onPressed: (){
              Navigator.pop(context);
            },
                icon: Icon(Icons.arrow_back)
            ),
            SizedBox(height: 30,),

            Center(
              child: Image.network('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTxISUh29JCh76Q0sJeVWYmHRN0Nb2dHLcL1Il-d0-PYvF7aYmrncNJU3FazosIpe4eR5w&usqp=CAU',
                scale: 2,
              ),
            ),
            SizedBox(height: 50,),

            Center(
              child: Text(
                'Sign In',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            TextFormField(
              controller: emailController,

              decoration: InputDecoration(
                  hintText: 'Enter Email',
                  border: OutlineInputBorder(), labelText: 'Email'),
            ),
            SizedBox(
              height: 15,
            ),
            TextFormField(
              controller: passwordController,
              decoration: InputDecoration(
                  hintText: 'Enter Password',
                  border: OutlineInputBorder(), labelText: 'Password'),
              obscureText: true,
            ),
            SizedBox(
              height: 20,
            ),
            InkWell(
              onTap: (){
                Navigator.pushNamed(context, '/forgot_password');

              },
              child: Container(
                alignment: Alignment.bottomRight,
                  child: Text('Forgot Password?')),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () => _signIn(context),
                child: Text('Sign In'),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(
                      builder: (context)=>PhoneNumberForm()));
                },
                child: Text('PhoneNumber'),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            InkWell(
              onTap: () {
                Navigator.pushReplacementNamed(context, '/signup');
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Dont have an Account?',
                    style:
                    TextStyle(fontSize: 15, fontWeight: FontWeight.normal),
                  ),
                  SizedBox(
                    width: 3,
                  ),
                  Text(
                    'Sign Up',
                    style:
                    TextStyle(fontSize: 20, fontWeight: FontWeight.normal),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
