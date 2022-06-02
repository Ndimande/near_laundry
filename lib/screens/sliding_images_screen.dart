import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:lottie/lottie.dart';
import 'package:near_laundry/models/basket.dart';
import 'package:near_laundry/screens/basket_screen.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class SlidingImagesScreen extends StatefulWidget {
  int? userId;
  SlidingImagesScreen(this.userId, {Key? key}) : super(key: key);

  @override
  State<SlidingImagesScreen> createState() => SlidingImageState();
}

class SlidingImageState extends State<SlidingImagesScreen> {
  int activeIndex = 0;

  final slidingLaundryPics = [
    'assets/images/animations/17971-hand-washing.json',
    'assets/images/animations/64579-washing-machine.json',
    'assets/images/animations/97387-digital-designer.json',
    'assets/images/animations/89833-laundry.json'
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
        // const Center(
        //   child: Text(
        //     'MAKE YOUR BOOKING',
        //     style: TextStyle(
        //         fontWeight: FontWeight.bold,
        //         color: Colors.purple,
        //         fontSize: 20,
        //         fontStyle: FontStyle.italic),
        //   ),
        // ),
        CarouselSlider.builder(
          itemCount: slidingLaundryPics.length,
          options: CarouselOptions(
            height: MediaQuery.of(context).size.height * 0.45,
            autoPlay: true,
            enableInfiniteScroll: false,
            //autoPlayCurve: true,
            // pageSnapping: true,
            // reverse: false,

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
        buildIndicator(),
        Lottie.asset(
          'assets/images/animations/30718-water-splash-effect.json',
          fit: BoxFit.cover,
        ),
        SizedBox(
          height: 50,
          width: 50,
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
          builder: (_) => BasketScreen(widget.userId),
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
          height: MediaQuery.of(context).size.height * 0.4,
          width: MediaQuery.of(context).size.width,
          child: Center(
            child: Lottie.asset(
              urlImage,
              fit: BoxFit.fill,
            ),
          ),
        ),
        Container(
          height: 40,
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
