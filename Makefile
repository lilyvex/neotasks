VERSION_STRING := unknown
DEV_BUILD := @true
GIT_COMMIT_HASH := $(shell git rev-parse --short=7 HEAD)
GIT_TAG := $(shell git rev-list --tags --max-count=1)
GIT_BRANCH := $(shell git rev-parse --abbrev-ref HEAD)

ifneq ($(GIT_TAG),)
	VERSION_STRING = $(GIT_TAG).$(GIT_COMMIT_HASH)
else
	VERSION_STRING = $(GIT_BRANCH).$(GIT_COMMIT_HASH)
endif

ifeq ($(DEV_BUILD),@true)
	VERSION_STRING := $(VERSION_STRING)-dev
endif

ifndef VERBOSE
.SILENT:
endif

BUILD_ARTIFACT_NAME := neotasks-$(VERSION_STRING).tar.xz
build:
	$(info Building Plasmoid...)
	./package/contents/translate/localez -c package/contents/translate/localezconfig.toml build
	tar -cf $(BUILD_ARTIFACT_NAME) package/
	$(info Plasmoid built: $(VERSION_STRING): $(BUILD_ARTIFACT_NAME))

clean_build: clean build

clean:
	./package/contents/translate/localez -c package/contents/translate/localezconfig.toml clean
	rm *.tar.xz
	$(info Cleaned build artifacts)

update_locales:
	./package/contents/translate/localez -c package/contents/translate/localezconfig.toml merge
	$(info Updated locales)

install: build
	$(info Installing Plasmoid...)
	kpackagetool6 -t Plasma/Applet -i $(BUILD_ARTIFACT_NAME)
	$(info Plasmoid installed)

uninstall:
	$(info Uninstalling Plasmoid...)
	kpackagetool6 -t Plasma/Applet -r lilyvex.neotasks
	$(info Plasmoid uninstalled)
