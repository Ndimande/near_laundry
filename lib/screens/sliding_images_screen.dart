import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:lottie/lottie.dart';
import 'package:near_laundry/models/basket.dart';
import 'package:near_laundry/screens/basket_screen.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class SlidingImagesScreen extends StatefulWidget {
  const SlidingImagesScreen({Key? key}) : super(key: key);

  @override
  State<SlidingImagesScreen> createState() => SlidingImageState();
}

class SlidingImageState extends State<SlidingImagesScreen> {
  int activeIndex = 0;
  final slidingLaundryPics = [
    'https://assets8.lottiefiles.com/packages/lf20_5KG9yE.json',
    'https://assets1.lottiefiles.com/packages/lf20_nkvngl3p.json',
    'https://assets5.lottiefiles.com/packages/lf20_b4jgnk3h.json',
    'https://assets10.lottiefiles.com/private_files/lf30_ecnepkno.json'
  ];
  final List<String> textToDisplay = [
    'Let get your clothes clean!',
    'Book now before we close',
    'We will fetch it for you',
    'Let keep it clean and real'
  ];
  Widget slidingImages() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Center(
          child: Text(
            'MAKE YOUR BOOKING',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.purple,
                fontSize: 20,
                fontStyle: FontStyle.italic),
          ),
        ),
        CarouselSlider.builder(
          itemCount: slidingLaundryPics.length,
          options: CarouselOptions(
            height: MediaQuery.of(context).size.height * 0.55,
            autoPlay: true,
            enableInfiniteScroll: false,
            //autoPlayCurve: true,
            pageSnapping: true,
            reverse: false,

            autoPlayInterval: const Duration(seconds: 5),
            onPageChanged: (index, reason) {
              setState(() => activeIndex = index);
            },
          ),
          itemBuilder: (context, index, realIndex) {
            final urlImage = slidingLaundryPics[index];
            return buildImage(urlImage, index, textToDisplay);
          },
        ),
        const SizedBox(
          height: 32,
        ),
        buildIndicator(),
        const SizedBox(
          height: 32,
        ),
        SizedBox(
          height: 80,
          width: 80,
          child: FloatingActionButton(
            backgroundColor: Colors.purple,
            onPressed: _bookButton,
            child: const Text(
              'Book',
              style: TextStyle(color: Colors.white),
            ),
          ),
        )
      ],
    );
  }

  void _bookButton() async {
    await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => const BasketScreen(),
        ));
  }

  Widget buildIndicator() => AnimatedSmoothIndicator(
        activeIndex: activeIndex,
        count: slidingLaundryPics.length,
        effect: const JumpingDotEffect(dotWidth: 10, dotHeight: 10),
      );

  Widget buildImage(String urlImage, int index, textToDisplay) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5),
      color: Colors.white,
      child: Column(children: [
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.45,
          width: MediaQuery.of(context).size.width,
          child: Center(
            child: Lottie.network(
              urlImage,
              fit: BoxFit.fill,
            ),
          ),
        ),
        const SizedBox(
          height: 50,
        ),
        Container(
          height: 20,
          color: Colors.white,
          child: Text(
            textToDisplay[index],
            style: const TextStyle(
                color: Colors.purple,
                fontSize: 15,
                fontWeight: FontWeight.bold),
          ),
        )
      ]),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: slidingImages(),
    );
  }
}
