import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_shopper/model/item_model.dart';
import 'package:equatable/equatable.dart';

part 'cart_bloc_event.dart';
part 'cart_bloc_state.dart';

class CartBloc extends Bloc<CartBlocEvent, CartBlocState> {
  CartBloc() : super(CartBlocInitial());

  List<Item> _cart = [];

  @override
  Stream<CartBlocState> mapEventToState(
    CartBlocEvent event,
  ) async* {
    if (event is AddItemEvent) {
      yield CartBlocLoading(_cart);
      await Future.delayed(Duration(seconds: 1));
      _cart.add(event.item);
      yield CartBlocLoaded(_cart);
    }

    if (event is RemoveItemEvent) {
      yield CartBlocLoading(_cart);
      await Future.delayed(Duration(seconds: 1));
      _cart.remove(event.item);
      yield CartBlocLoaded(_cart);
    }

    if (event is RefreshListEvent) {
      yield CartBlocLoading(_cart);
      await Future.delayed(Duration(seconds: 2));
      yield CartBlocLoaded(_cart);
    }
  }
}
