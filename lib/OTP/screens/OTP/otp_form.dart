import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../services/auth_repo.dart';

class OtpForm extends StatefulWidget {
  const OtpForm({super.key});

  @override
  State<OtpForm> createState() => _OtpFormState();
}

class _OtpFormState extends State<OtpForm> {
  String otpCode = '';
  FocusNode c1 = FocusNode();
  FocusNode c2 = FocusNode();
  FocusNode c3 = FocusNode();
  FocusNode c4 = FocusNode();
  FocusNode c5 = FocusNode();
  FocusNode c6 = FocusNode();
  TextEditingController t1 = TextEditingController();
  TextEditingController t2 = TextEditingController();
  TextEditingController t3 = TextEditingController();
  TextEditingController t4 = TextEditingController();
  TextEditingController t5 = TextEditingController();
  TextEditingController t6 = TextEditingController();
  @override
  void dispose() {
    c1.dispose();
    c2.dispose();
    c3.dispose();
    c4.dispose();
    c5.dispose();
    c6.dispose();
    super.dispose();
  }

  int Seconds = 14;
  Timer? timer;
  @override
  void initState() {
    Timer.periodic(Duration(seconds: 1), (_) {
      if (Seconds > 0) {
        setState(() {
          Seconds--;
        });
      } else {
        timer!.cancel();
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final authData = Provider.of<AuthRepo>(context, listen: false);
    return Form(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                height: 58,
                width: 54,
                child: buildFormFeild1(),
              ),
              SizedBox(
                height: 58,
                width: 54,
                child: buildFormFeild2(),
              ),
              SizedBox(
                height: 58,
                width: 54,
                child: buildFormFeild3(),
              ),
              SizedBox(
                height: 58,
                width: 54,
                child: buildFormFeild4(),
              ),
              SizedBox(
                height: 58,
                width: 54,
                child: buildFormFeild5(),
              ),
              SizedBox(
                height: 58,
                width: 54,
                child: buildFormFeild6(),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            '$Seconds:00',
            style: Theme.of(context).textTheme.headline2,
          ),
          const SizedBox(
            height: 50,
          ),
          ElevatedButton(
            onPressed: () async {
              String otp =
                  t1.text + t2.text + t3.text + t4.text + t5.text + t6.text;
              await authData.submitOTP(otp);
              Navigator.of(context).pushNamed('/home');

            },
            child: Text('Submit'),
          ),
        ],
      ),
    );
  }

  Widget buildFormFeild6() {
    return TextField(
      focusNode: c6,
      controller: t6,
      onChanged: (value) {
        if (value.length == 1) {
          FocusScope.of(context).unfocus();
          otpCode += value;
        }
      },
      keyboardType: TextInputType.number,
      textAlign: TextAlign.center,
      inputFormatters: [
        LengthLimitingTextInputFormatter(1),
        FilteringTextInputFormatter.digitsOnly,
      ],
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      style: TextStyle(),
    );
  }

  Widget buildFormFeild1() {
    return TextField(
      focusNode: c1,
      controller: t1,
      onChanged: (value) {
        if (value.length == 1) {
          FocusScope.of(context).nextFocus();
          otpCode += value;
        }
      },
      keyboardType: TextInputType.number,
      textAlign: TextAlign.center,
      inputFormatters: [
        LengthLimitingTextInputFormatter(1),
        FilteringTextInputFormatter.digitsOnly,
      ],
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      style: TextStyle(),
    );
  }

  Widget buildFormFeild2() {
    return TextField(
      focusNode: c2,
      controller: t2,
      onChanged: (value) {
        if (value.length == 1) {
          FocusScope.of(context).nextFocus();
          otpCode += value;
        }
      },
      keyboardType: TextInputType.number,
      textAlign: TextAlign.center,
      inputFormatters: [
        LengthLimitingTextInputFormatter(1),
        FilteringTextInputFormatter.digitsOnly,
      ],
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      style: TextStyle(),
    );
  }

  Widget buildFormFeild3() {
    return TextField(
      focusNode: c3,
      controller: t3,
      onChanged: (value) {
        if (value.length == 1) {
          FocusScope.of(context).nextFocus();
          otpCode += value;
        }
      },
      keyboardType: TextInputType.number,
      textAlign: TextAlign.center,
      inputFormatters: [
        LengthLimitingTextInputFormatter(1),
        FilteringTextInputFormatter.digitsOnly,
      ],
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      style: TextStyle(),
    );
  }

  Widget buildFormFeild4() {
    return TextField(
      focusNode: c4,
      controller: t4,
      onChanged: (value) {
        if (value.length == 1) {
          FocusScope.of(context).nextFocus();
          otpCode += value;
        }
      },
      keyboardType: TextInputType.number,
      textAlign: TextAlign.center,
      inputFormatters: [
        LengthLimitingTextInputFormatter(1),
        FilteringTextInputFormatter.digitsOnly,
      ],
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      style: TextStyle(),
    );
  }

  Widget buildFormFeild5() {
    return TextField(
      focusNode: c5,
      controller: t5,
      onChanged: (value) {
        if (value.length == 1) {
          FocusScope.of(context).nextFocus();
          otpCode += value;
        }
      },
      keyboardType: TextInputType.number,
      textAlign: TextAlign.center,
      inputFormatters: [
        LengthLimitingTextInputFormatter(1),
        FilteringTextInputFormatter.digitsOnly,
      ],
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      style: TextStyle(),
    );
  }
}
