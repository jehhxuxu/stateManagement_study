import 'package:flutter/material.dart';

import '../model/item_model.dart';

class MyCart extends StatefulWidget {
  @override
  _MyCartState createState() => _MyCartState();
}

class _MyCartState extends State<MyCart> {
  void onPressed(int index, List<Item> cart) {
    setState(() {
      cart.remove(cart[index]);
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Item> cart = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
        title: Text('Cart', style: Theme.of(context).textTheme.headline1),
        backgroundColor: Colors.white,
        leading: BackButton(onPressed: () {
          Navigator.maybePop(context, cart);
        }),
      ),
      body: Container(
        color: Colors.yellow,
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(32),
                child: _CartList(
                  cart: cart,
                  onPressed: (index) => onPressed(index, cart),
                ),
              ),
            ),
            Divider(height: 4, color: Colors.black),
            _CartTotal(cart: cart)
          ],
        ),
      ),
    );
  }
}

class _CartList extends StatefulWidget {
  const _CartList({Key key, this.cart, this.onPressed}) : super(key: key);
  final List<Item> cart;
  final Function(int) onPressed;

  @override
  __CartListState createState() => __CartListState();
}

class __CartListState extends State<_CartList> {
  @override
  Widget build(BuildContext context) {
    var itemNameStyle = Theme.of(context).textTheme.headline6;

    return ListView.builder(
      itemCount: widget.cart.length,
      itemBuilder: (context, index) => ListTile(
        leading: Icon(Icons.done),
        trailing: IconButton(
          icon: Icon(Icons.remove_circle_outline),
          onPressed: () => widget.onPressed(index),
        ),
        title: Text(
          widget.cart[index].name,
          style: itemNameStyle,
        ),
      ),
    );
  }
}

class _CartTotal extends StatelessWidget {
  const _CartTotal({Key key, this.cart}) : super(key: key);
  final List<Item> cart;
  @override
  Widget build(BuildContext context) {
    var hugeStyle =
        Theme.of(context).textTheme.headline1.copyWith(fontSize: 48);

    return SizedBox(
      height: 200,
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('\$${cart.length * 42}', style: hugeStyle),
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
