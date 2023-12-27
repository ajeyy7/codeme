import 'package:codeme/view/pages/home_page.dart';
import 'package:codeme/view/pages/signin_page.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkLoggedIn();
  }

  Future<void> _checkLoggedIn() async {
    final userBox = Hive.box('userBox');
    final String token = userBox.get('token', defaultValue: '');

    await Future.delayed(Duration(seconds: 2));

    if (token.isNotEmpty) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Home_page()),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Login_Page()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
