part of 'cubit.dart';

final class LanguageOptionHydratedValueCubit
    extends HydratedValueCubit<LanguageOption> {
  LanguageOptionHydratedValueCubit(super.state);

  @override
  LanguageOption? fromJson(Map<String, dynamic> json) =>
      LanguageOption.values.byName(json['option'] as String);

  @override
  Map<String, dynamic>? toJson(LanguageOption option) => {
    'option': option.name,
  };
}
