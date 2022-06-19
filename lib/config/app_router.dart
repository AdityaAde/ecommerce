import 'package:ecommerce/models/models.dart';
import 'package:flutter/material.dart';
import '../screens/screens.dart';

/// Create [AppRouter] Navigasi halaman
class AppRouter {
  static Route onGenerateRoute(RouteSettings settings) {
    print('this is route $settings');
    switch (settings.name) {
      case '/':
        return HomeScreen.route();
      // ignore: no_duplicate_case_values
      case HomeScreen.routeName:
        return HomeScreen.route();
      case CartScreen.routeName:
        return CartScreen.route();
      case ProductScreen.routeName:
        return ProductScreen.route();
      case WishListScreen.routeName:
        return WishListScreen.route();
      case CatalogScreen.routeName:
        return CatalogScreen.route(category: settings.arguments as Category);
      default:
        return _errorRoute();
    }
  }

  static Route _errorRoute() {
    return MaterialPageRoute(
        settings: const RouteSettings(name: '/error'),
        builder: (_) => Scaffold(
              appBar: AppBar(
                title: const Text('Something went worng'),
              ),
            ));
  }
}
