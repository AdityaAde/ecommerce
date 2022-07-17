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
              return SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('CUSTOMER INFORMATION', style: textTheme.headline3),
                    _buildTextFormField((value) {
                      context.read<CheckoutBloc>().add(UpdateCheckout(email: value));
                    }, context, 'Email'),
                    _buildTextFormField((value) {
                      context.read<CheckoutBloc>().add(UpdateCheckout(fullName: value));
                    }, context, 'Full Name'),
                    Text('DELIVERY INFORMATION', style: textTheme.headline3),
                    _buildTextFormField((value) {
                      context.read<CheckoutBloc>().add(UpdateCheckout(address: value));
                    }, context, 'Address'),
                    _buildTextFormField((value) {
                      context.read<CheckoutBloc>().add(UpdateCheckout(city: value));
                    }, context, 'City'),
                    _buildTextFormField((value) {
                      context.read<CheckoutBloc>().add(UpdateCheckout(country: value));
                    }, context, 'Country'),
                    _buildTextFormField((value) {
                      context.read<CheckoutBloc>().add(UpdateCheckout(zipCode: value));
                    }, context, 'Zip Code'),
                    Text('ORDER SUMMARY', style: textTheme.headline3),
                    const OrderSummary(),
                  ],
                ),
              );
            } else {
              return const Center(child: Text('Something went wrong'));
            }
          },
        ),
      ),
    );
  }

  Padding _buildTextFormField(
    Function(String)? onChanged,
    BuildContext context,
    String labelText,
  ) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          SizedBox(
            width: 75,
            child: Text(labelText, style: Theme.of(context).textTheme.bodyText1),
          ),
          Expanded(
            child: TextFormField(
              onChanged: onChanged,
              decoration: const InputDecoration(
                isDense: true,
                contentPadding: EdgeInsets.only(left: 10),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
