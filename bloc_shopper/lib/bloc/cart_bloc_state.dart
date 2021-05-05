part of 'cart_bloc.dart';

abstract class CartBlocState extends Equatable {
  final List<Item> cart;

  const CartBlocState(this.cart);

  double get totalPrice => cart.length * 42.0;

  @override
  List<Object> get props => [cart];
}

class CartBlocInitial extends CartBlocState {
  CartBlocInitial() : super([]);
}

class CartBlocLoading extends CartBlocState {
  CartBlocLoading(List<Item> cart) : super(cart);
}

class CartBlocLoaded extends CartBlocState {
  CartBlocLoaded(List<Item> cart) : super(cart);
}
