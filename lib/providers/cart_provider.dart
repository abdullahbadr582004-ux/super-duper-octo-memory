import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:project_3/models/cart_item.dart';

final cartProvider = StateNotifierProvider<CartNotifier, List<CartItem>>((ref) {
  return CartNotifier();
});

class CartNotifier extends StateNotifier<List<CartItem>> {
  CartNotifier() : super([]);

  double get totalPrice => state.fold(
    0.0,
        (sum, item) => sum + (item.price * item.quantity),
  );

  void addToCart(CartItem item) {
    final existingItemIndex = state.indexWhere((i) => i.id == item.id);
    if (existingItemIndex >= 0) {
      state = [
        ...state.sublist(0, existingItemIndex),
        CartItem(
          id: item.id,
          title: item.title,
          price: item.price,
          quantity: state[existingItemIndex].quantity + 1,
          imageUrl: item.imageUrl,
          description: item.description,
        ),
        ...state.sublist(existingItemIndex + 1),
      ];
    } else {
      state = [...state, item];
    }
  }

  void updateQuantity(String itemId, int newQuantity) {
    final index = state.indexWhere((item) => item.id == itemId);
    if (index >= 0 && newQuantity > 0) {
      state = [
        ...state.sublist(0, index),
        CartItem(
          id: state[index].id,
          title: state[index].title,
          price: state[index].price,
          quantity: newQuantity,
          imageUrl: state[index].imageUrl,
          description: state[index].description,
        ),
        ...state.sublist(index + 1),
      ];
    }
  }

  void removeFromCart(String itemId) {
    state = state.where((item) => item.id != itemId).toList();
  }
}