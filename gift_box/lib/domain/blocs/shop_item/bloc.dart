import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gift_box/domain/models/shop_item.dart';
import 'package:gift_box/injector.dart';

part 'event.dart';
part 'state.dart';

final class ShopItemBloc extends Bloc<ShopItemEvent, ShopItemState> {
  ShopItemBloc() : super(const ShopItemLoadInProgress()) {
    on<ShopItemInitializeEvent>(
      _onShopItemInitializeEvent,
      transformer: droppable(),
    );
  }

  static final _shopApi = Injector.instance.shopApi;

  Future<void> _onShopItemInitializeEvent(
    ShopItemInitializeEvent event,
    Emitter<ShopItemState> emit,
  ) async {
    final item = await _shopApi.loadItem(event.id);
    emit(ShopItemLoadOnSuccess(item));
  }
}
