import 'package:ecommerce_user/features/cart/bloc/cart_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  CartBloc cartBloc = CartBloc();

  @override
  void initState() {
    cartBloc.add(CartLoadEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Shopping Cart'),
      ),
      body: BlocConsumer<CartBloc, CartState>(
        bloc: cartBloc,
        listener: (context, state) {},
        builder: (context, state) {
          switch (state.runtimeType) {
            case CartLoadState:
              return const Center(
                child: CircularProgressIndicator(),
              );

            case CartErrorState:
              return const Center(
                child: Text("Something went wrong"),
              );
            case CartSuccessState:
              final successState = state as CartSuccessState;
              return Column(
                children: List.generate(
                    successState.cartList.length,
                    (index) => Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ListTile(
                            tileColor: Colors.grey.shade200,
                            title: Text(successState.cartList[index].productId),
                            subtitle: Text(successState.cartList[index].quantity
                                .toString()),
                          ),
                        )),
              );

            default:
              return const Center(
                child: CircularProgressIndicator(),
              );
          }
        },
      ),
    );
  }
}
