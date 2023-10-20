// import 'package:bankapp/utils/common.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
//
// import '../Pages/Auth/signin.dart';
// import '../Providers/Authprovider/auth_provider.dart';
//
// class StatementScreen extends StatefulWidget {
//   const StatementScreen({Key? key});
//
//   @override
//   State<StatementScreen> createState() => _StatementScreenState();
// }
//
// class _StatementScreenState extends State<StatementScreen> {
//   AuthProvider authProvider = AuthProvider();
//   Future<void> fetchUserBalance() async {
//     try {
//       final currentUser = FirebaseAuth.instance.currentUser;
//       if (currentUser != null) {
//         DocumentSnapshot userDoc = await FirebaseFirestore.instance
//             .collection("users")
//             .doc(currentUser.uid)
//             .get();
//         if (userDoc.exists) {
//           var balancePKR = userDoc['balancePKR'];
//           var balanceUSD = userDoc['balanceUSD'];
//           var balanceCAD = userDoc['balanceCAD'];
//
//           Map<String, dynamic> balances = {};
//           balances["PKR"] = balancePKR;
//           balances["USD"] = balanceUSD;
//           balances["CAD"] = balanceCAD;
//           print(
//               "Logged Account Number StatementScreen: ${userDoc["accountNumber"]}");
//
//           setState(() {
//             Common.loggedInAccountNo = userDoc["accountNumber"];
//             Common.userBalances = balances;
//             Common.currency = "PKR";
//           });
//         }
//       }
//     } catch (e) {
//       print("Error fetching user balance: $e");
//     }
//   }
//
//   @override
//   void initState() {
//     super.initState();
//     fetchUserBalance();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return StreamBuilder<QuerySnapshot>(
//       stream: FirebaseFirestore.instance
//           .collection('transaction')
//           .where('userId', isEqualTo: FirebaseAuth.instance.currentUser?.uid)
//           .snapshots(),
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return Scaffold(
//             body: Center(child: CircularProgressIndicator()),
//           );
//         }
//
//         if (snapshot.hasError) {
//           return Scaffold(
//             body: Center(child: Text('Error: ${snapshot.error}')),
//           );
//         }
//
//         if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
//           return Scaffold(
//             body: Center(
//                 child: Text('No transactions found for the current user')),
//           );
//         }
//
//         final transactionData = snapshot.data!.docs.map((document) {
//           return document.data() as Map<String, dynamic>;
//         }).toList();
//
//         return _buildStatementUI(transactionData);
//       },
//     );
//   }
//
//   Widget _buildStatementUI(List<Map<String, dynamic>> transactionData) {
//     final groupedTransactions = groupTransactionsByDate(transactionData);
//
//     return Scaffold(
//       backgroundColor: Colors.blue.shade200,
//       body: SafeArea(
//         child: SingleChildScrollView(
//           child: Column(
//             children: [
//               Container(
//                 height: 65,
//                 color: Colors.blue.shade600,
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Row(
//                       children: [
//                         IconButton(
//                           onPressed: () {
//                             Navigator.pop(context);
//                           },
//                           icon: Icon(
//                             Icons.arrow_back_ios_new,
//                             color: Colors.white,
//                           ),
//                         ),
//                         Text(
//                           'My Account',
//                           style: TextStyle(
//                             fontWeight: FontWeight.w700,
//                             fontSize: 15,
//                             color: Colors.white,
//                           ),
//                         ),
//                       ],
//                     ),
//                     Row(
//                       children: [
//                         IconButton(
//                           onPressed: () async {
//                             try {
//                               await authProvider.signOut();
//                               Navigator.of(context).pushAndRemoveUntil(
//                                 MaterialPageRoute(
//                                   builder: (context) => SignInScreen(),
//                                 ),
//                                     (Route<dynamic> route) => false,
//                               );
//                             } catch (e) {}
//                           },
//                           icon: Icon(
//                             Icons.power_settings_new,
//                             color: Colors.white,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//               SizedBox(height: 20),
//               for (var date in groupedTransactions.keys)
//                 Column(
//                   children: [
//                     Material(
//                       color: Colors.white,
//                       elevation: 2,
//                       child: Container(
//                         height: 40,
//                         width: MediaQuery.of(context).size.width,
//                         child: Padding(
//                           padding: const EdgeInsets.only(right: 70),
//                           child: Center(
//                             child: Text(
//                               '${_formatTimestamp(date)}',
//                               style: TextStyle(
//                                 color: Colors.black,
//                                 fontSize: 17,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                     for (var data in groupedTransactions[date]!)
//                       Padding(
//                         padding: const EdgeInsets.symmetric(
//                             horizontal: 20, vertical: 20),
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 SizedBox(height: 5),
//                                 Text(
//                                   'Money Transferred to',
//                                   style: TextStyle(
//                                     fontSize: 20,
//                                     color: Colors.white,
//                                   ),
//                                 ),
//                                 SizedBox(height: 5),
//                                 Row(
//                                   children: [
//                                     SizedBox(width: 5),
//                                     Text(
//                                       ' ${data['receiverTitle'].toString().toUpperCase()}',
//                                       style: TextStyle(
//                                           fontSize: 15, color: Colors.white),
//                                     ),
//                                     Text(
//                                       '-',
//                                       style: TextStyle(
//                                         fontSize: 15,
//                                         color: Colors.white,
//                                       ),
//                                     ),
//                                     Text(
//                                       '${data['bankName'].toString().toUpperCase()}',
//                                       style: TextStyle(
//                                         fontSize: 15,
//                                         color: Colors.white,
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ],
//                             ),
//                             Text(
//                               'Rs. ${double.parse(data['transactionAmount']).toStringAsFixed(2)}',
//                               style: TextStyle(
//                                 fontSize: 15,
//                                 color: Common.loggedInAccountNo ==
//                                     data['receiverAccountNumber']
//                                     ? Colors.blue
//                                     : Colors.red,
//                               ),
//                             )
//                           ],
//                         ),
//                       )
//                   ],
//                 ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   Map<DateTime, List<Map<String, dynamic>>> groupTransactionsByDate(
//       List<Map<String, dynamic>> transactionData) {
//     final groupedTransactions = <DateTime, List<Map<String, dynamic>>>{};
//     for (var data in transactionData) {
//       final timestamp = data['timestamp'] as Timestamp;
//       final date = timestamp.toDate();
//       final truncatedDate = DateTime(date.year, date.month, date.day);
//       groupedTransactions.putIfAbsent(truncatedDate, () => []);
//       groupedTransactions[truncatedDate]!.add(data);
//     }
//     return groupedTransactions;
//   }
//
//   String _formatTimestamp(DateTime dateTime) {
//     final String formattedDate =
//     DateFormat('E, d MMM yyyy', 'en_US').format(dateTime);
//     return formattedDate;
//   }
// }
