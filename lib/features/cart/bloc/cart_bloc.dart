import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:ecommerce_user/features/cart/models/cart_model.dart';
import 'package:ecommerce_user/features/cart/repos/cart_repo.dart';
import 'package:meta/meta.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartInitial()) {
    on<CartLoadEvent>(cartLoadEvent);
  }

  FutureOr<void> cartLoadEvent(
      CartLoadEvent event, Emitter<CartState> emit) async {
    emit(CartLoadState());
    List<CartModel>? cartList = await CartRepo.fetchUserCart();
    if (cartList != null) {
      emit(CartSuccessState(cartList: cartList));
    } else {
      emit(CartErrorState());
    }
  }
}
