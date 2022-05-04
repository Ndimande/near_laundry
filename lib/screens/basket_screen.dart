import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:near_laundry/models/basket.dart';
import 'package:near_laundry/screens/book_screen.dart';
import 'package:near_laundry/screens/home_screen.dart';

class BasketScreen extends StatefulWidget {
  const BasketScreen({Key? key}) : super(key: key);

  @override
  State<BasketScreen> createState() => _BaskeScreenState();
}

class _BaskeScreenState extends State<BasketScreen> {
  @override
  Widget build(BuildContext context) {
    Basket bst = Basket();
    int length = bst.baskets.length;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 30),
              child: Center(
                child: Text(
                  'Choose your basket below',
                  style: TextStyle(
                      color: Colors.purple,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  child: GridView.builder(
                    itemCount: length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.75,
                    ),
                    itemBuilder: (context, index) => GestureDetector(
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => BookScreen(
                            selectedBasketId: bst.baskets[index].id as int,
                          ),
                        ),
                      ),
                      child: Column(children: [
                        Container(
                          height: MediaQuery.of(context).size.height * 0.2,
                          width: 160,
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(16)),
                          child: Image.asset(
                            bst.baskets[index].imageUrl.toString(),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(left: 10.0),
                              child: Text(
                                'Prize : ',
                                style: TextStyle(
                                    color: Colors.green,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Text(
                              'R' +
                                  bst.baskets[index].estimatedPrize.toString(),
                              style: const TextStyle(
                                  color: Colors.green,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(right: 10.0),
                              child: Text(
                                'Size : ',
                                style: TextStyle(
                                    color: Colors.red,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Text(
                              bst.baskets[index].size.toString() + ' kg',
                              style: const TextStyle(
                                  color: Colors.red,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ]),
                    ),
                  ),
                ),
              ),
            )
          ]),
    );
  }
}
