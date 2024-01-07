part of 'cart_bloc.dart';

@immutable
sealed class CartState {}

final class CartInitial extends CartState {}

class CartLoadState extends CartState {}

class CartSuccessState extends CartState {
  final List<CartModel> cartList;
  CartSuccessState({
    required this.cartList,
  });
}

class CartErrorState extends CartState {}
