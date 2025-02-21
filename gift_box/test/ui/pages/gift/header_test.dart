import 'package:alchemist/alchemist.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gift_box/domain/blocs/value/cubit.dart';
import 'package:gift_box/injector.dart';
import 'package:gift_box/ui/pages/gift/header.dart';

Future<void> main() async {
  setUpAll(
    () => Injector.instance
        .registerSingleton<Translations>(AppLocale.en.buildSync()),
  );

  tearDownAll(Injector.instance.unregister<Translations>);

  await goldenTest(
    'renders correctly.',
    fileName: 'header',
    builder: () => GoldenTestGroup(
      children: [
        GoldenTestScenario(
          name: 'Invisible',
          child: BlocProvider<BoolCubit>(
            create: (_) => BoolCubit(false),
            child: const GiftHeader(),
          ),
        ),
        GoldenTestScenario(
          name: 'Visible',
          child: BlocProvider<BoolCubit>(
            create: (_) => BoolCubit(true),
            child: const GiftHeader(),
          ),
        ),
      ],
    ),
  );
}
