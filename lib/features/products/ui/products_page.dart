import 'package:ecommerce_user/features/products/bloc/products_bloc.dart';
import 'package:ecommerce_user/features/products/repos/products_repo.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductsPage extends StatefulWidget {
  const ProductsPage({super.key});

  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  ProductsBloc productsBloc = ProductsBloc();

  @override
  void initState() {
    productsBloc.add(ProductsFetchInitialEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                FirebaseAuth.instance.signOut();
              },
              icon: Icon(Icons.logout))
        ],
        title: Text('Products Page'),
      ),
      body: BlocConsumer<ProductsBloc, ProductsState>(
        bloc: productsBloc,
        listener: (context, state) {},
        builder: (context, state) {
          switch (state.runtimeType) {
            case ProductsFetchLoadingState:
              return const Center(child: CircularProgressIndicator());

            case ProductsFetchErrorState:
              return Center(child: Text("Something went wrong"));
            case ProductsFetchSuccessState:
              final successState = state as ProductsFetchSuccessState;
              return Container(
                child: ListView.separated(
                  separatorBuilder: (BuildContext context, int index) =>
                      const Divider(
                    height: 40,
                  ),
                  padding: const EdgeInsets.only(top: 12),
                  itemCount: successState.products.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(successState.products[index].name),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(successState.products[index].description),
                          Text('Rs. ' +
                              successState.products[index].price.toString() +
                              '/-'),
                          const SizedBox(height: 10),
                          SizedBox(
                            width: 120,
                            height: 32,
                            child: ElevatedButton(
                                onPressed: () {
                                  ProductsRepo.updateMyCart(
                                      successState.products[index].id);
                                },
                                child: Text("Add to Cart")),
                          )
                        ],
                      ),
                    );
                  },
                ),
              );
            default:
              return Container();
          }
        },
      ),
    );
  }
}
