import 'package:ecommerce/blocs/bloc/cart_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/models.dart';

class CartProductCard extends StatelessWidget {
  final Product product;
  final TextTheme textTheme;
  const CartProductCard({Key? key, required this.product, required this.textTheme}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Image.network(
            product.imageUrl,
            width: 100,
            height: 80,
            fit: BoxFit.cover,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(product.name, style: textTheme.headline5),
                Text("\$${product.price}", style: textTheme.headline6),
              ],
            ),
          ),
          BlocBuilder<CartBloc, CartState>(
            builder: (context, state) {
              return Row(
                children: [
                  IconButton(
                      onPressed: () {
                        context.read<CartBloc>().add(RemoveProduct(product));
                      },
                      icon: const Icon(Icons.remove_circle)),
                  Text("1", style: textTheme.headline5),
                  IconButton(
                      onPressed: () {
                        context.read<CartBloc>().add(AddProduct(product));
                      },
                      icon: const Icon(Icons.add_circle)),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
