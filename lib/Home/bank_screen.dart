import 'package:bankapp/Home/addbenficiaryaccountnumber.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class BankScreen extends StatefulWidget {



  @override
  _BankScreenState createState() => _BankScreenState();
}

class _BankScreenState extends State<BankScreen> {
  List<Bank> banks = [];

  @override
  void initState() {
    super.initState();
    fetchBankData();
  }

  void fetchBankData() async {
    final bankData = await fetchBanks();
    setState(() {
      banks = bankData;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: [
            Container(
              height: 65,
              color: Colors.purple,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(Icons.arrow_back_ios_new, color: Colors.white),
                      ),
                      Text(
                        'Send Money',
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 15,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.home_outlined, color: Colors.orange),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.notifications, color: Colors.orange),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.power_settings_new, color: Colors.orange),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              height: 60,
              decoration: BoxDecoration(
                color: Colors.white,
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Search (e.g. bank name)',
                    hintStyle: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w700,
                    ),
                    border: InputBorder.none,
                    prefixIcon: Padding(
                      padding: EdgeInsets.only(
                        left: 20,
                        right: 8,
                      ),
                      child: Icon(
                        Icons.search,
                        size: 25,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: banks.length,
                itemBuilder: (context, index) {
                  final bank = banks[index];
                  return GestureDetector(
                    onTap: () {
                      // Handle the tap event for the bank item

                      Navigator.push(context, MaterialPageRoute(builder: (context)=>AddBeneficiaryAccountNumberScreen(
                          bankName:bank.name,
                          imageUrl: bank.image,


                      )));
                    },
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Flexible(
                              flex: 1,
                              child: Container(
                                child: Image.network(
                                  bank.image, // Use bank's image URL
                                  width: 60,
                                  height: 60,
                                ),
                              ),
                            ),
                            SizedBox(width: 20),
                            Flexible(
                              flex: 7,
                              child: Container(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          bank.name, // Use bank's name
                                          style: TextStyle(
                                            color: Colors.orange,
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 65),
                          child: Divider(
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Bank {
  final String name;
  final String image;

  Bank({required this.name, required this.image});
}

Future<List<Bank>> fetchBanks() async {
  try {
    final querySnapshot = await FirebaseFirestore.instance.collection('banks').get();
    final banks = querySnapshot.docs.map((doc) {
      final data = doc.data() as Map<String, dynamic>;
      return Bank(
        name: data['name'],
        image: data['image'],
      );
    }).toList();
    return banks;
  } catch (e) {
    print('Error fetching banks: $e');
    return [];
  }
}
