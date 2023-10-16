import 'package:bankapp/Home/bank_screen.dart';
import 'package:bankapp/Home/fromaccounttoaccountscreeen.dart';
import 'package:bankapp/utils/common.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../Pages/Auth/signin.dart';
import '../Providers/Authprovider/auth_provider.dart';

class TransferScreen extends StatefulWidget {
  State<TransferScreen> createState() => _TransferScreenState();
}

class _TransferScreenState extends State<TransferScreen> {
  AuthProvider authProvider = AuthProvider();

  Future<List<Map<String, dynamic>>> fetchBeneficiaryData() async {
    try {
      final userId = FirebaseAuth.instance.currentUser!.uid;
      final beneficiaryRef =
          FirebaseFirestore.instance.collection("beneficiaries");

      final querySnapshot =
          await beneficiaryRef.where('userId', isEqualTo: userId).get();

      final beneficiaryData = querySnapshot.docs.map((doc) {
        final Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        data['documentId'] = doc.id; // Add the documentId to the data
        return data;
      }).toList();

      print("Beneficiary Data:");
      print(beneficiaryData);
      return beneficiaryData;
    } catch (e) {
      print("Error fetching beneficiary data: $e");
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    print(Common.userBalances);
    return WillPopScope(
      onWillPop: () async {
        print(Common.userBalances[Common.currency]);
        Navigator.pop(context, Common.userBalances[Common.currency]);
        return true;
      },
      child: Scaffold(
        backgroundColor: Colors.blue.shade200,
        body: SafeArea(
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
                            icon: Icon(
                              Icons.arrow_back_ios_new,
                              color: Colors.white,
                            )),
                        Text(
                          'Send Money',
                          style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 15,
                              color: Colors.white),
                        )
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
                                      builder: (context) => SignInScreen()),
                                  (Route<dynamic> route) => false);
                            } catch (e) {}
                          },
                          icon: Icon(Icons.power_settings_new,
                              color: Colors.white),
                        ),
                      ],
                    )
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
                      hintText: 'Search(e.g.nick,account,title,bank)',
                      hintStyle: TextStyle(
                          color: Colors.blue.shade600,
                          fontWeight: FontWeight.w700),
                      border: InputBorder.none,
                      prefixIcon: Padding(
                        padding: EdgeInsets.only(
                            left: 20, right: 8), // Adjust the padding as needed
                        child: Icon(
                          Icons.search,
                          color: Colors.blue.shade600,
                          size: 25,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 12),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => BankScreen())).then((result) {
                      setState(() {
                        fetchBeneficiaryData();
                      });
                    });
                  },
                  child: Container(
                    color: Colors.transparent,
                    child: Row(
                      children: [
                        SizedBox(
                          width: 10,
                        ),
                        Flexible(
                          flex: 1,
                          child: Container(
                            child: FaIcon(
                              FontAwesomeIcons.userPlus,
                              color: Colors.white,
                              size: 18,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Flexible(
                          flex: 2,
                          child: Container(
                            child: Text(
                              'Add New Beneficiary',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ),
                            // Your existing code for "Add New Beneficiary"
                            // ...
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 4,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 0),
                child: Divider(
                  color: Colors.blue.shade600,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Expanded(
                child: StreamBuilder<List<Map<String, dynamic>>>(
                  stream: Stream.fromFuture(fetchBeneficiaryData()),
                  builder: (context, snapshot) {
                    if (snapshot.hasData && snapshot.data != null) {
                      final beneficiaryData = snapshot.data!;

                      return ListView(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        children: [
                          SizedBox(height: 15),
                          for (final data in beneficiaryData)
                            BeneficiaryItem(
                              bankName: data['bankName'],
                              receiverAccountNumber:
                                  data['receiverAccountNumber'],
                              imagePath: data['imageUrl'],
                              accountTitle: data['userName'],
                              nickName: data['nickName'],
                              documentId: data[
                                  'documentId'], // Pass the documentId here
                            ),
                        ],
                      );
                    } else if (snapshot.connectionState ==
                        ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else {
                      return Center(
                        child: Text('No beneficiaries found.'),
                      );
                    }
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

class BeneficiaryItem extends StatelessWidget {
  final String imagePath;
  final String accountTitle;
  final String bankName;
  final String receiverAccountNumber;
  final String nickName;
  final String documentId; // Add documentId as a field

  const BeneficiaryItem({
    Key? key,
    required this.bankName,
    required this.receiverAccountNumber,
    required this.imagePath,
    required this.accountTitle,
    required this.nickName,
    required this.documentId, // Include documentId in the constructor
  }) : super(key: key);

  void _deleteData(BuildContext context) {
    FirebaseFirestore.instance
        .collection("beneficiaries")
        .doc(
            documentId) // Use the provided documentId to target the specific document
        .get()
        .then((docSnapshot) {
      if (docSnapshot.exists) {
        final data = docSnapshot.data() as Map<String, dynamic>;

        // Capture the details from the document
        final receiverAccountNumber = data['receiverAccountNumber'];
        final bankName = data['bankName'];
        final imageUrl = data['imageUrl'];
        final nickName = data['nickName'];

        // Delete the document
        docSnapshot.reference.delete();

        // Show a snackbar with the details
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Document successfully deleted'),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Document not found!'),
          ),
        );
      }
    }).catchError((error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Error deleting document: $error"),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 12),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => FromAccountToAccountScreen(
                imagePath: imagePath,
                accountTitle: accountTitle,
                nickName: nickName,
                bankName: bankName,
                receiverAccountNumber: receiverAccountNumber,
              ),
            ),
          );
        },
        child: Row(
          children: [
            Flexible(
              flex: 1,
              child: Container(
                child: Image.network(
                  imagePath,
                ),
              ),
            ),
            SizedBox(width: 10),
            Flexible(
              flex: 6,
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          accountTitle,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Spacer(),
                        IconButton(
                          onPressed: () {
                            _deleteData(context); // Pass the context here
                          },
                          icon: Icon(Icons.delete, color: Colors.white),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          bankName,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(width: 10),
                        Text(
                          receiverAccountNumber,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 7),
                    Text(
                      nickName,
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Divider(
              color: Colors.red,
            )
          ],
        ),
      ),
    );
  }
}
