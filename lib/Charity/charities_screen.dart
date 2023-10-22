import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../Pages/Auth/signin.dart';
import '../Providers/Authprovider/auth_provider.dart';
import '../utils/common.dart';
import 'fromaccounttoaccountcharityscreen.dart';

class CharityScreen extends StatefulWidget {
  @override
  _CharityScreenState createState() => _CharityScreenState();
}

class _CharityScreenState extends State<CharityScreen> {
  AuthProvider authProvider = AuthProvider();
  List<Charity> charities = [];
  List<Charity> filteredCharities = [];

  @override
  void initState() {
    super.initState();
    fetchCharityData();
  }

  void fetchCharityData() async {
    final charityData = await fetchCharities();
    setState(() {
      charities = charityData;
      filteredCharities = charities;
    });
  }

  void filterCharities(String query) {
    setState(() {
      filteredCharities = charities
          .where((charity) =>
              charity.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        print(Common.userBalances[Common.currency]);
        Navigator.pop(context, Common.userBalances[Common.currency]);
        return true;
      },
      child: Scaffold(
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
                              Navigator.pop(context,
                                  Common.userBalances[Common.currency]);
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
                        hintText: 'Search (e.g. charity name)',
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
                        filterCharities(query);
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
                    itemCount: filteredCharities.length,
                    itemBuilder: (context, index) {
                      final charity = filteredCharities[index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  FromAccountToAccountCharityScreen(
                                charityName: charity.name,
                                charityImgUrl: charity.image,
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
                                      charity.image,
                                      width: 60,
                                      height: 60,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                SizedBox(width: 20),
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
                                              charity.name,
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
      ),
    );
  }
}

class Charity {
  final String name;
  final String image;

  Charity({required this.name, required this.image});
}

Future<List<Charity>> fetchCharities() async {
  try {
    final querySnapshot =
        await FirebaseFirestore.instance.collection('charities').get();
    final charities = querySnapshot.docs.map((doc) {
      final data = doc.data() as Map<String, dynamic>;
      return Charity(
        name: data['name'],
        image: data['image'],
      );
    }).toList();
    return charities;
  } catch (e) {
    print('Error fetching charities: $e');
    return [];
  }
}
