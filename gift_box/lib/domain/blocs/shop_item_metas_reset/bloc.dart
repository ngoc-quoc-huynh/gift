import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gift_box/injector.dart';

part 'event.dart';
part 'state.dart';

final class ShopItemMetasResetBloc
    extends Bloc<ShopItemMetasResetEvent, ShopItemMetasResetState> {
  ShopItemMetasResetBloc() : super(const ShopItemMetasResetInProgress()) {
    on<ShopItemMetasResetInitializeEvent>(
      _onShopItemMetasResetInitializeEvent,
      transformer: droppable(),
    );
  }

  static final _shopApi = Injector.instance.shopApi;

  Future<void> _onShopItemMetasResetInitializeEvent(
    ShopItemMetasResetInitializeEvent event,
    Emitter<ShopItemMetasResetState> emit,
  ) async {
    emit(const ShopItemMetasResetInProgress());
    await _shopApi.resetPurchasedItems();
    emit(const ShopItemMetasResetOnSuccess());
  }
}
