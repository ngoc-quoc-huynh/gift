import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gift_box/domain/models/awesome_shop_item_id.dart';
import 'package:gift_box/injector.dart';

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

  static final _awesomeShopApi = Injector.instance.awesomeShopApi;

  void _onPurchasedItemsInitializeEvent(
    PurchasedItemsInitializeEvent event,
    Emitter<PurchasedItemsState> emit,
  ) {
    final ids = _awesomeShopApi.loadPurchasedItemIds();
    emit(PurchasedItemsLoadOnSuccess(ids));
  }
}
