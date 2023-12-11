part of 'products_bloc.dart';

@immutable
sealed class ProductsState {}

final class ProductsInitial extends ProductsState {}

class ProductsFetchSuccessState extends ProductsState {
  final List<ProductModel> products;
  ProductsFetchSuccessState({
    required this.products,
  });
}

class ProductsFetchErrorState extends ProductsState {}

class ProductsFetchLoadingState extends ProductsState {}
