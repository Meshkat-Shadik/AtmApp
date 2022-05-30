import 'package:atm_app_v2/constants.dart';
import 'package:atm_app_v2/presentation/screens/transaction_success_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class TransactionLoadingPage extends StatefulWidget {
  const TransactionLoadingPage({Key? key}) : super(key: key);

  @override
  State<TransactionLoadingPage> createState() => _TransactionLoadingPageState();
}

class _TransactionLoadingPageState extends State<TransactionLoadingPage> {
  @override
  void initState() {
    Future.delayed(
      const Duration(seconds: 5),
      () {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => TransactionSuccessPage()));
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: Center(
        child: Column(
          children: [
            Image.asset('assets/app_logo.png', height: 300, width: 300),
            SizedBox(height: 100),
            SpinKitRing(
              color: themeButtonColor1,
              size: 80,
            ),
            SizedBox(height: 20),
            Text(
              'Loading Transaction....',
              style: themeTextStyle1.copyWith(
                  color: themeButtonColor1,
                  fontSize: 22,
                  fontWeight: FontWeight.bold),
            )
          ],
        ),
      )),
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
