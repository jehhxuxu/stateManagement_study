import 'package:bloc_shopper/cubit/cart_state.dart';
import 'package:bloc_shopper/model/item_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(CartState.empty());

  void addToCart(Item item) async {
    emit(CartState([...state.cartList, item]));
  }

  void remove(Item item) {
    // assim é igual o que esta ali
    // var newCartList = <Item>[...state.cartList] ou <Item>[]..addAll(..state.cartList)
    // newCartList.remove(item);
    emit(CartState(state.cartList.where((_item) => _item != item).toList()));
  }

  double get totalPrice => state.cartList.length * 42.0;
}
