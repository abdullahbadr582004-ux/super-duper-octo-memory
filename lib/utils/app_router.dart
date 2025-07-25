import 'package:flutter/material.dart';
import 'package:project_3/views/auth/sign_in_screen.dart';
import 'package:project_3/views/auth/sign_up_screen.dart';
import 'package:project_3/views/products/product_list_screen.dart';
import 'package:project_3/views/products/product_detail_screen.dart';
import 'package:project_3/views/cart/cart_screen.dart';
import 'package:project_3/models/cart_item.dart';

class AppRouter {
  static Route<dynamic>? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => const SignInScreen());
      case '/signup':
        return MaterialPageRoute(builder: (_) => const SignUpScreen());
      case '/products':
        return MaterialPageRoute(builder: (_) => const ProductListScreen());
      case '/details':
        if (settings.arguments is Map<String, dynamic>) {
          final args = settings.arguments as Map<String, dynamic>;
          if (args['product'] is CartItem) {
            return MaterialPageRoute(
              builder: (_) =>
                  ProductDetailScreen(product: args['product'] as CartItem),
            );
          }
        }
        return _errorRoute();
      case '/cart':
        return MaterialPageRoute(builder: (_) => const CartScreen());
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(
      builder: (_) => const Scaffold(
        body: Center(child: Text('No route defined')),
      ),
    );
  }
}
