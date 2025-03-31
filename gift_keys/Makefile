.PHONY: i18n check-i18n check-code check-files style test test-unit test-ui update-goldens launcher-icon splash-screen

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
	flutter test --coverage --test-randomize-ordering-seed=$(or $(seed),random)
	dart run test_cov_console --exclude=static,domain/interfaces,injector.dart

test-unit:
	flutter test test/domain test/infrastructure --coverage --test-randomize-ordering-seed=$(or $(seed),random)
	dart run test_cov_console --exclude=static,ui,domain/interfaces,injector.dart

test-ui:
	flutter test test/ui --coverage --test-randomize-ordering-seed=$(or $(seed),random)
	dart run test_cov_console --exclude=static,domain,infrastructure,injector.dart


update-goldens:
	flutter test --update-goldens --tags=golden


launcher-icon:
	dart run flutter_launcher_icons --file launcher_icon.yaml

splash-screen:
	dart run flutter_native_splash:create --path=splash_screen.yaml
