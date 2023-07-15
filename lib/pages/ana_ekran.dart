import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:f30_bootcamp/pages/anaekran_içeriği/anaekran_listview.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const MaterialApp(
    home:AnaEkran(),
  ));
}




//eskiden yapılan asset bölümü
/*class AnaEkran extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Kart Sayfası',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        body: ListView(
          children: const <Widget>[
            CardWidget(
              image: 'assets/karpuz.jpg',
              title: 'Karpuz',
              subtitle: '155',
            ),
            CardWidget(
              image: 'assets/erik.jpg',
              title: 'Erik',
              subtitle: '200',
            ),
            CardWidget(
              image: 'assets/kiraz.jpg',
              title: 'Kiraz',
              subtitle: '829',
            ),
            CardWidget(
              image: 'assets/image4.jpg',
              title: 'Kart 4',
              subtitle: 'Bilgi 4',
            ),
            CardWidget(
              image: 'assets/image5.jpg',
              title: 'Kart 5',
              subtitle: 'Bilgi 5',
            ),
            CardWidget(
              image: 'assets/image6.jpg',
              title: 'Kart 6',
              subtitle: 'Bilgi 6',
            ),CardWidget(
              image: 'assets/image7.jpg',
              title: 'Kart 7',
              subtitle: 'Bilgi 7',
            ),
            CardWidget(
              image: 'assets/image8.jpg',
              title: 'Kart 8',
              subtitle: 'Bilgi 8',
            ),

          ],
        ),
      ),
    );
  }
}*/

/*class CardWidget extends StatelessWidget {
  final String image;
  final String title;
  final String subtitle;

  const CardWidget({
    required this.image,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: () {
          // Kart tıklandığında yapılacak işlemler
        },
        child: Padding(
          padding: EdgeInsets.all(15.0), // Her kenardan 15 boşluk bırakır
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                width: 100,
                height: 100,
                child: Image.asset(
                  image,
                  fit: BoxFit.cover,
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        title,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8),
                      Row(
                        children: [
                          Icon(Icons.location_on),
                          SizedBox(width: 4),
                          Text(subtitle + ' m'),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Icon(Icons.arrow_forward),
            ],
          ),
        ),
      ),
    );
  }
}*/
