part of 'cart_bloc.dart';

abstract class CartBlocEvent extends Equatable {
  const CartBlocEvent();

  @override
  List<Object> get props => [];
}

class AddItemEvent extends CartBlocEvent {
  final Item item;

  AddItemEvent(this.item);

  @override
  List<Object> get props => [item];
}

class RemoveItemEvent extends CartBlocEvent {
  final Item item;

  RemoveItemEvent(this.item);

  @override
  List<Object> get props => [item];
}
