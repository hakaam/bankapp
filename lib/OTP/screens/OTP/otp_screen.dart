import 'package:flutter/material.dart';

import 'body.dart';

class OtpScreen extends StatelessWidget {
  static const routeName = '/OtpScreen';
  const OtpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final phoneNumber = ModalRoute.of(context)!.settings.arguments as String;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(6),
            child: Body(
              phoneNumber: phoneNumber,
            ),
          ),
        ),
      ),
    );
  }
}
