import 'package:f30_bootcamp/pages/add_page.dart';
import 'package:f30_bootcamp/pages/ana_ekran.dart';
import 'package:f30_bootcamp/pages/profile_page.dart';
import 'package:f30_bootcamp/pages/search_page.dart';
import 'package:f30_bootcamp/pages/wallet_page.dart';
import 'package:flutter/material.dart';

import 'anaekran_içeriği/anaekran_listview.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    WalletPage(),
    AddPage(),
    SearchPage(),
    ProfilePage(),
    AnaEkran(),
  ];

  final List<String> _titles = [
    'Wallet',
    'Add',
    'Search',
    'Profile',
    'Home',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_titles[_currentIndex]),
      ),
      body: _pages[_currentIndex],
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
                color: Colors.blueAccent,
                onPressed: () {
                  setState(() {
                    _currentIndex = 0;
                  });
                },
              ),
              IconButton(
                icon: Icon(Icons.add_location_outlined),
                color: Colors.blueAccent,
                onPressed: () {
                  setState(() {
                    _currentIndex = 1;
                  });
                },
              ),
              SizedBox(width: 40.0), // Boş bir widget
              IconButton(
                icon: Icon(Icons.search),
                color: Colors.blueAccent,
                onPressed: () {
                  setState(() {
                    _currentIndex = 2;
                  });
                },
              ),
              IconButton(
                icon: Icon(Icons.person_2_outlined),
                color: Colors.blueAccent,
                onPressed: () {
                  setState(() {
                    _currentIndex = 3;
                  });
                },
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            _currentIndex = 4;
          });
        },
        child: Icon(Icons.home),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        elevation: 2.0,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
