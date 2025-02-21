import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gift_box/domain/blocs/value/cubit.dart';
import 'package:gift_box/injector.dart';

class GiftHeader extends StatelessWidget {
  const GiftHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BoolCubit, bool>(
      builder: (context, isVisible) => Visibility.maintain(
        visible: isVisible,
        child: Text(
          Injector.instance.translations.pages.gift.openMe,
          style: Theme.of(context).textTheme.displayLarge,
        ),
      ),
    );
  }
}
