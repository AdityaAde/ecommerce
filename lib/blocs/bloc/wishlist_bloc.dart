// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';

import 'package:ecommerce/models/models.dart';
import 'package:equatable/equatable.dart';

part 'wishlist_event.dart';
part 'wishlist_state.dart';

class WishlistBloc extends Bloc<WishlistEvent, WishlistState> {
  WishlistBloc() : super(WishlistLoading()) {
    on<StartWishList>(_onStartWishlist);
    on<AddProductToWishList>(_onAddProductToWishlist);
    on<RemoveProductFromWishList>(_onRemoveProductFromWishlist);
  }

  void _onStartWishlist(StartWishList event, Emitter<WishlistState> emit) async {
    emit(WishlistLoading());
    try {
      await Future<void>.delayed(const Duration(seconds: 1));
      emit(const WishlistLoaded());
    } catch (e) {
      e;
    }
  }

  void _onAddProductToWishlist(AddProductToWishList event, Emitter<WishlistState> emit) async {
    if (state is WishlistLoaded) {
      try {
        emit(
          WishlistLoaded(
            wishList: WishList(
              products: List.from((state as WishlistLoaded).wishList.products)..add(event.product),
            ),
          ),
        );
      } on Exception {
        emit(WishlistError());
      }
    }
  }

  void _onRemoveProductFromWishlist(RemoveProductFromWishList event, Emitter<WishlistState> emit) async {
    if (state is WishlistLoaded) {
      try {
        emit(WishlistLoaded(
          wishList: WishList(
            products: List.from((state as WishlistLoaded).wishList.products)..remove(event.product),
          ),
        ));
      } on Exception {
        emit(WishlistError());
      }
    }
  }
}
