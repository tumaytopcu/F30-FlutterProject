import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'addButonu.dart';

class AnaEkran extends StatefulWidget {
  const AnaEkran({Key? key});

  @override
  State<AnaEkran> createState() => _AnaEkranState();
}

class _AnaEkranState extends State<AnaEkran> {
  final _userStream =
      FirebaseFirestore.instance.collection('users_data').snapshots();

  void _showBottomSheet(BuildContext context, String urun, int fiyat, String satici, String konum) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 900,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  urun,
                  style: TextStyle(fontSize: 24),
                ),
                SizedBox(height: 16),
                Text(
                  '$fiyat TL',
                  style: TextStyle(fontSize: 18),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ana Ekran (kart sayfası)'),
      ),
      body: StreamBuilder(
        stream: _userStream,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Text('connection error');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Text('loading');
          }
          var docs = snapshot.data!.docs;
          return ListView.builder(
            itemCount: docs.length,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  String urun = docs[index]['urun'];
                  int fiyat = docs[index]['fiyati'];
                  String satici= docs[index]['satici'];
                  String konum = docs[index]['konum'];
                  _showBottomSheet(context, urun, fiyat, satici ,konum);
                },
                child: Container(
                  child: Column(
                    children: [
                      Card(
                        color: Colors.white38,
                        child: ListTile(
                          leading: const Icon(Icons.person),
                          title: Text(docs[index]['urun'] ,),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text('Fiyatı: ${docs[index]['fiyati']} TL' ),
                              Text('Satıcı Bilgileri : ${docs[index]['satici']}',),
                              Text('Konumu: ${docs[index]['konum']}' ,),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => addButonu()),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
