import 'package:ecommerce/blocs/bloc/checkout_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../widgets/widgets.dart';

class CheckoutScreen extends StatelessWidget {
  static const String routeName = '/checkout';

  const CheckoutScreen({Key? key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (context) => const CheckoutScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: const CustomAppBar(title: 'Checkout'),
      bottomNavigationBar: const CustomNavBar(screen: routeName),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: BlocBuilder<CheckoutBloc, CheckoutState>(
          builder: (context, state) {
            if (state is CheckoutLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state is CheckoutLoaded) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('CUSTOMER INFORMATION', style: textTheme.headline3),
                  CustomTextFormField(
                    title: 'Email',
                    onChanged: (value) {
                      context.read<CheckoutBloc>().add(UpdateCheckout(email: value));
                    },
                  ),
                  CustomTextFormField(
                    title: 'Full Name',
                    onChanged: (value) {
                      context.read<CheckoutBloc>().add(UpdateCheckout(fullName: value));
                    },
                  ),
                  const SizedBox(height: 20),
                  Text('DELIVERY INFORMATION', style: textTheme.headline3),
                  CustomTextFormField(
                    title: 'Address',
                    onChanged: (value) {
                      context.read<CheckoutBloc>().add(UpdateCheckout(address: value));
                    },
                  ),
                  CustomTextFormField(
                    title: 'City',
                    onChanged: (value) {
                      context.read<CheckoutBloc>().add(UpdateCheckout(city: value));
                    },
                  ),
                  CustomTextFormField(
                    title: 'Country',
                    onChanged: (value) {
                      context.read<CheckoutBloc>().add(UpdateCheckout(country: value));
                    },
                  ),
                  CustomTextFormField(
                    title: 'Zip Code',
                    onChanged: (value) {
                      context.read<CheckoutBloc>().add(UpdateCheckout(zipCode: value));
                    },
                  ),
                  const SizedBox(height: 20),
                  Container(
                    height: 60,
                    alignment: Alignment.bottomCenter,
                    decoration: const BoxDecoration(color: Colors.black),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Center(
                          child: TextButton(
                            onPressed: () {
                              Navigator.pushNamed(context, '/payment-selection');
                            },
                            child: Text(
                              'SELECT A PAYMENT METHOD',
                              style: Theme.of(context).textTheme.headline3!.copyWith(color: Colors.white),
                            ),
                          ),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.arrow_forward,
                            color: Colors.white,
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text('ORDER SUMMARY', style: textTheme.headline3),
                  const OrderSummary(),
                ],
              );
            } else {
              return const Center(child: Text('Something went wrong'));
            }
          },
        ),
      ),
    );
  }
}
