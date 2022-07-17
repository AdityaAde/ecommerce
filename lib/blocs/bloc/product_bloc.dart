// ignore: depend_on_referenced_packages
import 'dart:async';

// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:ecommerce/models/models.dart';
import 'package:ecommerce/repositories/product/product_repository.dart';
import 'package:equatable/equatable.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductReposiotry _productReposiotry;
  StreamSubscription? _productSubscription;
  ProductBloc({required ProductReposiotry productReposiotry})
      : _productReposiotry = productReposiotry,
        super(ProductLoading()) {
    on<LoadProducts>(_onLoadProducts);
    on<UpdateProducts>(_onUpdateProducts);
  }

  void _onLoadProducts(
    LoadProducts event,
    Emitter<ProductState> emit,
  ) {
    _productSubscription?.cancel();
    _productSubscription = _productReposiotry.getAllProduct().listen(
          (products) => add(
            UpdateProducts(products),
          ),
        );
  }

  void _onUpdateProducts(
    UpdateProducts event,
    Emitter<ProductState> emit,
  ) {
    emit(ProductLoaded(products: event.products));
  }
}
