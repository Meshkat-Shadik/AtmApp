import 'package:atm_app_v2/constants.dart';
import 'package:atm_app_v2/presentation/screens/login_screen.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';

class TransactionSuccessPage extends StatefulWidget {
  const TransactionSuccessPage({Key? key}) : super(key: key);

  @override
  State<TransactionSuccessPage> createState() => _TransactionSuccessPageState();
}

class _TransactionSuccessPageState extends State<TransactionSuccessPage> {
  @override
  void initState() {
    Future.delayed(
      const Duration(milliseconds: 10),
      () {
        CoolAlert.show(
          context: context,
          type: CoolAlertType.success,
          text: "Your transaction was successful!",
          title: "Transaction Amount 2000 Tk",
          onConfirmBtnTap: () {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => LoginScreen()));
          },
          confirmBtnColor: themeButtonColor1,
        );
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
              const SizedBox(height: 100),
            ],
          ),
        ),
      ),
    );
  }
}


/*
    CoolAlert.show(
                context: context,
                type: CoolAlertType.success,
                text: "Your transaction was successful!",
              ),*/