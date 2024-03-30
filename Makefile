l10n:
	flutter gen-l10n

assets:
	flutter packages pub run build_runner build

generate:
	flutter packages pub run build_runner build

.PHONY: l10n assets generate
