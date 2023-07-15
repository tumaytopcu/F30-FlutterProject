import 'package:flutter/material.dart';

class addButonu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ürün ekleme sayfası'),
      ),
      body: Container(
        // Alt sayfanın tasarımı burada yapılabilir.
        // Örneğin, ListView, Form vb. kullanılabilir.
        child: Center(
          child: Text('ürün ekleme sayfası'),
        ),
      ),
    );
  }
}
