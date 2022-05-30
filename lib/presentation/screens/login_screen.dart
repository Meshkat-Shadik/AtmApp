import 'package:atm_app_v2/constants.dart';
import 'package:atm_app_v2/presentation/screens/authentication_screen.dart';
import 'package:atm_app_v2/presentation/screens/home_page.dart';
import 'package:atm_app_v2/presentation/screens/registration_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController accountController = TextEditingController();
  TextEditingController pinNumberController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    accountController.dispose();
    pinNumberController.dispose();
  }

  bool isShow = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 20),
              Image.asset(
                'assets/app_logo.png',
                height: 150,
              ),
              const SizedBox(height: 50),
              TextFormField(
                controller: accountController,
                decoration: const InputDecoration(
                  hintText: 'Account Number',
                ),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: pinNumberController,
                decoration: InputDecoration(
                  hintText: 'PIN',
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        isShow = !isShow;
                      });
                    },
                    icon: Icon(
                        !isShow ? Icons.visibility : Icons.visibility_off,
                        color: themeButtonColor1),
                  ),
                ),
                keyboardType: TextInputType.number,
                obscureText: isShow ? false : true,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
//                   var doc_ref = await FirebaseFirestore.instance.collection("users").doc('dsjadjasgdasd').;
// doc_ref.documents.forEach((result) {
//   print(result.documentID);
// });
//                   // Navigator.of(context).push(
                  //   MaterialPageRoute(builder: (context) => HomePage()),
                  // );

                  var collection =
                      FirebaseFirestore.instance.collection('users');
                  var querySnapshots = await collection.get();
                  for (var snapshot in querySnapshots.docs) {
                    var documentID = snapshot.id; //
                    if (documentID == accountController.text.trim()) {
                      snapshot.data().forEach((key, value) {
                        if (key == 'pin') {
                          // print(value);
                          if (value == pinNumberController.text.trim()) {
                            Fluttertoast.showToast(
                              msg: "You are logged in successfully",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.green,
                              textColor: Colors.white,
                              fontSize: 16.0,
                            );
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: ((context) => HomePage())));
                          } else {
                            Fluttertoast.showToast(
                              msg: "Wrong Combination",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.red,
                              textColor: Colors.white,
                              fontSize: 16.0,
                            );
                          }
                        }
                      });

                      //print('Success');
                      // snapshot.
                      //     .where("status", isEqualTo: "active")
                      //     .getDocuments()
                      //     .then(
                      //       (QuerySnapshot snapshot) => {
                      //         driverPolylineCordinates.clear(),
                      //         snapshot.documents.forEach((f) {
                      //           print(
                      //               "documentID---- " + f.reference.documentID);
                      //         }),
                      //       },
                      //     );
                    }
                  }
                },
                child: const Text('ENTER'),
                style: ElevatedButton.styleFrom(
                  primary: const Color(0xff6d7ed6),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Forgot AC Number or PIN',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 5),
              TextButton(
                child: const Text(
                  'REGISTER NOW',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: themeButtonColor1,
                    fontSize: 20,
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (context) => RegistrationScreen()),
                  );
                },
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            Icon(Icons.message),
            Icon(Icons.call),
          ],
        ),
        height: 60,
      ),
    );
  }
}
