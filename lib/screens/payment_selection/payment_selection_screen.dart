import 'package:ecommerce/blocs/bloc/bloc.dart';
import 'package:ecommerce/models/payment_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pay/pay.dart';

import '../../widgets/widgets.dart';

class PaymentSelection extends StatelessWidget {
  const PaymentSelection({Key? key}) : super(key: key);

  static const String routeName = '/payment-selection';
  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (context) => const PaymentSelection(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Payment Selection'),
      bottomNavigationBar: const CustomNavBar(screen: routeName),
      body: BlocBuilder<PaymentBloc, PaymentState>(
        builder: (context, state) {
          if (state is PaymentLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is PaymentLoaded) {
            return ListView(
              padding: const EdgeInsets.all(20),
              children: [
                RawGooglePayButton(
                  style: GooglePayButtonStyle.black,
                  type: GooglePayButtonType.pay,
                  onPressed: () {
                    context.read<PaymentBloc>().add(const SelectPaymentMethod(paymentMethod: PaymentMethod.google_pay));
                    print('Google pay Selected');
                    Navigator.pop(context);
                  },
                ),
                ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Pay With Card')),
              ],
            );
          } else {
            return const Center(child: Text('Something went wrong'));
          }
        },
      ),
    );
  }
}
