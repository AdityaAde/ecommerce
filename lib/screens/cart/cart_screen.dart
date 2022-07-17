import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/bloc/bloc.dart';
import '../../widgets/widgets.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  static const String routeName = '/cart';
  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (_) => const CartScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    return Scaffold(
        appBar: const CustomAppBar(title: 'Cart'),
        bottomNavigationBar: BottomAppBar(
          color: Colors.black,
          child: SizedBox(
              height: 70,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(primary: Colors.white),
                    onPressed: () {},
                    child: Text(
                      'GO TO CHECKOUT',
                      style: textTheme.headline3,
                    ),
                  ),
                ],
              )),
        ),
        body: BlocBuilder<CartBloc, CartState>(
          builder: (context, state) {
            if (state is CartLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is CartLoaded) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      flex: 4,
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                state.cart.freeDeliveryString,
                                style: textTheme.headline5,
                              ),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(primary: Colors.black),
                                onPressed: () {
                                  Navigator.pushNamed(context, "/");
                                },
                                child: Text(
                                  "Add More Items",
                                  style: textTheme.headline5!.copyWith(color: Colors.white),
                                ),
                              ),
                            ],
                          ),
                          Expanded(
                            child: ListView.builder(
                                itemCount: state.cart.products.length,
                                itemBuilder: (context, index) {
                                  return CartProductCard(product: state.cart.products[index], textTheme: textTheme);
                                }),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          const Divider(thickness: 2),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 10),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("SUB TOTAL", style: textTheme.headline5),
                                    Text("\$${state.cart.subtotalString}", style: textTheme.headline5),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("DELIVERY FEE", style: textTheme.headline5),
                                    Text("\$${state.cart.deliveryFeeString}", style: textTheme.headline5),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Stack(
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width,
                                height: 60,
                                decoration: BoxDecoration(color: Colors.black.withAlpha(50)),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                                width: MediaQuery.of(context).size.width,
                                margin: const EdgeInsets.all(5.0),
                                height: 50,
                                decoration: const BoxDecoration(color: Colors.black),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("TOTAL", style: textTheme.headline5!.copyWith(color: Colors.white)),
                                    Text("\$${state.cart.totalString}",
                                        style: textTheme.headline5!.copyWith(color: Colors.white)),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            } else {
              return const Center(
                child: Text("Something went wrong"),
              );
            }
          },
        ));
  }
}
