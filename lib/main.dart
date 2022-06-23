import 'package:ecommerce/blocs/bloc/cart_bloc.dart';
import 'package:ecommerce/blocs/bloc/wishlist_bloc.dart';
import 'package:ecommerce/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'config/config.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => WishlistBloc()..add(StartWishList()),
        ),
        BlocProvider(
          create: (context) => CartBloc()..add(LoadCart()),
        ),
      ],
      child: MaterialApp(
        title: 'Zero To Unicorn',
        theme: theme(),
        debugShowCheckedModeBanner: false,
        onGenerateRoute: AppRouter.onGenerateRoute,
        initialRoute: SplashScreen.routeName,
      ),
    );
  }
}
