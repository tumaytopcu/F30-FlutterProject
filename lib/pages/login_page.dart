import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login Page'),
      ),
      body: Center(
        child: Text("Merhaba",
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
