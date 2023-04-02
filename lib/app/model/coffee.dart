import 'dart:math';

double _doubleRange(Random source, num start, num end) =>
    source.nextDouble() * (end - start) + start;
final random = Random();
final coffees = List.generate(
  _names.length,
  (index) => Coffee(
    name: _names[index],
    image: 'assets/images/${index + 1}.png',
    price: _doubleRange(random, 3, 7),
  ),
);

class Coffee {
  final String name;
  final String image;
  final double price;

  Coffee({
    required this.name,
    required this.image,
    required this.price,
  });
}

final _names = [
  'Caramel Macchiato',
  'Caramel Cold Drink',
  'Iced Coffe Mocha',
  'Caramelized Pecan Latte',
  'Toffee Nut Latte',
  'Capuchino',
  'Toffee Nut Iced Latte',
  'Americano',
  'Vietnamese - Style Iced Coffee',
  'Black Tea Latte',
  'Classic Irish Coffee',
  'Toffee Nut Crunch Latte',
];
