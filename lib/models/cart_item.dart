class CartItem {
  final String id;
  final String title;
  final double price;
  final int quantity;
  final String imageUrl;
  final String description;

  CartItem({
    required this.id,
    required this.title,
    required this.price,
    required this.quantity,
    required this.imageUrl,
    required this.description,
  });
}