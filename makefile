build-script:
	lib/argbash -o gri gri.m4
build-doc:
	lib/argbash gri.m4  --type docopt --strip all > usage
build-completion:
	lib/argbash gri.m4  --type completion --strip all > autocomplete
build: build-script build-doc build-completion
release-asset:
	rm release.tar.gz
	tar -czf release.tar.gz gri autocomplete usage
release: build release-asset
