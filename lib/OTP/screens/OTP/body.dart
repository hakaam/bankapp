import 'package:flutter/material.dart';

import 'otp_form.dart';

class Body extends StatelessWidget {
  final String phoneNumber;
  Body({
    super.key,
    required this.phoneNumber,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'verify your Phone Number ?',
          style: TextStyle(
            color: Colors.black,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(
          height: 30,
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 2),
          child: RichText(
            text: TextSpan(
              text: 'Please Enter your 6 digit code numbers sent to you at.',
              style: Theme.of(context).textTheme.bodyText1,
              children: <TextSpan>[
                TextSpan(
                  text:
                      '${phoneNumber[2]}****${phoneNumber.substring(phoneNumber.length - 3)}',
                  style: Theme.of(context).textTheme.headline2,
                ),
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        const OtpForm(),
      ],
    );
  }
}
