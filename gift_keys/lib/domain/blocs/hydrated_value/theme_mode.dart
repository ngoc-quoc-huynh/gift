part of 'cubit.dart';

final class ThemeModeHydratedValueCubit extends HydratedValueCubit<ThemeMode> {
  ThemeModeHydratedValueCubit() : super(ThemeMode.system);

  @override
  ThemeMode? fromJson(Map<String, dynamic> json) =>
      ThemeMode.values.byName(json['theme_mode'] as String);

  @override
  Map<String, dynamic>? toJson(ThemeMode themeMode) => {
    'theme_mode': themeMode.name,
  };
}
