part of 'cubit.dart';

@visibleForTesting
// ignore: prefer-correct-type-name, for testing.
base mixin TestLanguageOptionHydratedValueCubitMixin
    implements LanguageOptionHydratedValueCubit {}

final class LanguageOptionHydratedValueCubit
    extends HydratedValueCubit<LanguageOption> {
  LanguageOptionHydratedValueCubit() : super(LanguageOption.system);

  @override
  LanguageOption? fromJson(Map<String, dynamic> json) =>
      LanguageOption.values.byName(json['option'] as String);

  @override
  Map<String, dynamic>? toJson(LanguageOption option) => {
    'option': option.name,
  };
}
