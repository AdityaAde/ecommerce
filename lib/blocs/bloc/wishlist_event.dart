part of 'wishlist_bloc.dart';

abstract class WishlistEvent extends Equatable {
  const WishlistEvent();

  @override
  List<Object> get props => [];
}

class StartWishList extends WishlistEvent {}

class AddProductToWishList extends WishlistEvent {
  final Product product;

  const AddProductToWishList({required this.product});

  @override
  List<Object> get props => [product];
}

class RemoveProductFromWishList extends WishlistEvent {
  final Product product;

  const RemoveProductFromWishList({required this.product});

  @override
  List<Object> get props => [product];
}
