import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:project_3/providers/cart_provider.dart';

class CartScreen extends ConsumerWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cartItems = ref.watch(cartProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Cart')),
      body: cartItems.isEmpty
          ? const Center(child: Text('Cart is empty'))
          : Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: cartItems.length,
              itemBuilder: (context, index) {
                final item = cartItems[index];
                return ListTile(
                  leading: Image.network(
                    item.imageUrl,
                    width: 50,
                    height: 50,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) =>
                    const Icon(Icons.image_not_supported),
                  ),
                  title: Text(item.title),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('${item.price.toStringAsFixed(2)} EGP'),
                      Row(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.remove),
                            onPressed: () {
                              ref
                                  .read(cartProvider.notifier)
                                  .updateQuantity(item.id, item.quantity - 1);
                            },
                          ),
                          Text('Qty: ${item.quantity}'),
                          IconButton(
                            icon: const Icon(Icons.add),
                            onPressed: () {
                              ref
                                  .read(cartProvider.notifier)
                                  .updateQuantity(item.id, item.quantity + 1);
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () {
                      ref.read(cartProvider.notifier).removeFromCart(item.id);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                            content: Text('${item.title} removed from cart!')),
                      );
                    },
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Total: ${ref.read(cartProvider.notifier).totalPrice.toStringAsFixed(2)} EGP',
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
        ],
      ),
    );
  }
}