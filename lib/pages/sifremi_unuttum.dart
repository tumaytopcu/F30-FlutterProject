import 'package:flutter/material.dart';

class SifrePage extends StatefulWidget {
  @override
  _SifrePageState createState() => _SifrePageState();
}

class _SifrePageState extends State<SifrePage> {
  String email = "";
  final _formkey = GlobalKey<FormState>();
  final _emailKey = GlobalKey<FormFieldState>();

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Color(0xE8E8E8E8E8),
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 19, 221, 123),
        title: Text('Şifremi Unuttum'),
      ),
      body: Form(
        key: _formkey,
        child: Stack(
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
              padding: const EdgeInsets.only(left: 20.0, right: 20.0),
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
                          color: Color.fromARGB(255, 19, 221, 123),
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(50.0)),
                      ),
                      fillColor: Colors.white,
                      filled: true,
                      labelText: "Email",
                      labelStyle: TextStyle(
                        color: Color.fromARGB(255, 19, 221, 123),
                      ),
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
                  _sifreButton(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _sifreButton() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ElevatedButton(
          onPressed: () {
            if (_formkey.currentState!.validate()) {
              _formkey.currentState!.save();
            }
          },
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(
              Color.fromARGB(255, 19, 221, 123),
            ),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
              ),
            ),
          ),
          child: Text("Tek Kullanımlık Şifre Gönder"),
        ),
      ],
    );
  }
}
