class Basket {
  final int? size;
  final String? imageUrl;
  final double? estimatedPrize;
  final int? id;

  Basket({this.id, this.estimatedPrize, this.imageUrl, this.size});
  factory Basket.fromMap(Map map) {
    return Basket(
      id: map['id'] as int,
      imageUrl: map['imageUrl'],
      estimatedPrize: map['estimatedPrize'],
      size: map["size"],
    );
  }

  late List<Basket> baskets = [
    Basket(
      id: 1,
      imageUrl: 'assets/images/baskets/basket1.jpg',
      size: 10,
      estimatedPrize: 100.00,
    ),
    Basket(
      id: 2,
      imageUrl: 'assets/images/baskets/basket2.jpg',
      size: 20,
      estimatedPrize: 200.00,
    ),
    Basket(
      id: 3,
      imageUrl: 'assets/images/baskets/basket3.jpg',
      size: 15,
      estimatedPrize: 149.99,
    ),
    Basket(
      id: 4,
      imageUrl: 'assets/images/baskets/basket4.jpg',
      size: 40,
      estimatedPrize: 499.99,
    ),
    Basket(
      id: 5,
      imageUrl: 'assets/images/baskets/basket5.jpg',
      size: 70,
      estimatedPrize: 699.99,
    ),
    Basket(
      id: 6,
      imageUrl: 'assets/images/baskets/basket6.jpg',
      size: 4,
      estimatedPrize: 49.99,
    ),
    Basket(
      id: 2,
      imageUrl: 'assets/images/baskets/basket7.jpg',
      size: 25,
      estimatedPrize: 249.99,
    ),
    Basket(
      id: 3,
      imageUrl: 'assets/images/baskets/basket8.jpg',
      size: 45,
      estimatedPrize: 549.99,
    ),
    Basket(
      id: 4,
      imageUrl: 'assets/images/baskets/basket9.jpg',
      size: 19,
      estimatedPrize: 200.00,
    ),
    Basket(
      id: 5,
      imageUrl: 'assets/images/baskets/basket10.jpg',
      size: 10,
      estimatedPrize: 100.00,
    ),
    Basket(
      id: 4,
      imageUrl: 'assets/images/baskets/basket11.jpg',
      size: 10,
      estimatedPrize: 100.00,
    ),
    Basket(
      id: 5,
      imageUrl: 'assets/images/baskets/basket12.jpg',
      size: 100,
      estimatedPrize: 999.99,
    ),
  ];
}
