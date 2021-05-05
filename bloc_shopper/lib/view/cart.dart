import 'package:bloc_shopper/bloc/cart_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyCart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartBloc, CartBlocState>(
      builder: (context, state) => Scaffold(
        bottomNavigationBar: state is CartBlocLoading
            ? LinearProgressIndicator(
                minHeight: 16,
                valueColor: AlwaysStoppedAnimation(Colors.white),
              )
            : null,
        appBar: AppBar(
          title: Text('Cart', style: Theme.of(context).textTheme.headline1),
          backgroundColor: Colors.white,
        ),
        body: Container(
          color: Colors.yellow,
          child: Column(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(32),
                  child: _CartList(),
                ),
              ),
              Divider(height: 4, color: Colors.black),
              _CartTotal(),
            ],
          ),
        ),
      ),
    );
  }
}

class _CartList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var itemNameStyle = Theme.of(context).textTheme.headline6;

    final bloc = BlocProvider.of<CartBloc>(context, listen: false);

    return BlocBuilder<CartBloc, CartBlocState>(
      builder: (context, state) {
        return ListView.builder(
          itemCount: state.cart.length,
          itemBuilder: (context, index) {
            final item = state.cart[index];
            return ListTile(
              leading: Icon(Icons.done),
              trailing: IconButton(
                icon: Icon(Icons.remove_circle_outline),
                onPressed: () => bloc.add(RemoveItemEvent(item)),
              ),
              title: Text(
                item.name,
                style: itemNameStyle,
              ),
            );
          },
        );
      },
    );
  }
}

class _CartTotal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var hugeStyle =
        Theme.of(context).textTheme.headline1.copyWith(fontSize: 48);
    return BlocBuilder<CartBloc, CartBlocState>(
      builder: (context, state) {
        return SizedBox(
          height: 200,
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('${state.totalPrice}', style: hugeStyle),
                SizedBox(width: 24),
                TextButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Buying not supported yet.'),
                      ),
                    );
                  },
                  style: TextButton.styleFrom(primary: Colors.white),
                  child: Text('BUY'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
