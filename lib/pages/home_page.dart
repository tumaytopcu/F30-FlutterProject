<<<<<<< Updated upstream
import 'package:f30_bootcamp/pages/ana_ekran.dart';
import 'package:f30_bootcamp/pages/profile_page.dart';
=======
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:f30_bootcamp/auth.dart';
>>>>>>> Stashed changes
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 5;
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  final List<Widget> _pages = [
    FirstPage(),
    SecondPage(),
    SizedBox.shrink(), // Empty widget
    ThirdPage(),
    FourthPage(),
    FifthPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initialization,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return Scaffold(
            appBar: AppBar(
              title: Text('Home'),
            ),
            body: _pages[_currentIndex],
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                _changePage(5);
              },
              child: Icon(Icons.home),
            ),
            floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
            bottomNavigationBar: BottomAppBar(
              shape: CircularNotchedRectangle(),
              notchMargin: 8.0,
              child: Container(
                height: 56.0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    IconButton(
                      icon: Icon(Icons.euro_symbol_outlined),
                      onPressed: () {
                        _changePage(0);
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.add_location_outlined),
                      onPressed: () {
                        _changePage(1);
                      },
                    ),
                    SizedBox(), // Empty widget
                    IconButton(
                      icon: Icon(Icons.search),
                      onPressed: () {
                        _changePage(3);
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.settings_outlined),
                      onPressed: () {
                        _changePage(4);
                      },
                    ),
                  ],
                ),
              ),
<<<<<<< Updated upstream
              IconButton(
                icon: Icon(Icons.add_location_outlined),
                onPressed: () {
                  _changePage(1);
                },
              ),
              SizedBox(), // Boş bir widget
              IconButton(
                icon: Icon(Icons.search),
                onPressed: () {
                  _changePage(3);
                },
              ),
              IconButton(
                icon: Icon(Icons.person_2_outlined),
                onPressed: () {
                  _changePage(4);
                },
              ),
            ],
          ),
        ),
      ),
=======
            ),
          );
        }

        if (snapshot.hasError) {
          return Center(child: Text('Error initializing Firebase'));
        }

        return Center(child: CircularProgressIndicator());
      },
>>>>>>> Stashed changes
    );
  }

  void _changePage(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}

class FirstPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'First Page',
        style: TextStyle(fontSize: 24),
      ),
    );
  }
}

class SecondPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Second Page',
        style: TextStyle(fontSize: 24),
      ),
    );
  }
}

class ThirdPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Third Page',
        style: TextStyle(fontSize: 24),
      ),
    );
  }
}

class FourthPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'F30',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ProfilePage(),
    );
  }
}

class FifthPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'F30',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: AnaEkran(),
    );
  }
}
