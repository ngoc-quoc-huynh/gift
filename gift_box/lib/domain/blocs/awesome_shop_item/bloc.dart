import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gift_box/domain/models/awesome_shop_item.dart';
import 'package:gift_box/injector.dart';

part 'event.dart';
part 'state.dart';

final class AwesomeShopItemBloc
    extends Bloc<AwesomeShopItemEvent, AwesomeShopItemState> {
  AwesomeShopItemBloc() : super(const AwesomeShopItemLoadInProgress()) {
    on<AwesomeShopItemInitializeEvent>(
      _onAwesomeShopItemInitializeEvent,
      transformer: droppable(),
    );
  }

  static final _awesomeShopApi = Injector.instance.awesomeShopApi;

  Future<void> _onAwesomeShopItemInitializeEvent(
    AwesomeShopItemInitializeEvent event,
    Emitter<AwesomeShopItemState> emit,
  ) async {
    final item = await _awesomeShopApi.loadItem(event.id);
    emit(AwesomeShopItemLoadOnSuccess(item));
  }
}
