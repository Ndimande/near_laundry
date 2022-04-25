import 'package:flutter/material.dart';
import 'package:near_laundry/models/basket.dart';

class BookScreen extends StatefulWidget {
  final int selectedBasketId;
  const BookScreen({Key? key, required this.selectedBasketId})
      : super(key: key);

  @override
  State<BookScreen> createState() => _BookScreenState();
}

class _BookScreenState extends State<BookScreen> {
  @override
  Widget build(BuildContext context) {
    Basket bst = Basket();
    return Scaffold(
        appBar: AppBar(
          title: Center(
            child: Text(
              bst.baskets[widget.selectedBasketId].estimatedPrize.toString(),
            ),
          ),
          backgroundColor: const Color.fromARGB(255, 155, 50, 137),
          actions: const [
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Icon(Icons.search),
            ),
          ],
        ),
        body: Container());
  }
}
