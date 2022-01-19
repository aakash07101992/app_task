import 'package:app_task_cart/app_screen/cart/view/screen_cart.dart';
import 'package:app_task_cart/app_screen/products/views/screen_products.dart';
import 'package:app_task_cart/app_screen/repo/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'app_screen/cart/bloc_cart/cart_bloc.dart';
import 'app_screen/products/bloc_product/product_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => ProductBloc(repository: ProductService())),
        BlocProvider(create: (_) => CartBloc()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const ScreenProducts(),
      ),
    );
  }
}
