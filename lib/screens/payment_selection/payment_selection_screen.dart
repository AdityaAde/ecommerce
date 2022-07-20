import 'package:flutter/material.dart';

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
    return Container();
  }
}
