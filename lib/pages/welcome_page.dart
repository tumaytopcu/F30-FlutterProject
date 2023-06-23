import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
              color: Colors.pink[300],
              child: Center(
                child: Text('birinci sayfa'),
              ),
            ),
            Container(
              color: Colors.blue[300],
              child: Center(
                child: Text('ikinci sayfa'),
              ),
            ),
            Container(
              color: Colors.yellowAccent[400],
              child: Center(
                child: Text('üçüncü sayfa'),
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
                    onTap: () {},
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