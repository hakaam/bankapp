import 'package:flutter/material.dart';

//**************************************LighTColors
const primaryColor = Color(0xFF000814);
const primaryLightColor = Color(0xFFf8f9fa);
const secondaryColor = Color(0xFF757575);
const lightColor = Color(0xFFf6fff8);
const textColor = Color(0xFF757575);

//******************************validation Erorr*********************************************//
const String emailNullError = "Please Enter your email";
const String invalidEmailError = "Please Enter Valid Email";
const String passNullError = "Please Enter your password";
const String shortPassError = "Password is too short";
const String matchPassError = "Passwords don't match";
const String namelNullError = "Please Enter your name";
const String phoneNumberNullError = "Please Enter your phone number";
const String addressNullError = "Please Enter your address";
//********************************Network********************************************************//

OutlineInputBorder outlineInputBorder() {
  return OutlineInputBorder(
    gapPadding: 4.0,
    borderRadius: BorderRadius.circular(15),
    borderSide: const BorderSide(color: Color(0xFFf6fff8)),
  );
}

//****************************TEXT***************************************************/
const bodyText1 = TextStyle(
  fontSize: 16,
  color: textColor,
  fontWeight: FontWeight.w700,
);

const bodyText2 = TextStyle(
  fontSize: 11,
  color: secondaryColor,
  fontWeight: FontWeight.w900,
);
const bodysmall2 = TextStyle(
  fontSize: 16,
  color: primaryColor,
  fontWeight: FontWeight.w900,
);
const headline = TextStyle(
  color: primaryColor,
  fontSize: 17,
  fontWeight: FontWeight.w900,
);
