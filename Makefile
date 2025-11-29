VERSION_STRING := unknown
DEV_BUILD := @true
GIT_COMMIT_HASH := $(git rev-parse --short=7 HEAD)
GIT_TAG := $(git rev-list --tags --max-count=1)

ifneq ($(filter fatal:%,$(GIT_COMMIT_HASH)),)
	ifneq (GIT_TAG,"")
		VERSION_STRING = $(GIT_TAG).$(GIT_COMMIT_HASH)
	else
		VERSION_STRING = dev.$(GIT_COMMIT_HASH)
	endif
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
	tar -cf $(BUILD_ARTIFACT_NAME) package/
	$(info Plasmoid built: $(VERSION_STRING): $(BUILD_ARTIFACT_NAME))

clean_build: clean build

clean:
	-rm $(BUILD_ARTIFACT_NAME) 2>/dev/null
	$(info Cleaned build artifact)

install:
	$(info Installing Plasmoid...)
	kpackagetool6 -i $(BUILD_ARTIFACT_NAME)
	$(info Plasmoid installed)

uninstall:
	$(info Uninstalling Plasmoid...)
	kpackagetool6 -r lilyvex.neotasks
	$(info Plasmoid uninstalled)
