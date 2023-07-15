import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'dart:typed_data';
import 'package:image_picker/image_picker.dart';

//YourStore Sayfası

class addButonu extends StatefulWidget {
  const addButonu({super.key});

  @override
  State<addButonu> createState() => _addButonuState();
}

class _addButonuState extends State<addButonu> {
  Uint8List? profile;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController bioController = TextEditingController();

  void selectImage() async {
    Uint8List img = await pickImage((ImageSource.gallery));
    setState(() {
      profile = img;
    });
  }

  void saveProfile() async {
    String name = nameController.text;
    String bio = bioController.text;

    String resp =
        await StoreData().saveData(name: name, bio: bio, file: profile!);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
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
                          profile != null
                              ? CircleAvatar(
                                  radius: 64,
                                  backgroundImage: MemoryImage(profile!),
                                )
                              : const CircleAvatar(
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
                          )
                        ],
                      ),
                      SizedBox(
                        height: 45,
                      ),
                      Column(
                        children: [
                          TextFormField(
                            decoration: InputDecoration(
                              icon: Icon(
                                Icons.border_color_outlined,
                                size: 40.0,
                                color: Colors.red,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            decoration: InputDecoration(
                              icon: Icon(
                                Icons.attach_money_outlined,
                                size: 40.0,
                                color: Colors.red,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            decoration: InputDecoration(
                              icon: Icon(
                                Icons.face,
                                size: 40.0,
                                color: Colors.red,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            decoration: InputDecoration(
                              icon: Icon(
                                Icons.add_location,
                                size: 40.0,
                                color: Colors.red,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 50,
                          ),

                          //buton

                          ElevatedButton(
                            onPressed: () {},
                            child: Text(
                              'Onayla',
                              style: TextStyle(
                                color: Colors.black,
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red),
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
}

final FirebaseStorage _storage = FirebaseStorage.instance;
final FirebaseFirestore _firestore = FirebaseFirestore.instance;

class StoreData {
  Future<String> uploadProfileToStorage(
      String childName, Uint8List file) async {
    Reference ref = _storage.ref().child(childName).child('id');
    UploadTask uploadTask = ref.putData(file);
    TaskSnapshot snapshot = await uploadTask;
    String downloadURL = await snapshot.ref.getDownloadURL();
    return downloadURL;
  }

  Future<String> saveData({
    required String name,
    required String bio,
    required Uint8List file,
  }) async {
    String resp = "Some Error Occurred";
    try {
      if (name.isNotEmpty || bio.isNotEmpty) {
        String imageUrl = await uploadProfileToStorage('ProfileImage', file);
        await _firestore.collection('userProfile').add({
          'name': name,
          'bio': bio,
          'imageLink': imageUrl,
        });

        resp = 'success';
      }
    } catch (err) {
      resp = err.toString();
    }
    return resp;
  }
}

pickImage(ImageSource source) async {
  final ImagePicker _imagePicker = ImagePicker();
  XFile? _file = await _imagePicker.pickImage(source: source);
  if (_file != null) {
    return await _file.readAsBytes();
  }
  print('No Images Selected');
}
