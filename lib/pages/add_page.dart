import 'package:flutter/material.dart';

class AddPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.add,
              size: 48,
            ),
            SizedBox(height: 16),
            Text(
              'Welcome to the Add Page!',
              style: TextStyle(fontSize: 24),
            ),
          ],
        ),
      ),
    );
  }
}
