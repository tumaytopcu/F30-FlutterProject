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

const List<String> scopes = <String>[
  'email',
  'https://www.googleapis.com/auth/contacts.readonly',
];

GoogleSignIn _googleSignIn = GoogleSignIn(
  // Optional clientId
  clientId:
      '558295029611-4h59dqvucjgon6ovnrnppqen3hien86j.apps.googleusercontent.com',
  // clientId: 'your-client_id.apps.googleusercontent.com',
  scopes: scopes,
);

Future<void> _handleSignIn(BuildContext context) async {
  try {
    var _currentUser = await _googleSignIn.isSignedIn();
    print('CurrentUser: $_currentUser');
    if (_currentUser) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    }
    var res = await _googleSignIn.signIn();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => HomePage()),
    );
    print('google auth dan gelen data, $res');
  } catch (error) {
    print('errorr: $error');
  }
}

bool obscurePassword = true;

class _LoginPageState extends State<LoginPage> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final _auth = FirebaseAuth.instance;

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    // Check if there is a current user
    final currentUser = _auth.currentUser;
    if (currentUser != null) {
      // Navigate to the main page
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    color: Colors.blue,
                  ),
                  Positioned(
                    top: 20, // Yüksekliği ayarlayın
                    left: 20, // Sol kenardan uzaklığı ayarlayın
                    child: Image.asset(
                      'assets/eco_pazar.png',
                      fit: BoxFit.cover,
                      width: 150, // Genişliği ayarlayın
                      height: 150, // Yüksekliği ayarlayın
                    ),
                  ),
                ],
              ),
              TextFormField(
                style: TextStyle(color: Colors.blue),
                controller: usernameController,
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                  ),
                  hintText: "ecopazar@gmail.com",
                  hintStyle: TextStyle(color: Colors.grey),
                  labelText: "E-mail",
                  labelStyle: TextStyle(color: Colors.blue),
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value != null && value.isEmpty) {
                    return "Telefon numarası giriniz!";
                  } else {
                    return null;
                  }
                },
              ),
              SizedBox(
                height: 10.0,
              ),
              TextFormField(
                style: TextStyle(color: Colors.blue),
                controller: passwordController,
                obscureText: obscurePassword,
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue),
                  ),
                  labelText: "Şifre",
                  labelStyle: TextStyle(color: Colors.blue),
                  border: OutlineInputBorder(),
                  suffixIcon: GestureDetector(
                    onTap: () {
                      setState(() {
                        obscurePassword = !obscurePassword;
                      });
                    },
                    child: Icon(
                      obscurePassword ? Icons.visibility_off : Icons.visibility,
                    ),
                  ),
                ),
                validator: (value) {
                  if (value != null && value.isEmpty) {
                    return "Şifre giriniz!";
                  } else {
                    return null;
                  }
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Builder(
                    builder: (BuildContext context) {
                      return MaterialButton(
                        child: Text("Üye Ol"),
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (context) => RegisterPage()),
                          );
                        },
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
              _loginButton(),
              SizedBox(
                height: 20.0,
              ),
              _googleButton(),
              SizedBox(
                height: 50.0,
              ),
              _withoutRegisterButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _loginButton() {
    return ElevatedButton(
      onPressed: () async {
        if (_formKey.currentState!.validate()) {
          try {
            final userCredential = await _auth.signInWithEmailAndPassword(
              email: usernameController.text.trim(),
              password: passwordController.text.trim(),
            );
            if (userCredential.user != null) {
              // Login successful
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => HomePage()),
              );
            }
          } on FirebaseAuthException catch (e) {
            if (e.code == 'user-not-found') {
              // User not found
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text("Kullanıcı bulunamadı."),
                ),
              );
            } else if (e.code == 'wrong-password') {
              // Wrong password
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text("Yanlış şifre."),
                ),
              );
            }
          }
          // Clear the username and password fields
          usernameController.clear();
          passwordController.clear();
        }
      },
      child: Text("Giriş Yap"),
    );
  }

  Widget _googleButton() {
    return FloatingActionButton.extended(
      onPressed: () => {
        _handleSignIn(context),
      },
      icon: Image.asset(
        'assets/google_logo.png',
        height: 32,
        width: 32,
      ),
      label: Text("Google ile Giriş Yap"),
      backgroundColor: Colors.white,
      foregroundColor: Colors.blue,
    );
  }

  Widget _withoutRegisterButton() {
    return FloatingActionButton.extended(
      onPressed: () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomePage()),
        );
      },
      label: Text("Üye olmadan devam et"),
      extendedTextStyle: const TextStyle(fontSize: 10),
      backgroundColor: Colors.white,
      foregroundColor: Colors.blue,
    );
  }
}
