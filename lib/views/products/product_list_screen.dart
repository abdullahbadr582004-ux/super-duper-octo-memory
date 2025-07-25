import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:project_3/models/cart_item.dart';
import 'package:project_3/views/products/product_detail_screen.dart';
import 'package:project_3/providers/auth_provider.dart';

class ProductListScreen extends ConsumerWidget {
  const ProductListScreen({super.key});

  static final List<CartItem> products = [
    CartItem(
      id: '1',
      title: 'Skip to the beginning of the images gallery TORNADO Washing Machine Half Auto 7 Kg Black TVH-',
      price: 6500,
      quantity: 1,
      imageUrl: 'https://www.elarabygroup.com/media/catalog/product/cache/0ca0ae113b61095583297e198f08e966/image/8252ea24/tornado-washing-machine-half-auto-7-kg-black-tvh-hm07t-bk.jpg',
      description: 'TORNADO Washing Machine Half Automatic 7 Kg Max spin speed : 1400 RPM Washing Machine color : Black With 2 motors Country of origin : Egypt 5 Years full free warranty',
    ),
    CartItem(
      id: '2',
      title: 'TORNADO FHD LED TV 43 Inch Built-In Receiver 43ER9300E',
      price: 12049,
      quantity: 1,
      imageUrl: 'https://www.elarabygroup.com/media/catalog/product/cache/0ca0ae113b61095583297e198f08e966/image/579240ab/tornado-fhd-led-tv-43-inch-built-in-receiver-43er9300e.jpg',
      description: 'TORNADO LED TV 43 Inch Full HD With Built-In Receiver 2 HDMI Inputs 2 USB Inputs Country Of Origin : Egypt 3 Years Full Free Warranty',
    ),
    CartItem(
      id: '3',
      title: 'TORNADO Orbit Fan 16 Inch 4 Blades White TOF-49Y',
      price: 1200,
      quantity: 15,
      imageUrl: 'https://www.elarabygroup.com/media/catalog/product/cache/0ca0ae113b61095583297e198f08e966/image/588189bc/tornado-orbit-fan-16-inch-4-blades-white-tof-49y.jpg',
      description: "TORNADO Orbit Fan ( Carioca ) 16 Inch With White Color Working without remote control 4 Plastic blades Working with 3 selectable speeds Country of origin : Egypt 5 Years full free warranty",
    ),
    CartItem(
      id: '4',
      title: 'TORNADO Stand Fan 18 Inch 4 Blades Black x Red TSF-18MB',
      price: 2200,
      quantity: 10,
      imageUrl: 'https://www.elarabygroup.com/media/catalog/product/cache/0ca0ae113b61095583297e198f08e966/image/5594ce2c/18-4-tsf-18mb.jpg',
      description: 'TORNADO Stand Fan 18 Inch With Black x Red Color Working without remote control 4 Plastic blades Working with 3 selectable speeds Country of origin : Egypt 5 Years full free warranty',
    ),
    CartItem(
      id: '5',
      title: 'Skip to the beginning of the images gallery TORNADO Split Air Conditioner 2.25 HP Cool Digital Supe',
      price: 22000,
      quantity: 10,
      imageUrl: 'https://www.elarabygroup.com/media/catalog/product/cache/0ca0ae113b61095583297e198f08e966/image/83900684/tornado-split-air-conditioner-2-25-hp-cool-digital-super-jet-white-th-c18bee.jpg',
      description: 'TORNADO Air Conditioner 2.25 HP Cool, Standard, Digital Cooling capacity : 18000 ( BTU/H ) Air Conditioner color : White With super jet function Country of origin : Egypt 5 Years full free warranty',
    ),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Products'),
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () {
              Navigator.pushNamed(context, '/cart');
            },
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              ref.read(authProvider.notifier).signOut();

              Navigator.pushNamedAndRemoveUntil(
                context,
                '/',     // يرجعك لصفحة تسجيل الدخول
                    (route) => false, // يمسح كل الصفحات السابقة
              );
            },
          ),
        ],
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(16.0),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 0.7,
        ),
        itemCount: products.length,
        itemBuilder: (context, index) {
          final product = products[index];
          return GestureDetector(
            onTap: () {
              Navigator.pushNamed(
                context,
                '/details',
                arguments: {'product': product},
              );
            },
            child: Card(
              elevation: 4,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.network(
                    product.imageUrl,
                    height: 120,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => const Icon(Icons.image_not_supported),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          product.title,
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        Text(
                          '${product.price.toStringAsFixed(2)} EGP',
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.green),
                        ),
                        Text(
                          product.description,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
