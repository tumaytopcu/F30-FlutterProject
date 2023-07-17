import 'package:flutter/material.dart';
import 'package:f30_bootcamp/pages/home_page.dart';
import 'package:f30_bootcamp/pages/register_page.dart';
import 'package:f30_bootcamp/pages/sifremi_unuttum.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final _auth = FirebaseAuth.instance;
  final _googleSignIn = GoogleSignIn(scopes: [
    'email',
    'https://www.googleapis.com/auth/contacts.readonly',
  ]);

  bool _obscurePassword = true;
  bool _isLoading = false;

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    checkCurrentUser();
  }

  Future<void> checkCurrentUser() async {
    final currentUser = _auth.currentUser;
    if (currentUser != null) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    }
  }

  Future<void> handleGoogleSignIn() async {
    try {
      final currentUser = await _googleSignIn.isSignedIn();
      print('CurrentUser: $currentUser');
      if (currentUser) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomePage()),
        );
      }
      final res = await _googleSignIn.signIn();
      print('Google Auth Data: $res');
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    } catch (error) {
      print('Error: $error');
    }
  }

  Future<void> handleSignIn() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });
      try {
        final userCredential = await _auth.signInWithEmailAndPassword(
          email: _usernameController.text.trim(),
          password: _passwordController.text.trim(),
        );
        if (userCredential.user != null) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => HomePage()),
          );
        }
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Kullanıcı bulunamadı.')),
          );
        } else if (e.code == 'wrong-password') {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Yanlış şifre.')),
          );
        }
      } finally {
        setState(() {
          _isLoading = false;
        });
        _usernameController.clear();
        _passwordController.clear();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Color(0xE8E8E8E8E8),
      resizeToAvoidBottomInset: false,
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.only(left: 20.0, right: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Stack(
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
                      children: [
                        Image.asset(
                          'assets/eco_pazar.png',
                          fit: BoxFit.cover,
                          width: 300, // Adjust the width
                          height: 71, // Adjust the height
                        ),
                        SizedBox(height: 8),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Text(
                            'DOĞANIN BEREKETİ, YOLUNUZUN ÜSTÜNDE',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              TextFormField(
                style: TextStyle(color: Color.fromARGB(255, 19, 221, 123)),
                controller: _usernameController,
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Color.fromARGB(255, 19, 221, 123)),
                    borderRadius: BorderRadius.circular(50.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.green),
                    borderRadius: BorderRadius.circular(50.0),
                  ),
                  fillColor: Colors.white,
                  filled: true,
                  hintText: "ecopazar@gmail.com",
                  hintStyle: TextStyle(color: Colors.grey),
                  labelText: "E-mail",
                  labelStyle:
                      TextStyle(color: Color.fromARGB(255, 19, 221, 123)),
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Email giriniz!";
                  }
                  return null;
                },
              ),
              SizedBox(height: 10.0),
              TextFormField(
                style: TextStyle(color: Color.fromARGB(255, 19, 221, 123)),
                controller: _passwordController,
                obscureText: _obscurePassword,
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Color.fromARGB(255, 19, 221, 123)),
                    borderRadius: BorderRadius.all(Radius.circular(50.0)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.green),
                    borderRadius: BorderRadius.circular(50.0),
                  ),
                  fillColor: Colors.white,
                  filled: true,
                  labelText: "Şifre",
                  labelStyle:
                      TextStyle(color: Color.fromARGB(255, 19, 221, 123)),
                  border: OutlineInputBorder(),
                  suffixIcon: GestureDetector(
                    onTap: () {
                      setState(() {
                        _obscurePassword = !_obscurePassword;
                      });
                    },
                    child: Icon(
                      _obscurePassword
                          ? Icons.visibility_off
                          : Icons.visibility,
                      color: Color.fromARGB(255, 19, 221, 123),
                    ),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Şifre giriniz!";
                  }
                  return null;
                },
              ),
              SizedBox(height: 10.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  MaterialButton(
                    child: Text("Üye Ol"),
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => RegisterPage()),
                      );
                    },
                  ),
                  MaterialButton(
                    child: Text("Şifremi Unuttum"),
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => SifrePage()),
                      );
                    },
                  ),
                ],
              ),
              SizedBox(height: 10.0),
              _isLoading ? CircularProgressIndicator() : _loginButton(),
              SizedBox(height: 20.0),
              _googleButton(),
              SizedBox(height: 20.0),
              _withoutRegisterButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _loginButton() {
    return Container(
      height: MediaQuery.of(context).size.height * 0.06,
      width: MediaQuery.of(context).size.width * 0.9,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: ElevatedButton(
        onPressed: handleSignIn,
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(
            Color.fromARGB(255, 19, 221, 123),
          ),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(50.0)),
            ),
          ),
        ),
        child: Text("Giriş Yap"),
      ),
    );
  }

  Widget _googleButton() {
    return Container(
      height: MediaQuery.of(context).size.height * 0.06,
      width: MediaQuery.of(context).size.width * 0.9,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(50.0)),
      ),
      child: FloatingActionButton.extended(
        onPressed: handleGoogleSignIn,
        icon: Image.asset(
          'assets/google_logo.png',
          height: 32,
          width: 32,
        ),
        label: Text("Google ile Giriş Yap"),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(50.0)),
        ),
      ),
    );
  }

  Widget _withoutRegisterButton() {
    return Container(
      height: MediaQuery.of(context).size.height * 0.06,
      width: MediaQuery.of(context).size.width * 0.9,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(50.0)),
      ),
      child: FloatingActionButton.extended(
        onPressed: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => HomePage()),
          );
        },
        label: Text("Üye olmadan devam et"),
        extendedTextStyle: const TextStyle(fontSize: 10),
        backgroundColor: Color(0xE8E8E8E8E8),
        foregroundColor: Colors.black,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(50.0)),
        ),
      ),
    );
  }
}
