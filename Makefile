l10n:
	flutter gen-l10n

assets:
	flutter packages pub run build_runner build

Phony: l10n assets
