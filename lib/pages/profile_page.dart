import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'home_page.dart';
import 'login_page.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  void showExitDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Çıkış Yap"),
          content: Text("Çıkış yapmak istediğinize emin misiniz?"),
          actions: [
            TextButton(
              child: Text("Evet"),
              onPressed: () {
                // Çıkış yapılacak işlemler
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                );
              },
            ),
            TextButton(
              child: Text("Hayır"),
              onPressed: () {
                Navigator.of(context).pop(); // Alert dialogu kapat
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: SafeArea(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: MediaQuery.of(context).size.height -
                  MediaQuery.of(context).padding.top,
            ),
            child: Container(
              alignment: Alignment.center,
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () {
                      // Avatar tıklama işlemini burada yönetebilirsiniz
                    },
                    child: Stack(
                      alignment: Alignment.bottomRight,
                      children: [
                        // Resim eklenecek kısım
                        CircleAvatar(
                          radius: 70,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        // Resim ekleme butonu
                        CircleAvatar(
                          radius: 20,
                          backgroundColor: Colors.black,
                          child: InkWell(
                            onTap: () {
                              // Ekleme simgesi tıklama işlemini burada yönetebilirsiniz
                            },
                            child: Icon(
                              Icons.add,
                              color: Colors.white,
                              size: 20,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Kullanıcı bilgileri
                  Padding(
                    padding: EdgeInsets.all(30.0),
                    child: Text(
                      "Ad Soyad",
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  // Profil sayfasından gidilecek sayfalara ait butonlar ve özellikleri
                  SizedBox(
                    height: 5,
                  ),
                  InkWell(
                    onTap: () {
                      // Ayarlar tıklama işlemini burada yönetebilirsiniz
                    },
                    child: ProfileMenuWidget(
                      title: "Ayarlar",
                      icon: Icons.settings_rounded,
                      endIcon: true,
                      onTap: () {
                        // Ayarlar tıklama işlemini burada yönetebilirsiniz
                      },
                    ),
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  InkWell(
                    onTap: () {
                      // Arkadaşlarını Davet Et tıklama işlemini burada yönetebilirsiniz
                    },
                    child: ProfileMenuWidget(
                      title: "Arkadaşını Davet Et",
                      icon: Icons.group_add,
                      endIcon: true,
                      onTap: () {},
                    ),
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  InkWell(
                    onTap: () {
                      // Yardım ve Destek tıklama işlemini burada yönetebilirsiniz
                    },
                    child: ProfileMenuWidget(
                      title: "Yardım ve Destek",
                      icon: Icons.support_agent,
                      endIcon: true,
                      onTap: () {},
                    ),
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  InkWell(
                    onTap: () {
                      // Çıkış Yap tıklama işlemini burada yönetebilirsiniz
                      showExitDialog();
                    },
                    child: ProfileMenuWidget(
                      title: "Çıkış Yap",
                      icon: Icons.logout,
                      endIcon: true,
                      onTap: () {},
                    ),
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

class ProfileMenuWidget extends StatelessWidget {
  const ProfileMenuWidget({
    Key? key,
    required this.title,
    required this.icon,
    required this.onTap,
    this.endIcon = true,
    this.textColor,
  }) : super(key: key);

  final String title;
  final IconData icon;
  final VoidCallback onTap;
  final bool endIcon;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListTile(
        onTap: onTap,
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
