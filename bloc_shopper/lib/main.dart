import 'package:bloc_shopper/bloc/cart_bloc.dart';
import 'package:bloc_shopper/view/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'common/theme.dart';
import 'view/cart.dart';
import 'view/catalog.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CartBloc(),
      child: MaterialApp(
        title: 'flutter_bloc Demo',
        theme: appTheme,
        initialRoute: '/',
        routes: {
          '/': (context) => LoginPage(),
          '/cart': (context) => MyCart(),
        },
      ),
    );
  }
}
