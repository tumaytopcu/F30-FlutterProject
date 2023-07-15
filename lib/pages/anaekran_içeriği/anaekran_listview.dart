import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'addButonu.dart';


class AnaEkran extends StatefulWidget {
  const AnaEkran({super.key});

  @override
  State<AnaEkran> createState() => _AnaEkranState();
}

class _AnaEkranState extends State<AnaEkran> {
  final _userStream =
  FirebaseFirestore.instance.collection('users_data').snapshots();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ana Ekran (kart sayfası)'),
      ),
      body: StreamBuilder(
        stream: _userStream,
        builder: (context, snapshot){
          if (snapshot.hasError){
            return const Text('connection error');
          }
          if (snapshot.connectionState == ConnectionState.waiting){
            return const Text('loading');
          }
          var docs = snapshot.data!.docs;
          //return Text('${docs.length}');
          return ListView.builder(
              itemCount: docs.length,
              itemBuilder: (context,index){
                return InkWell(
                  onTap: (){},
                  child: Container(
                    child: Column(
                      children: [
                        Card(color: Colors.white38,
                          child: ListTile(
                            leading: const Icon(Icons.person),
                            title: Text(docs[index]['urun']),
                            subtitle: Text('${docs[index]['fiyati']} TL '),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => addButonu(),),);
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
