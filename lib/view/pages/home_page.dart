import 'dart:convert';

import 'package:codeme/model/person_details.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;

class Home_page extends StatefulWidget {
  const Home_page({super.key});

  @override
  State<Home_page> createState() => _Home_pageState();
}

class _Home_pageState extends State<Home_page> {
  Personname? personname;
  getdata() async {
    final userBox = await Hive.box('userBox');
   var token = userBox.get("token");
   print(token);
    final String apiUrl =
        'https://crm-beta-api.vozlead.in/api/v2/lead/lead_list/';
    final response = await http
        .get(Uri.parse(apiUrl), headers: {"Authorization": "Token $token"});
    print(response.statusCode);
    if(response.statusCode==200){
      var jsondata=jsonDecode(response.body);
      personname=Personname.fromJson(jsondata);
    }
  }


  @override
  void initState() {
    super.initState();

    getdata();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Container(
                  height: 80,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(18),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey.shade400,
                            spreadRadius: 3,
                            blurRadius: 5,
                            offset: Offset(0, 3))
                      ]),
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.sort,
                              size: 40,
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Text(
                              'Lead List',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20),
                            ),
                          ],
                        ),
                        Icon(Icons.notifications, size: 30)
                      ],
                    ),
                  )),
            ),
            Expanded(
              child: ListView.builder(
                itemCount:personname!.data!.leads!.length ?? 0 ,
                itemBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Container(
                    height: 120,
                    width: 380,
                    decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey.shade400,
                              spreadRadius: 3,
                              blurRadius: 5,
                              offset: Offset(0, 3))
                        ]),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Container(
                            height: 40,
                            width: 30,
                            decoration: BoxDecoration(
                              color: Colors.blue.shade200,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child:  Center(child: Text(personname?.data?.leads?[index].id.toString() ?? '',style: TextStyle(fontSize: 9),)),
                          ),
                        ),
                         Padding(
                           padding: const EdgeInsets.all(8.0),
                           child: Column(
                             crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                                Text(personname?.data?.leads?[index].name ?? ''),
                              Text(personname?.data?.leads?[index].email ?? ''),
                              Text(personname?.data?.leads?[index].createdAt.toString() ?? ''),
                              Text(personname?.data?.leads?[index].mobile ?? ''),
                            ],
                                                   ),
                         ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Icon(Icons.location_on),
                                Text(locationValues.reverse[personname?.data?.leads?[index].location] ?? ''),
                              ],
                            ),
                            Container(
                              height: 40,
                              width: 70,
                              decoration: BoxDecoration(
                                color: Colors.blue.shade200,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child:  Center(child: Text(interestValues.reverse[personname?.data?.leads?[index].interest] ?? ''),
                              )),
                          ],
                        ),
                         Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.wifi_calling_3_rounded,
                              size: 26,
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
