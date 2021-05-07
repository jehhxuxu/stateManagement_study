import 'package:bloc_shopper/bloc/cart_bloc.dart';
import 'package:bloc_shopper/model/catalog.dart';
import 'package:bloc_shopper/model/item_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyCatalog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartBloc, CartBlocState>(
      builder: (context, state) => Scaffold(
        bottomNavigationBar: state is CartBlocLoading
            ? LinearProgressIndicator(minHeight: 16)
            : null,
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              title:
                  Text('Catalog', style: Theme.of(context).textTheme.headline1),
              floating: true,
              actions: [
                IconButton(
                  icon: Icon(Icons.shopping_cart),
                  onPressed: () => Navigator.pushNamed(context, '/cart'),
                ),
              ],
            ),
            SliverToBoxAdapter(child: SizedBox(height: 12)),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) => _MyListItem(index),
              ),
            ),
          ],
        ),
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
  final int index;

  _MyListItem(this.index, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CatalogModel catalog = CatalogModel();
    Item item = catalog.getByPosition(index);
    var textTheme = Theme.of(context).textTheme.headline6;
    final bloc = BlocProvider.of<CartBloc>(context, listen: false);

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
              child: Hero(
                tag: item.name,
                child: Text(item.name, style: textTheme),
              ),
            ),
            SizedBox(width: 24),
            BlocBuilder<CartBloc, CartBlocState>(
              cubit: bloc,
              builder: (context, state) => _AddButton(
                item: item,
                isInCart: state.cart.contains(item),
                onTap: () => bloc.add(AddItemEvent(item)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
