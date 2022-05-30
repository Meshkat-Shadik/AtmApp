import 'package:atm_app_v2/constants.dart';
import 'package:atm_app_v2/presentation/screens/login_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  late TextEditingController _nameController = TextEditingController();
  late TextEditingController _accountController = TextEditingController();
  late TextEditingController _nidController = TextEditingController();
  late TextEditingController _mobileController = TextEditingController();
  late TextEditingController _mailController = TextEditingController();
  late TextEditingController _pinController = TextEditingController();
  TextEditingController otpController = TextEditingController();

  bool otpVisibility = false;
  bool regVisibility = false;
  User? user;
  String verificationID = "";
  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
    _accountController.dispose();
    _nidController.dispose();
    _mailController.dispose();
    _mobileController.dispose();
    _pinController.dispose();
  }

  void registerWithPhone() async {
    auth.verifyPhoneNumber(
      phoneNumber: "+88" + _mobileController.text,
      verificationCompleted: (PhoneAuthCredential credential) async {
        await auth.signInWithCredential(credential).then((value) {
          print(value.user?.uid);
          //  FirebaseFirestore.instance.collection('users').doc(value.user?.uid);
          //    print(widget.userId);

          // final jsonValue = {
          //   'name': _nameController.text.trim(),
          //   'account': _accountController.text.trim(),
          //   'phone': _mobileController.text.trim(),
          //   'nid': _nidController.text.trim(),
          //   'pin': _pinController.text.trim(),
          //   'email': _mailController.text.trim(),
          // };
          // await FirebaseFirestore.instance
          //     .collection('users')
          //     .doc(value.user?.uid)
          //     .set(jsonValue).whenComplete(() => print('sdhdfghsfjahsfgjafgsafsajhS'));
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
      () async {
        if (user != null) {
          Fluttertoast.showToast(
            msg: "Resgistered successfully",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0,
          );
          // print('--------------------------------------');
          // print('kf = ' + user!.uid);
          // print('User ID Before Navigator = ' + auth.currentUser!.uid);

          final docUser = FirebaseFirestore.instance
              .collection('users')
              .doc(_accountController.text);
          final jsonValue = {
            'name': _nameController.text.trim(),
            'account': _accountController.text.trim(),
            'phone': _mobileController.text.trim(),
            'nid': _nidController.text.trim(),
            'pin': _pinController.text.trim(),
            'email': _mailController.text.trim(),
          };
          await docUser.set(jsonValue);

          //    print('User ID Before Navigator' + userId.toString());
          // Navigator.pushReplacement(
          //   context,
          //   MaterialPageRoute(
          //     builder: (context) => RegistrationScreen(userId: userId ?? ''),
          //   ),
          //);
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => LoginScreen(),
            ),
          );
        } else {
          Fluttertoast.showToast(
            msg: "your resgistration is failed",
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

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    //  print(widget.userId);
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Center(
                  child: Image.asset(
                    'assets/app_logo.png',
                    height: 100,
                    width: 100,
                  ),
                ),
                TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(
                      labelText: "Full Name*",
                      labelStyle:
                          themeTextStyle1.copyWith(color: Colors.black38),
                      floatingLabelBehavior: FloatingLabelBehavior.auto),
                ),
                TextFormField(
                  controller: _accountController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      labelText: "Account Number*",
                      labelStyle:
                          themeTextStyle1.copyWith(color: Colors.black38),
                      floatingLabelBehavior: FloatingLabelBehavior.auto),
                ),
                TextFormField(
                  controller: _nidController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      labelText: "NID Number*",
                      labelStyle:
                          themeTextStyle1.copyWith(color: Colors.black38),
                      floatingLabelBehavior: FloatingLabelBehavior.auto),
                ),
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  controller: _mailController,
                  decoration: InputDecoration(
                      labelText: "E-Mail Address*",
                      labelStyle:
                          themeTextStyle1.copyWith(color: Colors.black38),
                      floatingLabelBehavior: FloatingLabelBehavior.auto),
                ),
                TextFormField(
                  controller: _pinController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      labelText: "PIN Number*",
                      labelStyle:
                          themeTextStyle1.copyWith(color: Colors.black38),
                      floatingLabelBehavior: FloatingLabelBehavior.auto),
                ),
                TextField(
                  controller: _mobileController,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                      prefix: const Padding(
                        padding: EdgeInsets.all(4),
                        child: Text(
                          '+88',
                          style: themeTextStyle1,
                        ),
                      ),
                      labelText: "Mobile Number*",
                      labelStyle:
                          themeTextStyle1.copyWith(color: Colors.black38),
                      floatingLabelBehavior: FloatingLabelBehavior.auto),
                ),
                Visibility(
                  child: TextField(
                    controller: otpController,
                    decoration: const InputDecoration(
                      hintText: 'OTP',
                      prefix: Padding(
                        padding: EdgeInsets.all(4),
                        child: Text(''),
                      ),
                    ),
                    maxLength: 6,
                    keyboardType: TextInputType.number,
                  ),
                  visible: otpVisibility,
                ),
                Container(
                  width: size.width - 10,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: themeButtonColor1,
                      shape: StadiumBorder(),
                    ),
                    onPressed: () async {
                      if (otpVisibility) {
                        verifyOTP();
                      } else {
                        registerWithPhone();
                      }
                      // print(widget.userId);
                      // final docUser = FirebaseFirestore.instance
                      //     .collection('users')
                      //     .doc(widget.userId);
                      // final jsonValue = {
                      //   'name': _nameController.text.trim(),
                      //   'account': _accountController.text.trim(),
                      //   'phone': _mobileController.text.trim(),
                      //   'nid': _nidController.text.trim(),
                      //   'pin': _pinController.text.trim(),
                      //   'email': _mailController.text.trim(),
                      // };
                      // await docUser.set(jsonValue);
                    },
                    child: Text(otpVisibility ? 'Register' : 'Authenticate'),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Already have an account?',
                      style: themeTextStyle1,
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => LoginScreen(),
                          ),
                        );
                      },
                      child: Text(
                        'Sign In',
                        style: themeTextStyle1.copyWith(
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
