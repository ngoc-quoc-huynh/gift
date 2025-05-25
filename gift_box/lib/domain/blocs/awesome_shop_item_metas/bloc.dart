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
