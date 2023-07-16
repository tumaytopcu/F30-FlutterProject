import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'addButonu.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(AnaEkran());
}

class AnaEkran extends StatefulWidget {
  const AnaEkran({Key? key});

  @override
  State<AnaEkran> createState() => _AnaEkranState();
}

class _AnaEkranState extends State<AnaEkran> {
  final _userStream = FirebaseFirestore.instance.collection('users_data').snapshots();

  void _showBottomSheet(BuildContext context, String urun, String fiyat, String satici, String konum, String? imageURL) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 900,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 64,
                  backgroundImage: imageURL != null ?
                  NetworkImage(imageURL) :
                  AssetImage('assets/default_photo.jpg') as ImageProvider,
                ),
                Text(
                  urun,
                  style: TextStyle(fontSize: 24),
                ),
                SizedBox(height: 16),
                Text(
                  'Fiyat: $fiyat',
                  style: TextStyle(fontSize: 18),
                ),
                Text(
                  'Satıcı: $satici',
                  style: TextStyle(fontSize: 18),
                ),
                Text(
                  'Konum: $konum',
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

      body: StreamBuilder<QuerySnapshot>(
        stream: _userStream,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('Bir hata oluştu: ${snapshot.error}');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          var docs = snapshot.data!.docs;
          return ListView.builder(
            itemCount: docs.length,
            itemBuilder: (context, index) {
              String urun = docs[index]['urun'];
              String fiyat = docs[index]['fiyat'];
              String satici = docs[index]['satici'];
              String konum = docs[index]['konum'];
              String? imageURL = docs[index]['imageURL'];
              return InkWell(
                onTap: () {
                  _showBottomSheet(context, urun, fiyat, satici, konum, imageURL);
                },
                child: Card(
                  color: Colors.white38,
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundImage: imageURL != null ?
                      NetworkImage(imageURL) :
                      AssetImage('assets/default_photo.jpg') as ImageProvider,
                    ),
                    title: Text(urun),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Fiyatı: $fiyat TL'),
                        Text('Satıcı Bilgileri: $satici'),
                        Text('Konumu: $konum'),
                      ],
                    ),
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
            MaterialPageRoute(builder: (context) => AddButonu()),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

final FirebaseFirestore _firestore = FirebaseFirestore.instance;

class FirebaseService {
  final CollectionReference usersCol =
  FirebaseFirestore.instance.collection("users_data");

  Future<void> insertData({
    required String urun,
    required String fiyat,
    required String satici,
    required String konum,
    String? imageURL,
  }) {
    return usersCol.add({
      'urun': urun,
      'fiyat': fiyat,
      'satici': satici,
      'konum': konum,
      'imageURL': imageURL,
    });
  }
}

