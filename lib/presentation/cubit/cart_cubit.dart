import 'dart:math';

import 'package:sneakers_shop/domain/cart_entity.dart';
import 'package:sneakers_shop/domain/snekaer_entity.dart';
import 'package:sneakers_shop/presentation/cubit/cart_state.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(CartInitial());
  Map<String, Map<String, Object>> cartList = {};
  Map<String, Map<String, Object>> bufferList = {};

  Future<void> addToCart(CartEntity entity, int qty) async {
    emit(CartLoading());
    try {
      if (bufferList.containsKey(entity.modelName)) {
        bufferList[entity.modelName]!.update(
          'qty',
          (value) => (value as int) + qty,
        );
      } else {
        bufferList.addAll({
          entity.modelName: {'item': entity, 'qty': 1}
        });
      }
      emit(CartItemAdded());
    } catch (e) {
      emit(CartError(error: e as Error));
    }
  }

  Future<void> getCartItems() async {
    emit(CartLoading());
    try {
      emit(CartLoaded(items: cartList));
    } catch (e) {
      emit(CartError(error: e as Error));
    }
  }

  Future<void> getCartBufferItems() async {
    emit(CartLoading());
    try {
      emit(CartLoaded(items: cartList));
    } catch (e) {
      emit(CartError(error: e as Error));
    }
  }
}
