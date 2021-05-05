import 'package:bloc_shopper/model/item_model.dart';
import 'package:equatable/equatable.dart';

class CartState extends Equatable {
  const CartState(this.cartList);

  const CartState.empty() : this.cartList = const <Item>[];

  final List<Item> cartList;

  @override
  List<Object> get props => [cartList];
}
