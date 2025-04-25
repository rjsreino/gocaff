import 'package:flutter/material.dart';
import 'package:gocaff/models/menu_item.dart';

class Shop extends ChangeNotifier {
  final List<MenuItem> _menuItemsList = [
    MenuItem(
      name: "Espresso",
      description: "Rich and intense shot of coffee",
      price: 3.50,
      imagePath: "lib/images/coffee-cup.png",
      isPopular: true,
    ),
    MenuItem(
      name: "Americano",
      description: "Smooth espresso with hot water",
      price: 4.00,
      imagePath: "lib/images/coffee-cup.png",
      isPopular: false,
    ),
    MenuItem(
      name: "Caramel Latte",
      description: "Espresso with steamed milk and caramel syrup",
      price: 5.50,
      imagePath: "lib/images/coffee-cup.png",
      isPopular: true,
    ),
    MenuItem(
      name: "Croissant",
      description: "Buttery, flaky French-style pastry",
      price: 3.25,
      imagePath: "lib/images/coffee-cup.png",
      isPopular: false,
    ),
    MenuItem(
      name: "Chocolate Muffin",
      description: "Rich chocolate muffin baked fresh daily",
      price: 4.75,
      imagePath: "lib/images/coffee-cup.png",
      isPopular: false,
    ),
  ];
  //customer cart
  List<MenuItem> _cart = [];

  //getter methods
  List<MenuItem> get menuItemList => _menuItemsList;
  List<MenuItem> get cart => _cart;

  //add to cart
  void addToCart(MenuItem item, int quantity) {
    for (int i = 0; i < quantity; i++) {
      _cart.add(item);
    }
    notifyListeners();
  }

  //remove from cart
  void removeFromCart(MenuItem item) {
    _cart.remove(item);
    notifyListeners();
  }
}
