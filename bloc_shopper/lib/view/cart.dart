import 'package:bloc_shopper/cubit/cart_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class MyCart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Cart', style: Theme.of(context).textTheme.headline1),
          backgroundColor: Colors.white,
        ),
        body: Container(
          color: Colors.yellow,
          child: Consumer<CartCubit>(
            builder: (context, _cart, child) => Column(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(32),
                    child: _CartList(),
                  ),
                ),
                Divider(height: 4, color: Colors.black),
                _CartTotal()
              ],
            ),
          ),
        ));
  }
}

class _CartList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var itemNameStyle = Theme.of(context).textTheme.headline6;

    var cart = context.read<CartCubit>();

    return ListView.builder(
      itemCount: cart.state.cartList.length,
      itemBuilder: (context, index) => ListTile(
        leading: Icon(Icons.done),
        trailing: IconButton(
          icon: Icon(Icons.remove_circle_outline),
          onPressed: () {
            cart.remove(cart.state.cartList[index]);
          },
        ),
        title: Text(
          cart.state.cartList[index].name,
          style: itemNameStyle,
        ),
      ),
    );
  }
}

class _CartTotal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cart = context.read<CartCubit>();
    var hugeStyle =
        Theme.of(context).textTheme.headline1.copyWith(fontSize: 48);

    return SizedBox(
      height: 200,
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('\$${cart.totalPrice}', style: hugeStyle),
            SizedBox(width: 24),
            TextButton(
              onPressed: () {
                Scaffold.of(context).showSnackBar(
                    SnackBar(content: Text('Buying not supported yet.')));
              },
              style: TextButton.styleFrom(primary: Colors.white),
              child: Text('BUY'),
            ),
          ],
        ),
      ),
    );
  }
}
