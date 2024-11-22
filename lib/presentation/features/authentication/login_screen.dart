import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Column(
         crossAxisAlignment: CrossAxisAlignment.center,
        children: [
Spacer(),
AspectRatio(
  aspectRatio: 4/2,
  child: Image.asset("assets/fast-delivery.png",
  width: 200,
     height: 200 ,
  ),
),
Spacer(flex: 2,),
        ],
      ),
    );
  }
}
