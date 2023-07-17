import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

//harita ekle

class AddPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WebView(
        initialUrl: 'https://www.google.com/maps', // Google Haritalar'ın URL'si
        javascriptMode: JavascriptMode.unrestricted,
      ),
    );
  }
}
