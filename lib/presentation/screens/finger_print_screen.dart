import 'package:atm_app_v2/api/local_auth_api.dart';
import 'package:atm_app_v2/presentation/screens/login_screen.dart';
import 'package:flutter/material.dart';

class FingerprintPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(
        body: Stack(
          children: [
            Positioned(
              child: Container(
                height: 900,
                width: double.infinity,
              ),
            ),
            Container(
              alignment: Alignment.center,
              height: 200,
              decoration: const BoxDecoration(
                color: Color(0xff6d7ed6),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text(
                    'Welcome Back!',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 32,
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Face and Fingerprint Login',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              top: 200,
              left: -20,
              right: 0,
              child: Container(
                height: 500,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.face,
                            size: 72,
                          ),
                        ),
                        const SizedBox(height: 30),
                        const Padding(
                          padding: EdgeInsets.only(left: 30),
                          child: Text('Face Authentication'),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        IconButton(
                          onPressed: () async {
                            //print('hello ');
                            final isAuthenticated =
                                await LocalAuthApi.authenticate();

                            if (isAuthenticated) {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                    builder: (context) => LoginScreen()),
                              );
                            }
                          },
                          icon: const Icon(
                            Icons.fingerprint,
                            size: 72,
                          ),
                        ),
                        const SizedBox(height: 30),
                        const Padding(
                          padding: EdgeInsets.only(left: 35),
                          child: Text('Fingerprint Authentication'),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.password,
                            size: 72,
                          ),
                        ),
                        const SizedBox(height: 30),
                        const Padding(
                          padding: EdgeInsets.only(left: 35),
                          child: Text('Password Authentication'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
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