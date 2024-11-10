class Seat {
  static const double defaultPrice = 29.99;
  bool isAvailable;
  bool isSelected;
  bool isReserved;
  final double price;

  Seat({
    this.isAvailable = true,
    this.isSelected = false,
    this.isReserved = false,
    this.price = defaultPrice,
  });
}