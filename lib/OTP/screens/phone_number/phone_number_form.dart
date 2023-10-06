import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../services/auth_repo.dart';

class PhoneNumberForm extends StatefulWidget {
  const PhoneNumberForm({Key? key}) : super(key: key);

  @override
  State<PhoneNumberForm> createState() => _PhoneNumberFormState();
}

class _PhoneNumberFormState extends State<PhoneNumberForm> {
  late final TextEditingController _text;
  bool _validate = false;
  String _selectedOption2 = '🇸🇦';

  @override
  void initState() {
    super.initState();
    _text = TextEditingController(); // Initialize the _text controller
  }

  @override
  Widget build(BuildContext context) {
    final authData = Provider.of<AuthRepo>(context, listen: false);
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(12),
            child: Column(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  height: MediaQuery.of(context).size.height * 0.15,
                  child: Icon(Icons.add, color: Colors.white),
                ),
                const SizedBox(
                  height: 30,
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 2),
                  child: RichText(
                    text: TextSpan(
                      text: 'Please Enter your Phone Number.',
                      style: Theme.of(context).textTheme.headline1,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.9,
                  height: MediaQuery.of(context).size.height * 0.2,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(top: 10),
                        width: MediaQuery.of(context).size.width * 0.19,
                        height: MediaQuery.of(context).size.height * 0.2,
                        child: formField(),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 30),
                        child: Text(
                          authData.gettingNumber(_selectedOption2),
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.5,
                        height: MediaQuery.of(context).size.height * 0.2,
                        child: buildPhoneNumber(),
                      ),
                    ],
                  ),
                ),
                ElevatedButton(
                  onPressed: () async {
                    if (_text.text.isEmpty) {
                      setState(() {
                        _validate = true;
                      });
                      return;
                    }
                    _validate = false;
                    final phoneNumber =
                        authData.gettingNumber(_selectedOption2) + _text.text;

                    await authData.submitPhoneNumber(phoneNumber);
                    if (!mounted) return;
                    Navigator.of(context)
                        .pushNamed('/otp', arguments: phoneNumber);
                  },
                  child: const Text('verify'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildPhoneNumber() {
    return TextField(
      onChanged: (value) {
        _text.text = value;
      },
      decoration: InputDecoration(
        fillColor: Colors.transparent,
        filled: true,
        errorText: _validate ? 'Please Enter your Phone Number' : null,
        hintText: "Enter your phoneNumber",
        hintStyle: Theme.of(context).textTheme.bodyText2,
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
      keyboardType: TextInputType.phone,
      style: const TextStyle(color: Colors.black),
    );
  }

  Widget formField() {
    return DropdownButtonFormField<String>(
      value: _selectedOption2,
      isExpanded: true,
      icon: const Icon(Icons.arrow_drop_down),
      items: <String>['PK', '🇸🇦', '🇦🇪', '🇪🇬'].map((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(
            value,
            style: const TextStyle(fontSize: 20),
          ),
        );
      }).toList(),
      onChanged: (String? newValue) {
        setState(() {
          _selectedOption2 = newValue!;
        });
      },
      decoration: const InputDecoration(
        fillColor: Colors.transparent,
        border: InputBorder.none,
        filled: true,
        floatingLabelAlignment: FloatingLabelAlignment.center,
      ),
    );
  }
}
