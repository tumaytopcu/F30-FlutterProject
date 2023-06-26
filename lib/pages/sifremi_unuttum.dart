import 'package:flutter/material.dart';

class SifrePage extends StatefulWidget {
  @override
  _SifrePageState createState() => _SifrePageState();
}

class _SifrePageState extends State<SifrePage> {
  String email = "";
  final _formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('Şifremi Unuttum'),
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
                  email = value!;
                },
              ),
              SizedBox(
                height: 10.0,
              ),
              _sifreButton()
            ],
          ),
        ),
      ),
    );
  }

  Widget _sifreButton() => ElevatedButton(
        onPressed: () {
          if (_formkey.currentState!.validate()) {
            _formkey.currentState!.save();
          }
        },
        child: Text("Tek Kullanımlık Şifre Gönder"),
      );
}
