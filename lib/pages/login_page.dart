import 'package:f30_bootcamp/pages/home_page.dart';
import 'package:f30_bootcamp/pages/register_page.dart';
import 'package:f30_bootcamp/pages/sifremi_unuttum.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

bool obscurePassword = true;

class _LoginPageState extends State<LoginPage> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Center(child: Text('Login Page')),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.only(left: 20.0, right: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextFormField(
                controller: usernameController,
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                  ),
                  hintText: "+90 555 555 55 55",
                  hintStyle: TextStyle(color: Colors.grey),
                  labelText: "Telefon",
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

  Widget _loginButton() => ElevatedButton(
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            String username = usernameController.text;
            String password = passwordController.text;
            // Burada giriş işlemlerini yapabilirsiniz

            // Giriş işleminden sonra kullanıcı adı ve şifre alanlarını temizle
            usernameController.clear();
            passwordController.clear();

            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => HomePage()),
            );
          }
        },
        child: Text("Giriş Yap"),
      );
  Widget _googleButton() => FloatingActionButton.extended(
        onPressed: () {},
        icon: Image.asset(
          'assets/google_logo.png',
          height: 32,
          width: 32,
        ),
        label: Text("Google ile Giriş Yap"),
        backgroundColor: Colors.white,
        foregroundColor: Colors.blue,
      );
  Widget _withoutRegisterButton() => FloatingActionButton.extended(
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
