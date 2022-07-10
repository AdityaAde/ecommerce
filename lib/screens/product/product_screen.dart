import 'package:carousel_slider/carousel_slider.dart';
import 'package:ecommerce/blocs/bloc/cart_bloc.dart';
import 'package:ecommerce/blocs/bloc/wishlist_bloc.dart';
import 'package:ecommerce/models/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../widgets/widgets.dart';

class ProductScreen extends StatelessWidget {
  final Product product;
  const ProductScreen({Key? key, required this.product}) : super(key: key);

  static const String routeName = '/product';
  static Route route({required Product product}) {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (context) => ProductScreen(product: product),
    );
  }

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: CustomAppBar(title: product.name),
      bottomNavigationBar: BottomAppBar(
        child: Container(
          height: 70,
          color: Colors.black,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.share, color: Colors.white),
              ),
              BlocBuilder<WishlistBloc, WishlistState>(
                builder: (context, state) {
                  return IconButton(
                    onPressed: () {
                      context.read<WishlistBloc>().add(AddProductToWishList(product: product));
                      final snackBar = SnackBar(
                          duration: const Duration(seconds: 4),
                          content: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text('Added to your wishlist'),
                              InkWell(
                                onTap: () => Navigator.pushNamed(context, '/wishlist'),
                                child: const Text('See'),
                              ),
                            ],
                          ));
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    },
                    icon: const Icon(Icons.favorite, color: Colors.white),
                  );
                },
              ),
              Builder(builder: (context) {
                return ElevatedButton(
                  style: ElevatedButton.styleFrom(primary: Colors.white),
                  onPressed: () {
                    context.read<CartBloc>().add(AddProduct(product));
                    Navigator.pushNamed(context, '/cart');
                  },
                  child: Text(
                    'ADD TO CART',
                    style: textTheme.headline3,
                  ),
                );
              }),
            ],
          ),
        ),
      ),
      body: ListView(children: [
        CarouselSlider(
          options: CarouselOptions(
            aspectRatio: 1.5,
            viewportFraction: 0.9,
            enlargeCenterPage: true,
            enlargeStrategy: CenterPageEnlargeStrategy.height,
          ),
          items: [
            HeroCarouselCard(
              product: product,
            )
          ],
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Stack(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: 60,
                alignment: Alignment.bottomCenter,
                color: Colors.black.withAlpha(50),
              ),
              Container(
                margin: const EdgeInsets.all(5.0),
                width: MediaQuery.of(context).size.width - 10,
                height: 50,
                color: Colors.black,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(product.name, style: textTheme.headline5!.copyWith(color: Colors.white)),
                      Text('\$${product.price}', style: textTheme.headline5!.copyWith(color: Colors.white)),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: ExpansionTile(
            initiallyExpanded: true,
            title: Text('Product Information', style: textTheme.headline3),
            children: [
              ListTile(
                title: Text(
                  'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.',
                  textAlign: TextAlign.justify,
                  style: textTheme.bodyText1,
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: ExpansionTile(
            initiallyExpanded: true,
            title: Text('Delivery Information', style: textTheme.headline3),
            children: [
              ListTile(
                title: Text(
                  'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.',
                  textAlign: TextAlign.justify,
                  style: textTheme.bodyText1,
                ),
              ),
            ],
          ),
        ),
      ]),
    );
  }
}