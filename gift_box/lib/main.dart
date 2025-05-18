import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:gift_box/domain/blocs/hydrated_value/cubit.dart';
import 'package:gift_box/injector.dart';
import 'package:gift_box/static/resources/theme.dart';
import 'package:gift_box/ui/router/config.dart';
import 'package:rive_native/rive_native.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Future.wait([Injector.setupDependencies(), RiveNative.init()]);
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<HydratedBoolCubit>(
      create:
          (_) => HydratedBoolCubit(
            initialState: false,
            storageKey: 'has_opened_gift',
          ),
      child: const _Body(),
    );
  }
}

class _Body extends StatefulWidget {
  const _Body();

  @override
  State<_Body> createState() => _BodyState();
}

class _BodyState extends State<_Body> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: Injector.instance.translations.appName,
      theme: CustomTheme.light,
      darkTheme: CustomTheme.dark,
      locale: Injector.instance.translations.$meta.locale.flutterLocale,
      supportedLocales: AppLocaleUtils.supportedLocales,
      localizationsDelegates: GlobalMaterialLocalizations.delegates,
      routerConfig: GoRouterConfig.build(
        hasOpenedGift: context.read<HydratedBoolCubit>().state,
      ),
    );
  }
}
