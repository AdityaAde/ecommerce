import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../../models/models.dart';
import '../../widgets/products_carousel.dart';
import '../../widgets/widgets.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  static const String routeName = '/';
  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (_) => const HomeScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Market Place'),
      bottomNavigationBar: const CustomNavBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            CarouselSlider(
              options: CarouselOptions(
                aspectRatio: 1.5,
                viewportFraction: 0.9,
                enlargeCenterPage: true,
                enlargeStrategy: CenterPageEnlargeStrategy.height,
              ),
              items: Category.categories.map((e) => HeroCarouselCard(category: e)).toList(),
            ),

            /// RECOMMENDED
            const SectionTitle(title: 'RECOMMENDED'),
            ProductCarousel(products: Product.products.where((product) => product.isRecommended).toList()),

            /// MOST POPULAR
            const SectionTitle(title: 'MOST POPULAR'),
            ProductCarousel(products: Product.products.where((product) => product.isPopular).toList()),
          ],
        ),
      ),
    );
  }
}
