import 'dart:async';

import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gift_box_satisfactory/domain/models/shop_item_id.dart';
import 'package:gift_box_satisfactory/domain/models/shop_item_meta.dart';
import 'package:gift_box_satisfactory/injector.dart';

part 'event.dart';
part 'state.dart';

class ShopItemMetasBloc extends Bloc<ShopItemMetasEvent, ShopItemMetasState> {
  ShopItemMetasBloc() : super(const ShopItemMetasLoadInProgress()) {
    on<ShopItemMetasInitializeEvent>(
      _onShopItemMetasInitializeEvent,
      transformer: droppable(),
    );
    on<ShopItemMetasBuyEvent>(
      _onShopItemMetasBuyEvent,
      transformer: droppable(),
    );
  }

  @protected
  static final shopApi = Injector.instance.shopApi;

  Future<void> _onShopItemMetasInitializeEvent(
    ShopItemMetasInitializeEvent event,
    Emitter<ShopItemMetasState> emit,
  ) async {
    final metas = await shopApi.loadMetas();
    emit(ShopItemMetasLoadOnSuccess(metas));
  }

  Future<void> _onShopItemMetasBuyEvent(
    ShopItemMetasBuyEvent event,
    Emitter<ShopItemMetasState> emit,
  ) async {
    if (state case ShopItemMetasLoadOnSuccess(:final metas)) {
      unawaited(shopApi.buyItem(event.id));
      final newMetas = List.of(metas);
      final index = newMetas.indexWhere((meta) => meta.id == event.id);

      if (index != -1) {
        newMetas[index] = newMetas[index].copyWith(isPurchased: true);
        emit(ShopItemMetasLoadOnSuccess(newMetas));
      }
    }

    if (ShopItemId.byId(event.id) == ShopItemId.reset) {
      emit(const ShopItemMetasLoadInProgress());
      await shopApi.resetPurchasedItems();
      final metas = await shopApi.loadMetas();
      emit(ShopItemMetasLoadOnSuccess(metas));
    }
  }
}
