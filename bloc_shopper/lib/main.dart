import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'common/theme.dart';
import 'cubit/cart_cubit.dart';
import 'view/cart.dart';
import 'view/catalog.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => CartCubit(),
        child: MaterialApp(
          title: 'Provider Demo',
          theme: appTheme,
          initialRoute: '/',
          routes: {
            '/': (context) => MyCatalog(),
            '/cart': (context) => MyCart(),
          },
        ));
  }
}
