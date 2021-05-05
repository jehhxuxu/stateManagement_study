import 'package:flutter/material.dart';

import '../model/catalog.dart';
import '../model/item_model.dart';

List<Item> cart = [];

class MyCatalog extends StatefulWidget {
  @override
  _MyCatalogState createState() => _MyCatalogState();
}

class _MyCatalogState extends State<MyCatalog> {
  void refreshPage(List<Item> _cart) {
    setState(() {
      cart = _cart;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          _MyAppBar(refreshPage),
          SliverToBoxAdapter(child: SizedBox(height: 12)),
          SliverList(
            delegate: SliverChildBuilderDelegate(
                (context, index) => _MyListItem(index)),
          ),
        ],
      ),
    );
  }
}

class _AddButton extends StatefulWidget {
  final Item item;

  const _AddButton({@required this.item, Key key}) : super(key: key);

  @override
  __AddButtonState createState() => __AddButtonState();
}

class __AddButtonState extends State<_AddButton> {
  @override
  Widget build(BuildContext context) {
    bool isInCart = cart.contains(widget.item);
    return TextButton(
      onPressed: isInCart
          ? null
          : () {
              setState(() {
                cart.add(widget.item);
              });
            },
      style: ButtonStyle(
        overlayColor: MaterialStateProperty.resolveWith<Color>((states) {
          if (states.contains(MaterialState.pressed)) {
            return Theme.of(context).primaryColor;
          }
          return null; // Defer to the widget's default.
        }),
      ),
      child: isInCart ? Icon(Icons.check, semanticLabel: 'ADDED') : Text('ADD'),
    );
  }
}

class _MyAppBar extends StatelessWidget {
  _MyAppBar(this.refreshPage);
  final Function(List<Item> _cart) refreshPage;
  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      title: Text('Catalog', style: Theme.of(context).textTheme.headline1),
      floating: true,
      actions: [
        IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () async {
              final result =
                  await Navigator.pushNamed(context, '/cart', arguments: cart);
              refreshPage(result);
            }),
      ],
    );
  }
}

class _MyListItem extends StatelessWidget {
  final int index;

  _MyListItem(this.index, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CatalogModel catalog = CatalogModel();
    Item item = catalog.getByPosition(index);
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
            _AddButton(item: item),
          ],
        ),
      ),
    );
  }
}
