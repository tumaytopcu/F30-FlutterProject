import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(SearchPage());
}

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final _userStream =
      FirebaseFirestore.instance.collection('users_data').snapshots();
  String searchQuery = '';

  void _showBottomSheet(BuildContext context, String urun, String fiyat,
      String satici, String konum, String? imageURL) {
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
                  backgroundImage: imageURL != null
                      ? NetworkImage(imageURL)
                      : AssetImage('assets/default_photo.jpg') as ImageProvider,
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
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.all(8.0),
              child: TextField(
                onChanged: (value) {
                  setState(() {
                    searchQuery = value;
                  });
                },
                decoration: InputDecoration(
                  icon:
                      Icon(Icons.search, color: Color.fromRGBO(216, 46, 46, 1)),
                  labelText: 'Ürün Adı',
                  hintText: 'Aranacak ürünü girin',
                  labelStyle: TextStyle(
                      color: Colors.black), // Yazı rengini siyah yapar
                  hintStyle: TextStyle(
                      color: Colors.black), // Yazı rengini siyah yapar
                ),
                style:
                    TextStyle(color: Colors.black), // Yazı rengini siyah yapar
              ),
            ),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: _userStream,
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Text('Bir hata oluştu: ${snapshot.error}');
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }
                  var docs = snapshot.data!.docs;
                  List<DocumentSnapshot> filteredDocs = docs
                      .where((doc) => doc['urun']
                          .toString()
                          .toLowerCase()
                          .contains(searchQuery.toLowerCase()))
                      .toList();
                  return ListView.builder(
                    itemCount: filteredDocs.length,
                    itemBuilder: (context, index) {
                      String urun = filteredDocs[index]['urun'];
                      String fiyat = filteredDocs[index]['fiyat'];
                      String satici = filteredDocs[index]['satici'];
                      String konum = filteredDocs[index]['konum'];
                      String? imageURL = filteredDocs[index]['imageURL'];

                      return InkWell(
                        onTap: () {
                          _showBottomSheet(
                              context, urun, fiyat, satici, konum, imageURL);
                        },
                        child: Card(
                          color: Colors.white38,
                          child: ListTile(
                            leading: CircleAvatar(
                              backgroundImage: imageURL != null
                                  ? NetworkImage(imageURL)
                                  : AssetImage('assets/default_photo.jpg')
                                      as ImageProvider,
                            ),
                            title: Text(urun,style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold)),
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
            ),
          ],
        ),
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
