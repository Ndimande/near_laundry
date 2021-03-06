import 'package:flutter/material.dart';
import 'package:near_laundry/models/basket.dart';
import 'package:near_laundry/screens/book_screen.dart';

class BasketScreen extends StatefulWidget {
  int? userId;
  BasketScreen(this.userId, {Key? key}) : super(key: key);

  @override
  State<BasketScreen> createState() => _BaskeScreenState();
}

class _BaskeScreenState extends State<BasketScreen> {
  @override
  Widget build(BuildContext context) {
    Basket bst = Basket();
    int length = bst.baskets.length;
    return Scaffold(
      appBar: AppBar(
        shadowColor: Colors.lightBlue,
        elevation: 0,
        title: const Center(
          child: Text(
            'Choose your basket below',
            style: TextStyle(
                color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 155, 50, 137),
      ),
      backgroundColor: Colors.white,
      body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
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
                            widget.userId,
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
