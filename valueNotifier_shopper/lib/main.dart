import 'package:flutter/material.dart';

import 'common/theme.dart';
import 'view/cart.dart';
import 'view/catalog.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ValueNotifier Demo',
      theme: appTheme,
      initialRoute: '/',
      routes: {
        '/': (context) => MyCatalog(),
        '/cart': (context) => MyCart(),
      },
    );
  }
}
