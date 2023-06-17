import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Giriş')),
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(
                labelText: 'Kullanıcı adı',
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(
                labelText: 'Şifre',
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              obscureText: true,
            ),
            const SizedBox(height: 24.0),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.secondary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0), // Oval yapmak için yüksek bir değer kullanın
                ),
              ),
              child: const Text('Giriş'),
              onPressed: () {
                // Kullanıcı girişi işlemlerini burada gerçekleştirin
                // Giriş işlemlerini doğrulama veya yönlendirme yapabilirsiniz
              },
            ),
            const SizedBox(height: 16.0),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                  onPressed: () {
              // Hesap oluşturma işlemlerini burada gerçekleştirin
            },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.0),
                  border: Border.all(
                    color: Colors.grey,
                    width: 1.0,
                  ),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: const Text('Hesabım yok!', style: TextStyle(fontSize: 16.0)),
              ),
            ),
                  const SizedBox(width: 40.0,),
                  TextButton(
                    onPressed: () {
                      // Şifre oluşturma işlemleri
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15.0),
                        border: Border.all(
                          color: Colors.grey,
                          width: 1.0,
                        ),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                      child: const Text('Şifremi unuttum!',
                          style: TextStyle(
                              fontSize: 16.0)),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
