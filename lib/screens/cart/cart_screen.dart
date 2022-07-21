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
        bottomNavigationBar: const CustomNavBar(screen: routeName),
        body: BlocBuilder<CartBloc, CartState>(
          builder: (context, state) {
            if (state is CartLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is CartLoaded) {
              Map cart = state.cart.productQuantity(state.cart.products);
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      flex: 3,
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
                          const SizedBox(height: 20),
                          SizedBox(
                            height: 400,
                            child: ListView.builder(
                              itemCount: cart.keys.length,
                              itemBuilder: (BuildContext context, int index) {
                                return ProductCard.cart(
                                  product: cart.keys.elementAt(index),
                                  quantity: cart.values.elementAt(index),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    const OrderSummary(),
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
