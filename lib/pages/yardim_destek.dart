import 'package:flutter/material.dart';


class YardimPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'EcoPazar Yardım ve Destek',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('EcoPazar'),
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: 20,),
                Text(
                  'Hoş Geldiniz!',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 20),
                Text(
                  'EcoPazar ile ilgili yardım ve destek alabileceğiniz kaynaklara aşağıdan ulaşabilirsiniz:',
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 40),
                SupportCard(
                  title: 'Tümay Topçu',
                  description:
                  '                  Mail: xxx@gmail.com \n                  Numara: 555 555 55 55\n"Tümay Hanım, haftanın her günü 09:00 ile 18:00 arasında hizmet vermektedir. Bu saatler içerisinde, sorularınızı sormak veya yardım taleplerinizi iletmek için bizimle iletişime geçebilirsiniz."',
                  url: '',
                ),
                SupportCard(
                  title: 'Züleyha Akbaş',
                  description:
                  '                  Mail: xxx@gmail.com \n                  Numara: 555 555 55 55\n"Züleyha Hanım, haftanın her günü 09:00 ile 18:00 arasında hizmet vermektedir. Bu saatler içerisinde, sorularınızı sormak veya yardım taleplerinizi iletmek için bizimle iletişime geçebilirsiniz."',
                  url: '',
                ),
                SupportCard(
                  title: 'Ramazan Aydınlı',
                  description:
                  '                  Mail: xxx@gmail.com \n                  Numara: 555 555 55 55\n"Ramazan Bey, haftanın her günü 09:00 ile 18:00 arasında hizmet vermektedir. Bu saatler içerisinde, sorularınızı sormak veya yardım taleplerinizi iletmek için bizimle iletişime geçebilirsiniz."',
                  url: '',
                ),
                SupportCard(
                  title: 'Recep Arslan',
                  description:
                  '                  Mail: xxx@gmail.com \n                  Numara: 555 555 55 55\n"Recep Bey, haftanın her günü 09:00 ile 18:00 arasında hizmet vermektedir. Bu saatler içerisinde, sorularınızı sormak veya yardım taleplerinizi iletmek için bizimle iletişime geçebilirsiniz."',
                  url: '',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SupportCard extends StatelessWidget {
  final String title;
  final String description;
  final String url;

  const SupportCard(
      {required this.title, required this.description, required this.url});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Card(
        elevation: 4,
        child: InkWell(
          onTap: () {
            // URL'ye yönlendirme yapılabilir
          },
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  title,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                Text(
                  description,
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
