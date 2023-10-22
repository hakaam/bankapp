import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../Beneficiaries/addbenficiaryaccountnumber.dart';
import '../Pages/Auth/signin.dart';
import '../Providers/Authprovider/auth_provider.dart';

class BankScreen extends StatefulWidget {
  @override
  _BankScreenState createState() => _BankScreenState();
}

class _BankScreenState extends State<BankScreen> {
  AuthProvider authProvider = AuthProvider();
  List<Bank> banks = [];
  List<Bank> filteredBanks = []; // New list for filtered banks

  @override
  void initState() {
    super.initState();
    fetchBankData();
  }

  void fetchBankData() async {
    final bankData = await fetchBanks();
    setState(() {
      banks = bankData;
      filteredBanks = banks; // Initialize filteredBanks with all banks
    });
  }

  void filterBanks(String query) {
    setState(() {
      filteredBanks = banks
          .where(
              (bank) => bank.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade200,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 65,
                color: Colors.blue.shade600,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: Icon(Icons.arrow_back_ios_new,
                              color: Colors.white),
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
                          onPressed: () async {
                            try {
                              await authProvider.signOut();
                              Navigator.of(context).pushAndRemoveUntil(
                                MaterialPageRoute(
                                  builder: (context) => SignInScreen(),
                                ),
                                (Route<dynamic> route) => false,
                              );
                            } catch (e) {}
                          },
                          icon: Icon(Icons.power_settings_new,
                              color: Colors.white),
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
                        color: Colors.blue.shade600,
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
                          color: Colors.blue.shade600,
                          size: 25,
                        ),
                      ),
                    ),
                    onChanged: (query) {
                      print("query: $query");
                      filterBanks(query);
                    },
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
                  itemCount: filteredBanks.length,
                  itemBuilder: (context, index) {
                    final bank = filteredBanks[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                AddBeneficiaryAccountNumberScreen(
                              bankName: bank.name,
                              imageUrl: bank.image,
                            ),
                          ),
                        );
                      },
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Flexible(
                                flex: 1,
                                child: Container(
                                  clipBehavior: Clip.antiAlias,
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                  ),
                                  child: Image.network(
                                    bank.image,
                                    width: 50,
                                    height: 50,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              SizedBox(width: 30),
                              Flexible(
                                flex: 7,
                                child: Container(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            bank.name,
                                            style: TextStyle(
                                              color: Colors.white,
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
                              thickness: 0.7,
                              color: Colors.blue.shade600,
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
    final querySnapshot =
        await FirebaseFirestore.instance.collection('banks').get();
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
