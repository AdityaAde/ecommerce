import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../widgets/widgets.dart';

class OrderConfirmation extends StatelessWidget {
  static const String routeName = '/order-confirmation';
  const OrderConfirmation({Key? key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (context) => const OrderConfirmation(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Order Confirmation'),
      bottomNavigationBar: const CustomNavBar(screen: routeName),
      extendBodyBehindAppBar: true,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  color: Colors.black,
                  height: 300,
                  width: double.infinity,
                ),
                Positioned(
                  left: MediaQuery.of(context).size.width / 2 - 45,
                  top: 125,
                  child: SvgPicture.asset('assets/svgs/garlands.svg'),
                ),
                Positioned(
                  top: 250,
                  height: 100,
                  width: MediaQuery.of(context).size.width,
                  child: Text(
                    'Your order is complete!',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headline3!.copyWith(color: Colors.white),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('ORDER CODE: 431232', style: Theme.of(context).textTheme.headline5),
                  const SizedBox(height: 10),
                  Text('Thank you for purchasing on My eCommerce', style: Theme.of(context).textTheme.headline6),
                  const SizedBox(height: 10),
                  Text('ORDER CODE: 431232', style: Theme.of(context).textTheme.headline5),
                  const SizedBox(height: 10),
                  const OrderSummary(),
                  const SizedBox(height: 20),
                  Text('ORDER DETAILS', style: Theme.of(context).textTheme.headline5),
                  const Divider(thickness: 2),
                  const SizedBox(height: 5),
                  ListView(
                    shrinkWrap: true,
                    padding: EdgeInsets.zero,
                    physics: const NeverScrollableScrollPhysics(),
                    /*  children: [
                      ProductCard.summary(
                        product: Product.products[0],
                        quantity: 2,
                      ),
                      ProductCard.summary(
                        product: Product.products[1],
                        quantity: 2,
                      ),
                    ], */
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
