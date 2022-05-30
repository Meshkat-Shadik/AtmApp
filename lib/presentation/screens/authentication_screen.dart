import 'package:atm_app_v2/constants.dart';
import 'package:atm_app_v2/presentation/screens/registration_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AuthenticationScreen extends StatefulWidget {
  const AuthenticationScreen({Key? key}) : super(key: key);

  @override
  State<AuthenticationScreen> createState() => _AuthenticationScreenState();
}

class _AuthenticationScreenState extends State<AuthenticationScreen> {
  FirebaseAuth auth = FirebaseAuth.instance;

  bool otpVisibility = false;
  bool regVisibility = false;
  User? user;
  String verificationID = "";

  @override
  void dispose() {
    super.dispose();
    _mobileController.dispose();
    otpController.dispose();
  }

  String? userId;

  void loginWithPhone() async {
    auth.verifyPhoneNumber(
      phoneNumber: "+88" + _mobileController.text,
      verificationCompleted: (PhoneAuthCredential credential) async {
        await auth.signInWithCredential(credential).then((value) {
          print(value.user?.uid);
          //  FirebaseFirestore.instance.collection('users').doc(value.user?.uid);
          setState(() {
            userId = value.user!.uid;
          });
        });
      },
      verificationFailed: (FirebaseAuthException e) {
        print(e.message);
      },
      codeSent: (String verificationId, int? resendToken) {
        otpVisibility = true;
        verificationID = verificationId;
        setState(() {});
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }

  //Q4Oy7GODvxVBRFgwitGhW3yMsty1

  void verifyOTP() async {
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationID, smsCode: otpController.text);

    await auth.signInWithCredential(credential).then(
      (value) {
        setState(() {
          user = FirebaseAuth.instance.currentUser;
        });
      },
    ).whenComplete(
      () {
        if (user != null) {
          Fluttertoast.showToast(
            msg: "You are logged in successfully",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0,
          );
          print('User ID Before Navigator' + userId.toString());
          // Navigator.pushReplacement(
          //   context,
          //   MaterialPageRoute(
          //     builder: (context) => RegistrationScreen(userId: userId ?? ''),
          //   ),
          //);
        } else {
          Fluttertoast.showToast(
            msg: "your login is failed",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0,
          );
        }
      },
    );
  }

  late TextEditingController _mobileController = TextEditingController();
  TextEditingController otpController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/app_logo.png',
                  height: 300,
                  width: 300,
                ),
               
                const SizedBox(height: 20),
                Container(
                  width: size.width - 10,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: themeButtonColor1,
                      shape: const StadiumBorder(),
                    ),
                    onPressed: () {
                      if (otpVisibility) {
                        verifyOTP();
                      } else {
                        loginWithPhone();
                      }
                    },
                    child: Text(
                      otpVisibility ? "Verify" : "Authenticate",
                    ),
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
