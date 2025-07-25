import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:project_3/main.dart';
import 'package:project_3/views/auth/sign_in_screen.dart';
import 'package:project_3/views/products/product_list_screen.dart';
import 'package:project_3/views/products/product_detail_screen.dart';
import 'package:project_3/views/cart/cart_screen.dart';
import 'package:project_3/models/cart_item.dart';
import 'package:project_3/providers/cart_provider.dart';
import 'package:project_3/providers/auth_provider.dart';

void main() {
  testWidgets('SignInScreen displays and navigates to ProductListScreen', (WidgetTester tester) async {
    await tester.pumpWidget(
      const ProviderScope(
        child: MyApp(),
      ),
    );

    expect(find.text('Sign In'), findsOneWidget);
    expect(find.text('Email'), findsOneWidget);
    expect(find.text('Password'), findsOneWidget);
    expect(find.text('Login'), findsOneWidget);

    await tester.enterText(find.byType(TextFormField).at(0), 'test@example.com');
    await tester.enterText(find.byType(TextFormField).at(1), 'password123');

    await tester.tap(find.text('Login'));
    await tester.pumpAndSettle(const Duration(seconds: 2)); // انتظر اكتمال العملية غير المتزامنة

    expect(find.byType(ProductListScreen), findsOneWidget);
  });

  testWidgets('ProductListScreen displays products and navigates to ProductDetailScreen', (WidgetTester tester) async {
    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp(
          home: const ProductListScreen(),
        ),
      ),
    );

    expect(find.text('TORNADO Washing Machine Half Auto 7 Kg Black TVH-'), findsOneWidget);
    await tester.tap(find.text('TORNADO Washing Machine Half Auto 7 Kg Black TVH-'));
    await tester.pumpAndSettle();

    expect(find.text('TORNADO Washing Machine Half Auto 7 Kg Black TVH-'), findsWidgets);
    expect(find.text('TORNADO Washing Machine Half Automatic 7 Kg Max spin speed : 1400 RPM Washing Machine color : Black With 2 motors Country of origin : Egypt 5 Years full free warranty'), findsOneWidget);
    expect(find.text('6500.00 EGP'), findsOneWidget);
  });

  testWidgets('ProductDetailScreen displays product info and adds to cart', (WidgetTester tester) async {
    final product = CartItem(
      id: 'test1',
      title: 'Test Product',
      price: 100.0,
      quantity: 1,
      imageUrl: 'https://example.com/image.jpg',
      description: 'Test Description',
    );

    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp(
          home: ProductDetailScreen(product: product),
        ),
      ),
    );

    expect(find.text('Test Product'), findsOneWidget);
    expect(find.text('Test Description'), findsOneWidget);
    expect(find.text('100.00 EGP'), findsOneWidget);
    expect(find.text('Add to Cart'), findsOneWidget);

    await tester.tap(find.text('Add to Cart'));
    await tester.pumpAndSettle();
    expect(find.text('Test Product added to cart!'), findsOneWidget);

    final cartProvider = Provider.of<CartProvider>(tester.element(find.byType(ProductDetailScreen)), listen: false);
    expect(cartProvider.cartItems.any((item) => item.title == 'Test Product'), isTrue);
  });

  testWidgets('CartScreen displays added items', (WidgetTester tester) async {
    final cartProvider = CartProvider();
    cartProvider.addToCart(CartItem(
      id: 'test1',
      title: 'Test Product',
      price: 100.0,
      quantity: 1,
      imageUrl: 'https://example.com/image.jpg',
      description: 'Test Description',
    ));

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          cartProviderNotifier.overrideWithValue(cartProvider),
        ],
        child: const MaterialApp(
          home: CartScreen(),
        ),
      ),
    );

    expect(find.text('Cart'), findsOneWidget);
    expect(find.text('Test Product'), findsOneWidget);
    expect(find.text('100.00 EGP'), findsOneWidget);

    await tester.tap(find.byType(IconButton));
    await tester.pumpAndSettle();
    expect(find.text('Cart is empty'), findsOneWidget);
  });
}