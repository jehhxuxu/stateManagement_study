import 'package:flutter/material.dart';

import '../model/catalog.dart';
import '../model/item_model.dart';

class MyCatalog extends StatefulWidget {
  @override
  _MyCatalogState createState() => _MyCatalogState();
}

class _MyCatalogState extends State<MyCatalog> {
  List<Item> _cart = [];

  void refreshPage(List<Item> cart) {
    setState(() {
      _cart = cart;
    });
  }

  void _showShoppingCart() async {
    final result =
        await Navigator.pushNamed(context, '/cart', arguments: _cart);
    refreshPage(result);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            title:
                Text('Catalog', style: Theme.of(context).textTheme.headline1),
            floating: true,
            actions: [
              IconButton(
                  icon: Icon(Icons.shopping_cart),
                  onPressed: _showShoppingCart),
            ],
          ),
          SliverToBoxAdapter(child: SizedBox(height: 12)),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final item = _cart[index];
                return _MyListItem(
                  item: item,
                  isInCart: _cart.contains(item),
                  onTap: () {
                    _cart.add(item);
                    refreshPage(_cart);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _AddButton extends StatelessWidget {
  final Item item;
  final bool isInCart;
  final VoidCallback onTap;

  const _AddButton(
      {@required this.item, this.isInCart = false, this.onTap, Key key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: isInCart ? null : onTap,
      style: ButtonStyle(
        overlayColor: MaterialStateProperty.resolveWith<Color>(
          (states) {
            if (states.contains(MaterialState.pressed)) {
              return Theme.of(context).primaryColor;
            }
            return null; // Defer to the widget's default.
          },
        ),
      ),
      child: isInCart ? Icon(Icons.check, semanticLabel: 'ADDED') : Text('ADD'),
    );
  }
}

class _MyListItem extends StatelessWidget {
  final Item item;
  final bool isInCart;
  final VoidCallback onTap;

  _MyListItem({this.item, this.isInCart, this.onTap, Key key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme.headline6;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: LimitedBox(
        maxHeight: 48,
        child: Row(
          children: [
            AspectRatio(
              aspectRatio: 1,
              child: Container(
                color: item.color,
              ),
            ),
            SizedBox(width: 24),
            Expanded(
              child: Text(item.name, style: textTheme),
            ),
            SizedBox(width: 24),
            _AddButton(
              item: item,
              isInCart: isInCart,
              onTap: onTap,
            ),
          ],
        ),
      ),
    );
  }
}
