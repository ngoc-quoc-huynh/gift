.PHONY: i18n check-i18n check-code check-files style test test-unit test-ui update-goldens launcher-icon splash-screen skin apk jks encode-jks

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
	flutter test test/ui --coverage --test-randomize-ordering-seed=$(or $(seed),random) $(ci_test)
	dart run test_cov_console --exclude=static,domain,infrastructure,injector.dart

update-goldens:
	flutter test --update-goldens --tags=golden  $(ci_test)

launcher-icon:
	@$(MAKE) check-color
	cp assets/skins/launcher_icon/android/$(color).png assets/launcher_icon/android.png
	cp assets/skins/launcher_icon/ios/$(color).png assets/launcher_icon/ios.png
	cp assets/skins/launcher_icon/app/$(color).webp assets/images/launcher_icon.webp
	dart run flutter_launcher_icons --file launcher_icon.yaml

splash-screen:
	@$(MAKE) check-color
	cp assets/skins/splash_screen/android_12/$(color).png assets/splash_screen/android_12.png
	cp assets/skins/splash_screen/image/$(color).png assets/splash_screen/image.png
	dart run flutter_native_splash:create --path=splash_screen.yaml

skin:
	@$(MAKE) check-color
	cp assets/skins/launcher_icon/app/$(color).webp assets/launcher_icon.webp
	@$(MAKE) launcher-icon
	@$(MAKE) splash-screen

check-color:
	@if ! echo "blue green purple red" | grep -wq "$(color)"; then \
        printf "Error: Please provide a correct color."; \
        printf "\nAllowed colors: blue, green, purple, red.\n\n"; \
        exit 1; \
    fi; \

apk:
	flutter build apk \
		--release \
		--obfuscate \
		--split-debug-info=./build/app/outputs/symbols \
		--target-platform android-arm64

jks:
	keytool -genkey -v -keystore android/app/gift_box.jks -keyalg RSA -keysize 2048 -validity 10000 -alias gift_box

encode-jks:
	base64 -i android/app/gift_keys.jks -w 0
