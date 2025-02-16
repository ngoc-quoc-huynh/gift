.PHONY: i18n check-i18n check-code check-files style test test-unit test-ui update-goldens splash-screen

ci_test := $(if $(findstring ci,$(MAKECMDGOALS)),--dart-define=CI=true,)

ci:
	@true

i18n:
	dart run slang

check-i18n:
	dart run slang analyze

check-code:
	dart run dart_code_linter:metrics check-unused-code lib

check-files:
	dart run dart_code_linter:metrics check-unused-files lib

style:
	dart format lib
	flutter analyze
	dart run dart_code_linter:metrics analyze . --set-exit-on-violation-level=warning

test:
	flutter test --coverage --test-randomize-ordering-seed=$(or $(seed),random) $(ci_test)
	dart run test_cov_console --exclude=static,domain/interfaces,injector.dart

test-unit:
	flutter test test/domain test/infrastructure --coverage --test-randomize-ordering-seed=$(or $(seed),random)
	dart run test_cov_console --exclude=static,ui,domain/interfaces,injector.dart

test-ui:
	@$(eval MAKEFLAGS:=$(filter-out ci,$(MAKEFLAGS)))
	flutter test test/ui --coverage --test-randomize-ordering-seed=$(or $(seed),random) $(ci_test)
	dart run test_cov_console --exclude=static,domain,infrastructure,injector.dart


update-goldens:
	flutter test --update-goldens --tags=golden  $(ci_test)

splash-screen:
	dart run flutter_native_splash:create --path=splash_screen.yaml
