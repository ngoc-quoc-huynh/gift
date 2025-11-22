import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gift_box_satisfactory/domain/models/shop_item_id.dart';
import 'package:gift_box_satisfactory/injector.dart';

part 'event.dart';
part 'state.dart';

final class PurchasedItemsBloc
    extends Bloc<PurchasedItemsEvent, PurchasedItemsState> {
  PurchasedItemsBloc() : super(const PurchasedItemsLoadInProgress()) {
    on<PurchasedItemsInitializeEvent>(
      _onPurchasedItemsInitializeEvent,
      transformer: droppable(),
    );
  }

  static final _shopApi = Injector.instance.shopApi;

  Future<void> _onPurchasedItemsInitializeEvent(
    PurchasedItemsInitializeEvent event,
    Emitter<PurchasedItemsState> emit,
  ) async {
    final ids = await _shopApi.loadPurchasedItemIds();
    emit(PurchasedItemsLoadOnSuccess(ids));
  }
}
