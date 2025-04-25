class Cafe {
  String name;
  String address;
  String rating;
  String imagePath;

  Cafe(
      {required this.name,
      required this.address,
      required this.rating,
      required this.imagePath});

  String get _name => name;
  String get _address => address;
  String get _rating => rating;
  String get _imagePath => imagePath;
}
