import 'package:f30_bootcamp/pages/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

final _auth = FirebaseAuth.instance;

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

bool obscurePassword = true;

class _RegisterPageState extends State<RegisterPage> {
  String username = "";
  String password = "";
  String email = "";
  final _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('Register Page'),
      ),
      body: Form(
        key: _formkey,
        child: Padding(
          padding: const EdgeInsets.only(left: 20.0, right: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextFormField(
                style: TextStyle(color: Colors.blue),
                //autovalidateMode: AutovalidateMode.always,
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                  ),
                  labelText: "Email",
                  labelStyle: TextStyle(color: Colors.blue),
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value != null && value.isEmpty) {
                    return "Email giriniz!";
                  } else {
                    return null;
                  }
                },
                onSaved: (value) {
                  email = value!;
                },
              ),
              SizedBox(
                height: 10.0,
              ),
              TextFormField(
                style: TextStyle(color: Colors.blue),
                //autovalidateMode: AutovalidateMode.always,
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                  ),
                  labelText: "Telefon",
                  labelStyle: TextStyle(color: Colors.blue),
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value != null && value.isEmpty) {
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
                height: 10.0,
              ),
              TextFormField(
                style: TextStyle(color: Colors.blue),
                obscureText: obscurePassword,
                //autovalidateMode: AutovalidateMode.always,
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                  ),
                  labelText: "Şifre",
                  labelStyle: TextStyle(color: Colors.blue),
                  border: OutlineInputBorder(),
                  suffixIcon: GestureDetector(
                    onTap: () {
                      setState(() {
                        obscurePassword =
                            !obscurePassword; // Şifre görünürlüğünü değiştir
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
                onSaved: (value) {
                  password = value!;
                },
              ),
              SizedBox(
                height: 10.0,
              ),
              _registerButton()
            ],
          ),
        ),
      ),
    );
  }

  Future<void> signUpWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);
      // User registered successfully
      await _auth.signOut();
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => LoginPage()),
      );
    } on FirebaseAuthException catch (e) {
      var snackBar = SnackBar(content: Text(e.code));
      // Step 3
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } catch (e) {
      // Other errors
    }
  }

  Widget _registerButton() => ElevatedButton(
        onPressed: () {
          if (_formkey.currentState!.validate()) {
            _formkey.currentState!.save();
            signUpWithEmailAndPassword(
                email, password); // call the function here
          }
        },
        child: Text("Kayıt Ol"),
      );
}
