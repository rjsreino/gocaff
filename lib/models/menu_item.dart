class MenuItem {
  String name;
  String description;
  double price;
  String imagePath;
  bool isPopular;

  MenuItem({
    required this.name,
    this.description = '',
    required this.price,
    required this.imagePath,
    this.isPopular = false,
  });

  //get each property
  String get _name => name;
  String get _description => description;
  double get _price => price;
  String get _imagePath => imagePath;
  bool get _isPopular => isPopular;

  //formatted price as string
  String get formattedPrice => '\$${price.toStringAsFixed(2)}';
}
