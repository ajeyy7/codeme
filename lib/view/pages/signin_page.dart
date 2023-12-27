import 'dart:convert';

import 'package:codeme/view/pages/components/signin_button.dart';
import 'package:codeme/view/pages/components/signin_textfiled.dart';
import 'package:codeme/view/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;

class Login_Page extends StatefulWidget {
  Login_Page({super.key});

  @override
  State<Login_Page> createState() => _Login_PageState();
}

class _Login_PageState extends State<Login_Page> {
  TextEditingController usercontroller = TextEditingController();
  TextEditingController passcontroller = TextEditingController();

  Future<void> signIn(
      {required String username, required String passwords}) async {
    final String apiUrl =
        'https://crm-beta-api.vozlead.in/api/v2/account/login/';

    final response = await http.post(
      Uri.parse(apiUrl),
      body: {
        'username': username,
        'password': passwords,
      },
    );
    print(response.statusCode);
   // print(response.body);
    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);

      final userBox = Hive.box('userBox');
      userBox.put('token', responseData['data']['token']);

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Home_page()),
      );
    } else {
      print('Authentication failed');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 380,
            width: double.infinity,
            decoration: const BoxDecoration(
                borderRadius:
                    BorderRadius.only(bottomRight: Radius.circular(140)),
                image: DecorationImage(
                    fit: BoxFit.fill,
                    image: AssetImage("assets/images/login_logo.jpg"))),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Sign In",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.blueAccent,
                      fontSize: 28),
                ),
                SizedBox(height: 17),
                Text(" Welcome Back! Please Enter Your Credentials To Login",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.grey.shade700,
                        fontSize: 14)),
              ],
            ),
          ),
          TextField_sign(
            txt: "UserName",
            controller: usercontroller,
          ),
          TextField_sign(
            txt: "Password",
            controller: passcontroller,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const Text("Forgot Your "),
                Text(
                  "Password?",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.indigo.shade900,
                      fontSize: 14),
                ),
              ],
            ),
          ),
          Login_Button(
              txt: "Sign In",
              ontap: () {
                signIn(
                    passwords: passcontroller.text.trim(),
                    username: usercontroller.text.trim());
                // Navigator.push(context,
                //     MaterialPageRoute(builder: (context) => Home_page()));
              }),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Dont have an account?"),
              Text(
                "SignUp?",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.indigo.shade900,
                    fontSize: 14),
              ),
            ],
          ),
        ],
      ),
    ));
  }
}
