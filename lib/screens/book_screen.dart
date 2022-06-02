// ignore_for_file: deprecated_member_use

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:near_laundry/models/basket.dart';
import 'package:near_laundry/models/booking.dart';
import 'package:near_laundry/widgets.dart/utils.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../providers/database_helper.dart';
import '../widgets.dart/bottom_picker.dart';

class BookScreen extends StatefulWidget {
  int? userId;
  final int selectedBasketId;
  BookScreen(this.userId, {Key? key, required this.selectedBasketId})
      : super(key: key);

  @override
  State<BookScreen> createState() => _BookScreenState();
}

class _BookScreenState extends State<BookScreen> {
  DateTime datetime = DateTime.now();
  String time = 'Select time';
  int? count = 1;

  void checkout() {}
  var days = {
    1: 'Monday',
    2: 'Tuesday',
    3: 'Wednesday',
    4: 'Thurday',
    5: 'Friday',
    6: 'Saterday',
    7: 'Sunday'
  };

  int activeIndex = 0;
  final slidingLaundryPics = [
    'assets/images/cts/ct1.jpg',
    'assets/images/cts/ct3.jpg',
    'assets/images/cts/ct5.jpg',
    'assets/images/cts/ct4.jpg'
  ];

  Widget slidingImages() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CarouselSlider.builder(
          itemCount: slidingLaundryPics.length,
          options: CarouselOptions(
            height: 150,
            autoPlay: true,
            enableInfiniteScroll: true,
            autoPlayInterval: const Duration(seconds: 5),
            onPageChanged: (index, reason) {
              setState(() => activeIndex = index);
            },
          ),
          itemBuilder: (context, index, realIndex) {
            final urlImage = slidingLaundryPics[index];
            return buildImage(urlImage, index);
          },
        ),
        const SizedBox(
          height: 5,
        ),
        buildIndicator(),
      ],
    );
  }

  Widget buildImage(String urlImage, int index) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15),
      color: Colors.white,
      child: Column(children: [
        SizedBox(
          height: 130,
          width: 200,
          child: Image.asset(
            urlImage,
            fit: BoxFit.cover,
          ),
        ),
      ]),
    );
  }

  Widget buildIndicator() => AnimatedSmoothIndicator(
        activeIndex: activeIndex,
        count: slidingLaundryPics.length,
        effect: const JumpingDotEffect(dotWidth: 5, dotHeight: 5),
      );

  Widget _buildDatePicker() => SizedBox(
        height: 150,
        child: CupertinoDatePicker(
          minimumYear: 2020,
          maximumYear: 2030,
          initialDateTime: datetime,
          mode: CupertinoDatePickerMode.date,
          onDateTimeChanged: (dateTime) => setState(() => datetime = dateTime),
        ),
      );

  bool isDateSelected(DateTime dt) {
    if (dt.toString().substring(0, 10) ==
        DateTime.now().toString().substring(0, 10)) {
      return false;
    }
    return true;
  }

  bool isTimeSelected(String t) {
    if (t == 'Select time') {
      return false;
    }
    return true;
  }

  Widget _buildTimePicker() => SizedBox(
        height: 150,
        child: CupertinoDatePicker(
          minimumYear: 2020,
          maximumYear: 2030,
          initialDateTime: datetime,
          mode: CupertinoDatePickerMode.time,
          onDateTimeChanged: (times) => setState(
            () => time = times.hour.toString() +
                " : " +
                times.minute.toString() +
                " On " +
                days[times.weekday].toString(),
          ),
        ),
      );

  //Save all text from the controller to the database
  void _saveOrder(Basket bst, int count, String dateTime) async {
    if (isTimeSelected(time) == true && isDateSelected(datetime) == true) {
      await DatabaseHelper.instance.addBook(
        Booking(
            userId: widget.userId, //Need to find a way to parse the user Id
            busketSize: bst.baskets[widget.selectedBasketId - 1].size! * count,
            location: 'Centurion',
            noOfBasket: count.toString(),
            pickUpDate: dateTime,
            pickUpTime: time,
            prize: bst.baskets[widget.selectedBasketId - 1].estimatedPrize! *
                count,
            createdAt: DateTime.now()),
      );
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.green,
          duration: Duration(seconds: 2),
          content: Center(
            heightFactor: 2,
            child: Text(
              'Your order has been sent!',
              style: TextStyle(
                fontSize: 15.0,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      );
      Navigator.pop(context);
    } else {
      datetime = DateTime.now();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.red,
          duration: Duration(seconds: 2),
          content: Center(
            heightFactor: 2,
            child: Text(
              'Select Date and Time',
              style: TextStyle(
                fontSize: 15.0,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    Basket bst = Basket();

    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Schedule Pickup')),
        backgroundColor: const Color.fromARGB(255, 155, 50, 137),
        actions: const [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Icon(Icons.search),
          ),
        ],
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            slidingImages(),
            Row(
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 20),
                  child: Text(
                    'Estimated prize',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 15.0,
                        fontWeight: FontWeight.normal),
                  ),
                ),
                SizedBox(width: MediaQuery.of(context).size.width * 0.45),
                Text(
                  'R ' +
                      (bst.baskets[widget.selectedBasketId - 1]
                                  .estimatedPrize! *
                              count!)
                          .toString(),
                  style: const TextStyle(
                      color: Colors.black,
                      fontSize: 15.0,
                      fontWeight: FontWeight.normal),
                ),
              ],
            ),
            Row(
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 20.0),
                  child: Text(
                    'Size per chossen basket',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 15.0,
                        fontWeight: FontWeight.normal),
                  ),
                ),
                SizedBox(width: MediaQuery.of(context).size.width * 0.3),
                Text(
                  (bst.baskets[widget.selectedBasketId - 1].size! * count!)
                          .toString() +
                      " Kg",
                  style: const TextStyle(
                      color: Colors.black,
                      fontSize: 15.0,
                      fontWeight: FontWeight.normal),
                ),
              ],
            ),
            Row(
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 20.0),
                  child: Text(
                    'Current Location',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 15.0,
                        fontWeight: FontWeight.normal),
                  ),
                ),
                SizedBox(width: MediaQuery.of(context).size.width * 0.45),
                Container(
                  height: 30,
                  width: 30,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.location_on,
                      color: Colors.lightGreen,
                    ),
                  ),
                ),
              ],
            ),
            isDateSelected(datetime)
                ? BottomPicker(
                    displayText: datetime.toString().substring(0, 10),
                    icon: const Icon(
                      Icons.calendar_month_outlined,
                      color: Colors.orange,
                      size: 30,
                    ),
                    onClicked: () => Utils.showSheet(
                      context,
                      child: _buildDatePicker(),
                      onClicked: () => Navigator.pop(context),
                    ),
                  )
                : BottomPicker(
                    displayText: "Select Date",
                    icon: const Icon(
                      Icons.calendar_month_outlined,
                      color: Colors.grey,
                      size: 30,
                    ),
                    onClicked: () => Utils.showSheet(
                      context,
                      child: _buildDatePicker(),
                      onClicked: () => Navigator.pop(context),
                    ),
                  ),
            isTimeSelected(time)
                ? BottomPicker(
                    displayText: time.toString(),
                    icon: const Icon(
                      Icons.access_time_filled_sharp,
                      color: Colors.orange,
                      size: 30,
                    ),
                    onClicked: () => Utils.showSheet(
                      context,
                      child: _buildTimePicker(),
                      onClicked: () => Navigator.pop(context),
                    ),
                  )
                : BottomPicker(
                    displayText: "Select Time",
                    icon: const Icon(
                      Icons.access_time_filled_sharp,
                      color: Colors.grey,
                      size: 30,
                    ),
                    onClicked: () => Utils.showSheet(
                      context,
                      child: _buildTimePicker(),
                      onClicked: () => Navigator.pop(context),
                    ),
                  ),
            Padding(
              padding: const EdgeInsets.only(left: 35),
              child: Row(
                children: [
                  const Text(
                    'No. of Buskets',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 15.0,
                        fontWeight: FontWeight.normal),
                  ),
                  SizedBox(width: MediaQuery.of(context).size.width * 0.1),
                  FlatButton(
                    onPressed: () => setState(() {
                      count = count! + 1;
                    }),
                    child: Container(
                      height: 30,
                      width: 30,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.orange),
                      child: const Center(
                        child: Icon(
                          Icons.add,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    '$count',
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 15.0,
                        fontWeight: FontWeight.normal),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  FlatButton(
                    onPressed: () => setState(() {
                      if (count! > 1) {
                        count = count! - 1;
                      }
                    }),
                    child: Container(
                      height: 30,
                      width: 30,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.orange),
                      child: const Center(
                        child: Icon(
                          Icons.remove,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 50,
              width: 350,
              child: RaisedButton(
                color: const Color.fromARGB(255, 155, 50, 137),
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(30),
                  ),
                ),
                onPressed: () {
                  _saveOrder(bst, count!, datetime.toString());
                },
                child: const Text(
                  "Confirm",
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
