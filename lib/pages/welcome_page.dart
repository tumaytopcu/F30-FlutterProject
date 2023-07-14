import 'package:f30_bootcamp/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: OnBoardingScreen(),
    );
  }
}

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

//"_controller" hangi sayfada olduğumuzu kontrol eder.
PageController _controller = PageController();

bool onLastPage = false;

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        //sayfa görüntüsü
        PageView(
          controller: _controller,
          onPageChanged: (index) {
            setState(() {
              onLastPage = (index == 2);
            });
          },
          children: [
            Container(
              color: Colors.blue[300],
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 100,
                    ),
                    Lottie.network(
                        'https://assets8.lottiefiles.com/packages/lf20_swnrn2oy.json'), // Görsel ekleniyor
                    SizedBox(
                      height: 40,
                    ),
                    Center(
                      child: Text(
                        'EcoPazar sayesinde, insanlar yolculukları sırasında yerel meyve ve sebze satıcılarını kolaylıkla bulabilir ve doğrudan üreticiden alışveriş yapabilirler.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white, // Metin rengini beyaz yapar
                          fontWeight:
                              FontWeight.bold, // Metini kalın (bold) yapar
                          fontSize: 24,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              color: Colors.blue[300],
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Lottie.network(
                        'https://assets6.lottiefiles.com/packages/lf20_klurhj0n.json'), // Görsel ekleniyor
                    SizedBox(
                      height: 20,
                    ),
                    Center(
                      child: Text(
                        'Yerel tarım üreticilerinin ve onların yol kenarları veya kendi bahçelerinde satış yapmalarını sağlar.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white, // Metin rengini beyaz yapar
                          fontWeight:
                              FontWeight.bold, // Metini kalın (bold) yapar
                          fontSize: 24,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              color: Colors.blue[300],
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 50,
                    ),
                    Lottie.network(
                        'https://assets7.lottiefiles.com/packages/lf20_q5evpnci.json'), // Görsel ekleniyor
                    SizedBox(
                      height: 20,
                    ),
                    Center(
                      child: Text(
                        ' Uygulama, tarım aktivitesini teşvik etmeyi amaçlar ve hem ücretli hem de ücretsiz satış imkanı sağlar. EcoPazar App, yerel ekonomiye ve sürdürülebilir tarıma katkı sağlama fikrini savunur ve tüketicilerin doğrudan üreticilerden alışveriş yapmasını teşvik eder.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white, // Metin rengini beyaz yapar
                          fontWeight:
                              FontWeight.bold, // Metini kalın (bold) yapar
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        Container(
            alignment: Alignment(0.0, 0.7),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                    onTap: () {
                      _controller.jumpToPage(2);
                    },
                    //atla
                    child: Text('Skip')),

                //sayfanın altındaki noktalar
                SmoothPageIndicator(controller: _controller, count: 3),

                //if yapısı "next" or "done" seçimini yapmaya yarar.

                if (onLastPage)
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => LoginPage()),
                      );
                    },
                    child: Text('Done'),
                  )
                else
                  GestureDetector(
                    onTap: () {
                      _controller.nextPage(
                          duration: Duration(milliseconds: 500),
                          curve: Curves.easeIn);
                    },
                    //ileri
                    child: Text('Next'),
                  )
              ],
            )),
      ],
    ));
  }
}
