l10n:
	flutter gen-l10n

assets:
	flutter packages pub run build_runner build

generate:
	flutter packages pub run build_runner build

pubupgrade:
	flutter pub upgrade

.PHONY: l10n assets generate pubupgrade
