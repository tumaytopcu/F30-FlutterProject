import 'package:flutter/material.dart';
import 'package:f30_bootcamp/pages/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';

final _auth = FirebaseAuth.instance;
final _formKey = GlobalKey<FormState>();
final _emailKey = GlobalKey<FormFieldState>();
final _usernameKey = GlobalKey<FormFieldState>();
final _passwordKey = GlobalKey<FormFieldState>();

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

bool obscurePassword = true;
bool isLoading = false;

class _RegisterPageState extends State<RegisterPage> {
  String username = "";
  String password = "";
  String email = "";
  final _usernameController = TextEditingController();

  @override
  void dispose() {
    _usernameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Color(0xE8E8E8E8E8),
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 19, 221, 123),
        title: Text('Üyel Ol'),
      ),
      body: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: double.infinity,
            height: 200,
          ),
          Positioned(
            top: screenHeight * 0.05,
            left: screenWidth * 0.05,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/eco_pazar.png',
                  fit: BoxFit.cover,
                  width: 300,
                  height: 71,
                ),
                SizedBox(height: 8),
                Text(
                  'DOĞANIN BEREKETİ, YOLUNUZUN ÜSTÜNDE',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(
              screenWidth * 0.05,
              screenHeight * 0.05,
              screenWidth * 0.05,
              screenHeight * 0.05,
            ),
            child: Form(
              key: _formKey, // Add the form key here
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  TextFormField(
                    key: _emailKey,
                    style: TextStyle(color: Color.fromARGB(255, 19, 221, 123)),
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color.fromARGB(255, 19, 221, 123),
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(50.0)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Color.fromARGB(255, 19, 221, 123)),
                        borderRadius: BorderRadius.all(Radius.circular(50.0)),
                      ),
                      fillColor: Colors.white,
                      filled: true,
                      labelText: "Email",
                      labelStyle:
                          TextStyle(color: Color.fromARGB(255, 19, 221, 123)),
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Email giriniz!";
                      } else if (!value.contains('@') || !value.contains('.')) {
                        return "Geçerli bir e-posta adresi giriniz!";
                      } else {
                        return null;
                      }
                    },
                    onSaved: (value) {
                      email = value!;
                    },
                  ),
                  SizedBox(
                    height: screenHeight * 0.02,
                  ),
                  TextFormField(
                    key: _usernameKey,
                    style: TextStyle(color: Color.fromARGB(255, 19, 221, 123)),
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color.fromARGB(255, 19, 221, 123),
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(50.0)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Color.fromARGB(255, 19, 221, 123)),
                        borderRadius: BorderRadius.all(Radius.circular(50.0)),
                      ),
                      fillColor: Colors.white,
                      filled: true,
                      labelText: "Telefon",
                      labelStyle: TextStyle(
                        color: Color.fromARGB(255, 19, 221, 123),
                      ),
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Telefon giriniz!";
                      } else {
                        return null;
                      }
                    },
                    onSaved: (value) {
                      username = value!;
                    },
                  ),
                  SizedBox(
                    height: screenHeight * 0.02,
                  ),
                  TextFormField(
                    key: _passwordKey,
                    style: TextStyle(color: Color.fromARGB(255, 19, 221, 123)),
                    obscureText: obscurePassword,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color.fromARGB(255, 19, 221, 123),
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(50.0)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Color.fromARGB(255, 19, 221, 123)),
                        borderRadius: BorderRadius.all(Radius.circular(50.0)),
                      ),
                      fillColor: Colors.white,
                      filled: true,
                      labelText: "Şifre",
                      labelStyle: TextStyle(
                        color: Color.fromARGB(255, 19, 221, 123),
                      ),
                      border: OutlineInputBorder(),
                      suffixIcon: GestureDetector(
                        onTap: () {
                          setState(() {
                            obscurePassword =
                                !obscurePassword; // Şifre görünürlüğünü değiştir
                          });
                        },
                        child: Icon(
                          obscurePassword
                              ? Icons.visibility_off
                              : Icons.visibility,
                          color: Color.fromARGB(255, 19, 221, 123),
                        ),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Şifre giriniz!";
                      } else {
                        return null;
                      }
                    },
                    onSaved: (value) {
                      password = value!;
                    },
                  ),
                  SizedBox(
                    height: screenHeight * 0.02,
                  ),
                  isLoading
                      ? CircularProgressIndicator()
                      : Container(
                          height: screenHeight * 0.06,
                          width: screenWidth * 0.9,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          child: ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                _formKey.currentState!.save();
                                signUpWithEmailAndPassword(email, password);
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              primary: Color.fromARGB(255, 19, 221, 123),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                            ),
                            child: Text("Kayıt Ol"),
                          ),
                        ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> signUpWithEmailAndPassword(String email, String password) async {
    setState(() {
      isLoading = true; // Yüklenme durumunu başlat
    });

    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      // Kayıt başarılı
      await _auth.currentUser!
          .sendEmailVerification(); // E-posta doğrulama e-postası gönder

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
              "Kayıt başarılı. E-posta doğrulaması için e-postanızı kontrol edin."),
        ),
      );
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => LoginPage()),
      );
    } catch (error) {
      // Kayıt başarısız
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Kayıt başarısız. Hata: $error"),
        ),
      );
    } finally {
      setState(() {
        isLoading = false; // Yüklenme durumunu durdur
      });
    }
  }
}
