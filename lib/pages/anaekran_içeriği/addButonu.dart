import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:typed_data';
import 'anaekran_listview.dart';

// YourStore Sayfası

class AddButonu extends StatefulWidget {
  AddButonu({Key? key});

  @override
  State<AddButonu> createState() => _AddButonuState();
}

class _AddButonuState extends State<AddButonu> {
  Uint8List? profile;
  final TextEditingController _urunController = TextEditingController();
  final TextEditingController _fiyatController = TextEditingController();
  final TextEditingController _saticiController = TextEditingController();
  final TextEditingController _konumController = TextEditingController();
  final FirebaseStorage _storage = FirebaseStorage.instance;

  void selectImage() async {
    Uint8List? img = await pickImage(ImageSource.gallery);
    if (img != null) {
      setState(() {
        profile = img;
      });
    }
  }

  @override
  void dispose() {
    _urunController.dispose();
    _fiyatController.dispose();
    _saticiController.dispose();
    _konumController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Kendi Ürününü Ekle'),
          backgroundColor: Color.fromRGBO(0, 191, 98, 1),
        ),
        body: SafeArea(
          child: Container(
            alignment: Alignment.center,
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(30.0),
              child: ListView(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Stack(
                        children: [
                          if (profile != null)
                            CircleAvatar(
                              radius: 64,
                              backgroundImage: MemoryImage(profile!),
                            )
                          else
                            const CircleAvatar(
                              radius: 64,
                              backgroundImage:
                              AssetImage('assets/add_photo.jpg'),
                            ),
                          Positioned(
                            bottom: -10,
                            left: 80,
                            child: IconButton(
                              onPressed: selectImage,
                              icon: const Icon(Icons.add_a_photo),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 45,
                      ),
                      Column(
                        children: [
                          TextFormField(
                            controller: _urunController,
                            decoration: const InputDecoration(
                              labelText: 'Ürünün Adı',
                              icon: Icon(
                                Icons.border_color_outlined,
                                size: 40.0,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            controller: _fiyatController,
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              labelText: 'Ürünün Fiyatı',
                              icon: Icon(
                                Icons.attach_money_outlined,
                                size: 40.0,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            controller: _saticiController,
                            decoration: const InputDecoration(
                              labelText: 'Satıcı Bilgileri',
                              icon: Icon(
                                Icons.face,
                                size: 40.0,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            controller: _konumController,
                            decoration: const InputDecoration(
                              labelText: 'Konum',
                              icon: Icon(
                                Icons.add_location,
                                size: 40.0,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 50,
                          ),
                          ElevatedButton(
                            onPressed: () async {
                              String urun = _urunController.text;
                              String fiyat = _fiyatController.text;
                              String satici = _saticiController.text;
                              String konum = _konumController.text;

                              // Fotoğrafı yükle
                              String? imageURL;
                              if (profile != null) {
                                imageURL = await uploadImage(profile!);
                              }

                              await FirebaseService().insertData(
                                urun: urun,
                                fiyat: fiyat,
                                satici: satici,
                                konum: konum,
                                imageURL: imageURL,
                              );

                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => AnaEkran()),
                              );
                            },
                            child: const Text(
                              'Onayla',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 30,
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color.fromRGBO(0, 191, 98, 1),
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text(
                              'Vazgeç',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 28,
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color.fromRGBO(216, 46, 46, 1),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<Uint8List?> pickImage(ImageSource source) async {
    final ImagePicker _imagePicker = ImagePicker();
    XFile? _file = await _imagePicker.pickImage(source: source);
    if (_file != null) {
      return await _file.readAsBytes();
    }
    return null;
  }

  Future<String?> uploadImage(Uint8List imageBytes) async {
    String fileName = DateTime.now().millisecondsSinceEpoch.toString();
    Reference ref = _storage.ref().child('images/$fileName');
    UploadTask uploadTask = ref.putData(imageBytes);
    TaskSnapshot snapshot = await uploadTask;
    String? downloadURL = await snapshot.ref.getDownloadURL();
    return downloadURL;
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
