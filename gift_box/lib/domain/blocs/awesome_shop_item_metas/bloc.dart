import 'dart:async';

import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gift_box/domain/models/awesome_shop_item_meta.dart';
import 'package:gift_box/injector.dart';

part 'event.dart';
part 'state.dart';

sealed class AwesomeShopItemMetasBloc
    extends Bloc<AwesomeShopItemMetasEvent, AwesomeShopItemMetasState> {
  AwesomeShopItemMetasBloc(this._lodMetas)
    : super(const AwesomeShopItemMetasLoadInProgress()) {
    on<AwesomeShopItemMetasInitializeEvent>(
      _onAwesomeShopItemMetasInitializeEvent,
      transformer: droppable(),
    );
    on<AwesomeShopItemMetasBuyEvent>(
      _onAwesomeShopItemMetasBuyEvent,
      transformer: droppable(),
    );
  }

  final List<AwesomeShopItemMeta> Function() _lodMetas;

  @protected
  static final awesomeShopApi = Injector.instance.awesomeShopApi;

  void _onAwesomeShopItemMetasInitializeEvent(
    AwesomeShopItemMetasInitializeEvent event,
    Emitter<AwesomeShopItemMetasState> emit,
  ) {
    final metas = _lodMetas();
    emit(AwesomeShopItemMetasLoadOnSuccess(metas));
  }

  void _onAwesomeShopItemMetasBuyEvent(
    AwesomeShopItemMetasBuyEvent event,
    Emitter<AwesomeShopItemMetasState> emit,
  ) {
    if (state case AwesomeShopItemMetasLoadOnSuccess(:final metas)) {
      unawaited(awesomeShopApi.buyItem(event.id));
      final newMetas = List.of(metas);
      final index = newMetas.indexWhere((meta) => meta.id == event.id);

      if (index != -1) {
        newMetas[index] = newMetas[index].copyWith(isPurchased: true);
        emit(AwesomeShopItemMetasLoadOnSuccess(newMetas));
      }
    }
  }
}

final class AwesomeShopItemMetasSpecialsBloc extends AwesomeShopItemMetasBloc {
  AwesomeShopItemMetasSpecialsBloc()
    : super(AwesomeShopItemMetasBloc.awesomeShopApi.loadSpecialMetas);
}

final class AwesomeShopItemMetasCustomizerBloc
    extends AwesomeShopItemMetasBloc {
  AwesomeShopItemMetasCustomizerBloc()
    : super(AwesomeShopItemMetasBloc.awesomeShopApi.loadCustomizerMetas);
}

final class AwesomeShopItemMetasEquipmentBloc extends AwesomeShopItemMetasBloc {
  AwesomeShopItemMetasEquipmentBloc()
    : super(AwesomeShopItemMetasBloc.awesomeShopApi.loadEquipmentMetas);
}
