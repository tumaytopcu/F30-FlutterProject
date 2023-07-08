import 'package:f30_bootcamp/pages/profilpage_utils.dart';
import 'package:flutter/material.dart';
import 'home_page.dart';
import 'login_page.dart';

import 'dart:typed_data';
import 'package:firebase_core/firebase_core.dart';
import 'package:image_picker/image_picker.dart';
import 'profilpage_add_data.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const MyHomePage(title: ' '),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Uint8List? _image;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController bioController = TextEditingController();

  void selectImage() async {
    Uint8List img = await pickImage((ImageSource.gallery));
    setState(() {
      _image = img;
    });
  }

  void saveProfile() async {
    String name = nameController.text;
    String bio = bioController.text;

    String resp =
        await StoreData().saveData(name: name, bio: bio, file: _image!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 32,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 24,
              ),
              Stack(
                children: [
                  _image != null
                      ? CircleAvatar(
                          radius: 64,
                          backgroundImage: MemoryImage(_image!),
                        )
                      : const CircleAvatar(
                          radius: 64,
                          backgroundImage: NetworkImage(
                              'https://png.pngitem.com/pimgs/s/421-4212266_transparent-default-avatar-png-default-avatar-images-png.png'),
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
              Padding(
                padding: EdgeInsets.all(10.0),
                child: Text(
                  "Ad Soyad",
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: saveProfile,
                child: const Text('Save Profile'),
              ),

              SizedBox(
                height: 20,
              ),

              // Profil sayfasından gidilecek sayfalara ait butonlar ve özellikleri

              Expanded(
                child: ListView(
                  children: [
                    GestureDetector(
                      onTap: () {
                        // Ayarlar tıklama işlemini burada yönetebilirsiniz
                      },
                      child: ProfileMenuWidget(
                        title: "Ayarlar",
                        icon: Icons.settings_rounded,
                        endIcon: true,
                        onPress: () {},
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    GestureDetector(
                      onTap: () {
                        // Arkadaşlarını Davet Et tıklama işlemini burada yönetebilirsiniz
                      },
                      child: ProfileMenuWidget(
                        title: "Arkadaşlarını Davet Et",
                        icon: Icons.group_add,
                        endIcon: true,
                        onPress: () {},
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    GestureDetector(
                      onTap: () {
                        // Yardım ve Destek tıklama işlemini burada yönetebilirsiniz
                      },
                      child: ProfileMenuWidget(
                        title: "Yardım ve Destek",
                        icon: Icons.support_agent,
                        endIcon: true,
                        onPress: () {},
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    GestureDetector(
                      onTap: () {
                        // Çıkış Yap tıklama işlemini burada yönetebilirsiniz
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return LoginPage();
                            },
                          ),
                        );
                      },
                      child: ProfileMenuWidget(
                        title: "Çıkış Yap",
                        icon: Icons.logout,
                        endIcon: true,
                        onPress: () {},
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class ProfileMenuWidget extends StatelessWidget {
  const ProfileMenuWidget({
    Key? key,
    required this.title,
    required this.icon,
    required this.onPress,
    this.endIcon = true,
    this.textColor,
  }) : super(key: key);

  final String title;
  final IconData icon;
  final VoidCallback onPress;
  final bool endIcon;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListTile(
        onTap: onPress,
        leading: Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            color: Colors.black.withOpacity(0.1),
          ),
          child: Icon(
            icon,
            color: Colors.black,
          ),
        ),
        title: Text(title),
        // Eğer endIcon true ise Container'ı, false ise null döndür.
        trailing: endIcon
            ? Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: Colors.black.withOpacity(0.1),
                ),
                child: Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.black,
                ),
              )
            : null,
      ),
    );
  }
}
