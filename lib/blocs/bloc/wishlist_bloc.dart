// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';

import 'package:ecommerce/models/models.dart';
import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

import '../../repositories/repositories.dart';

part 'wishlist_event.dart';
part 'wishlist_state.dart';

class WishlistBloc extends Bloc<WishlistEvent, WishlistState> {
  final LocalStorageRepository _localStorageRepository;
  WishlistBloc({required LocalStorageRepository localStorageRepository})
      : _localStorageRepository = localStorageRepository,
        super(WishlistLoading()) {
    on<StartWishList>(_onStartWishlist);
    on<AddProductToWishList>(_onAddProductToWishlist);
    on<RemoveProductFromWishList>(_onRemoveProductFromWishlist);
  }

  void _onStartWishlist(StartWishList event, Emitter<WishlistState> emit) async {
    emit(WishlistLoading());

    try {
      Box box = await _localStorageRepository.openBox();
      List<Product> products = _localStorageRepository.getWishlist(box);

      await Future<void>.delayed(const Duration(seconds: 1));
      emit(WishlistLoaded(wishList: WishList(products: products)));
    } catch (e) {
      e;
    }
  }

  void _onAddProductToWishlist(AddProductToWishList event, Emitter<WishlistState> emit) async {
    if (state is WishlistLoaded) {
      try {
        Box box = await _localStorageRepository.openBox();
        _localStorageRepository.addProductToWishlist(box, event.product);
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
        Box box = await _localStorageRepository.openBox();
        _localStorageRepository.removeProductFromWishlist(box, event.product);
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
