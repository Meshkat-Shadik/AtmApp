import 'package:atm_app_v2/presentation/screens/login_screen.dart';
import 'package:atm_app_v2/presentation/screens/transaction_loading_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 100),
              Image.asset(
                'assets/app_logo.png',
                height: 150,
              ),
              const SizedBox(height: 50),
              Container(
                alignment: Alignment.center,
                height: 100,
                color: const Color(0xfff3f3fc),
                child: const Text(
                  "Do you want to transact now?",
                  style: TextStyle(
                    fontSize: 24,
                    color: Color(0xff6380d7),
                  ),
                ),
              ),
              const SizedBox(
                height: 80,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    width: 100,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: ((context) => LoginScreen())));
                      },
                      child: const Text('No'),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.red,
                        elevation: 0,
                      ),
                    ),
                  ),
                  Container(
                    width: 100,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: ((context) =>
                                    TransactionLoadingPage())));
                      },
                      child: const Text('Yes'),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.green,
                        elevation: 0,
                      ),
                    ),
                  ),
                ],
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
