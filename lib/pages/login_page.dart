
import 'package:f30_bootcamp/pages/register_page.dart';
import 'package:f30_bootcamp/pages/sifremi_unuttum.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String username = "";
  String password = "";
  final _formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Center(
            child: Text('Login Page')),
      ),
      body: Form(
          key: _formkey,
          child: Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                TextFormField(
                  //autovalidateMode: AutovalidateMode.always,
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                    labelText: "Kullanıcı Adı",
                    labelStyle: TextStyle(color: Colors.blue),
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value != null && value.isEmpty) {
                      return "Kullanıcı adını giriniz!";
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
                  obscureText: true,
                  //autovalidateMode: AutovalidateMode.always,
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                    labelText: "Şifre",
                    labelStyle: TextStyle(color: Colors.blue),
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value != null && value.isEmpty) {
                      return "Şifrenizi giriniz!";
                    } else {
                      return null;
                    }
                  },
                  onSaved: (value) {
                    password = value!;
                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    MaterialButton(
                      child: Text("Üye Ol"),
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => RegisterPage()));
                      },
                    ),
                    MaterialButton(
                      child: Text("Şifremi Unuttum"),
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => SifrePage()));
                      },
                    ),
                  ],
                ),
                _loginButton()
              ],
            ),
          )),
    );
  }

  Widget _loginButton() => ElevatedButton(
        onPressed: () {
          if (_formkey.currentState!.validate()) {
            _formkey.currentState!.save();
          }
        },
        child: Text("Giriş Yap"),
      );
}
