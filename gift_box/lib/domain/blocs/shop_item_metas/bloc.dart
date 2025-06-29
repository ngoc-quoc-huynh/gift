import 'dart:async';

import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gift_box/domain/models/shop_item_meta.dart';
import 'package:gift_box/injector.dart';

part 'event.dart';
part 'state.dart';

sealed class ShopItemMetasBloc
    extends Bloc<ShopItemMetasEvent, ShopItemMetasState> {
  ShopItemMetasBloc(this._lodMetas)
    : super(const ShopItemMetasLoadInProgress()) {
    on<ShopItemMetasInitializeEvent>(
      _onShopItemMetasInitializeEvent,
      transformer: droppable(),
    );
    on<ShopItemMetasBuyEvent>(
      _onShopItemMetasBuyEvent,
      transformer: droppable(),
    );
  }

  final FutureOr<List<ShopItemMeta>> Function() _lodMetas;

  @protected
  static final shopApi = Injector.instance.shopApi;

  Future<void> _onShopItemMetasInitializeEvent(
    ShopItemMetasInitializeEvent event,
    Emitter<ShopItemMetasState> emit,
  ) async {
    final metas = await _lodMetas();
    emit(ShopItemMetasLoadOnSuccess(metas));
  }

  void _onShopItemMetasBuyEvent(
    ShopItemMetasBuyEvent event,
    Emitter<ShopItemMetasState> emit,
  ) {
    if (state case ShopItemMetasLoadOnSuccess(:final metas)) {
      unawaited(shopApi.buyItem(event.id));
      final newMetas = List.of(metas);
      final index = newMetas.indexWhere((meta) => meta.id == event.id);

      if (index != -1) {
        newMetas[index] = newMetas[index].copyWith(isPurchased: true);
        emit(ShopItemMetasLoadOnSuccess(newMetas));
      }
    }
  }
}

final class ShopItemMetasSpecialsBloc extends ShopItemMetasBloc {
  ShopItemMetasSpecialsBloc()
    : super(ShopItemMetasBloc.shopApi.loadSpecialMetas);
}

final class ShopItemMetasCustomizerBloc extends ShopItemMetasBloc {
  ShopItemMetasCustomizerBloc()
    : super(ShopItemMetasBloc.shopApi.loadCustomizerMetas);
}

final class ShopItemMetasEquipmentBloc extends ShopItemMetasBloc {
  ShopItemMetasEquipmentBloc()
    : super(ShopItemMetasBloc.shopApi.loadEquipmentMetas);
}
