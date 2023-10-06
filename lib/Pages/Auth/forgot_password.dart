import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Providers/Authprovider/auth_provider.dart';

class ForgotPasswordScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();

  void _resetPassword(BuildContext context) async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    try {
      await authProvider.resetPassword(email: emailController.text);
      // Show a success message or navigate back to the sign-in screen.
      Navigator.pushReplacementNamed(context, '/signin');

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Password Reset Email Sent'),
            content: Text('Check your email for password reset instructions.'),
            actions: <Widget>[
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.pop(context); // Return to the sign-in screen.
                },
              ),
            ],
          );
        },
      );
    } catch (e) {
      // Handle password reset errors, show an error message.
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
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20,),
             IconButton(onPressed: (){
               Navigator.pop(context);
             },
                 icon: Icon(Icons.arrow_back)),

            SizedBox(height: 50,),
            TextFormField(
              controller: emailController,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),

                  labelText: 'Email'),
            ),
        SizedBox(height: 20,),
            Container(
              width: double.infinity,
              height: 45,
              child: ElevatedButton(
                onPressed: () => _resetPassword(context),
                child: Text('Reset Password'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
