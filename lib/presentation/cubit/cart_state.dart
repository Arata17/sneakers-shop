abstract class CartState {}

class CartInitial extends CartState {}

class CartLoading extends CartState {}

class CartLoaded extends CartState {
  final Map<String, Map<String, Object>> items;
  CartLoaded({required this.items});
}

class CartItemAdded extends CartState {}

class CartError extends CartState {
  final Error error;
  CartError({required this.error});
}
