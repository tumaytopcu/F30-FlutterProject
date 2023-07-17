import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:f30_bootcamp/pages/anaekran_içeriği/anaekran_listview.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const MaterialApp(
    home: AnaEkran(),
  ));
}
