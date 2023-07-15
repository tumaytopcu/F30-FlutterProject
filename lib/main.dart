import 'package:f30_bootcamp/pages/login_page.dart';
import 'package:f30_bootcamp/pages/welcome_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);
  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'F30',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme: GoogleFonts.openSansTextTheme().apply(
          bodyColor: Colors.white, // Metin rengini beyaz yapar
        ),
      ),
      home: FutureBuilder<bool>(
        future: isFirstTime(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // Burada yüklenme göstergesi veya splash ekranı gösterilebilir
            return CircularProgressIndicator();
          } else if (snapshot.hasError) {
            // Hata yönetimi
            return Scaffold(
              body: Center(
                child: Text('Bir hata oluştu: ${snapshot.error}'),
              ),
            );
          } else if (snapshot.data == true) {
            // Hoş geldiniz sayfasını göster
            return WelcomePage();
          } else {
            // Giriş sayfasını göster
            return LoginPage();
          }
        },
      ),
    );
  }

  Future<bool> isFirstTime() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? isFirstTime = prefs.getBool('isFirstTime');
    if (isFirstTime == null || isFirstTime == true) {
      // Kullanıcının daha önce uygulamayı ziyaret etmediğini belirtmek için isFirstTime değerini false olarak ayarla
      await prefs.setBool('isFirstTime', false);
      return true; // Hoş geldiniz sayfasını göster
    } else {
      return false; // Giriş sayfasını göster
    }
  }

  Future<bool> isLoggedIn() async {
    final User? user = _auth.currentUser;
    return user != null;
  }
}
