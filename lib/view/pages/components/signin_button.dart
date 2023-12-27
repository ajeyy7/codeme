import 'package:flutter/material.dart';

class Login_Button extends StatelessWidget {
  final String txt;
  final void Function()? ontap;
  const Login_Button({super.key, required this.txt, required this.ontap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
      child: InkWell(
        onTap: ontap,
        child: Container(
          height: 50,
          width: 380,
          decoration: BoxDecoration(
              color: Colors.indigo.shade900,
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                    color: Colors.grey.shade400,
                    spreadRadius: 3,
                    blurRadius: 5,
                    offset: Offset(0, 3)
                )
              ]
          ),
          child: Center(child: Text(txt,style: TextStyle(color: Colors.grey.shade50),)),

        ),
      ),
    );
  }
}
