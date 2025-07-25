import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:project_3/models/cart_item.dart';
import 'package:project_3/providers/cart_provider.dart';

class ProductDetailScreen extends ConsumerWidget {
  final CartItem product;

  const ProductDetailScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: Text(product.title)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              product.imageUrl,
              height: 200,
              width: double.infinity,
              fit: BoxFit.contain,
              errorBuilder: (_, __, ___) =>
              const Icon(Icons.image_not_supported, size: 100),
            ),
            const SizedBox(height: 16),
            Text(
              product.title,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            Text(
              '${product.price.toStringAsFixed(2)} EGP',
              style: Theme.of(context)
                  .textTheme
                  .titleMedium
                  ?.copyWith(color: Colors.green),
            ),
            const SizedBox(height: 8),
            Text(
              product.description,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                ref.read(cartProvider.notifier).addToCart(product);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('${product.title} added to cart!')),
                );
              },
              child: const Text('Add to Cart'),
            ),
          ],
        ),
      ),
    );
  }
}