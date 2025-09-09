LIBNAME = ui

PACKAGE_NAME = $(LIBNAME)lib.zip

ifeq ($(OS),Windows_NT)
	CP = xcopy /y /-y /s /e
	MV = move /y /-y
	RM = del /q /s
else
	CP = cp -rf
	MV = mv -f
	RM = rm -rf
endif

BUILD_DIR = build

RBXM_BUILD = $(LIBNAME)lib.rbxm

SOURCES =	\
	src/init.luau	\
	src/slider.lua	\
	src/switch.lua	\
	src/tabs.lua	\
	src/checkbox.lua	\
	src/defaultSwitch.lua	\
	src/DropDownList.lua	\
	src/window/window.lua	\
	src/window/skin.lua

TEST_POSTFIX = client.lua

TESTS_SOURCES =	tests/dropdownList.$(TEST_POSTFIX)

$(BUILD_DIR): 
	mkdir $@

wallyInstall:	wally.toml
	wally install
	rojo sourcemap tests.project.json --output sourcemap.json

wally.lock:	wallyInstall

./Packages:	wallyInstall
	-wally-package-types --sourcemap sourcemap.json $@
	


configure:	clean-build $(BUILD_DIR)	wally.toml	$(SOURCES)
	$(CP) src/* $(BUILD_DIR)
	$(CP) wally.toml build/

$(PACKAGE_NAME): configure	$(SOURCES)
	wally package --output $@ --project-path $(BUILD_DIR)

package: $(PACKAGE_NAME)
	

publish: configure	$(SOURCES)
	wally publish --project-path $(BUILD_DIR)

lint:
	selene src/ tests/

$(RBXM_BUILD):	library.project.json	$(SOURCES)
	rojo build library.project.json --output $@

rbxm: clean-rbxm $(RBXM_BUILD)

tests.rbxl:	./Packages	tests.project.json	$(SOURCES)	$(TESTS_SOURCES)
	rojo build tests.project.json --output $@

tests:	clean-tests	tests.rbxl

sourcemap.json:	./Packages	tests.project.json
	rojo sourcemap tests.project.json --output $@

# Re gen sourcemap
sourcemap:	clean-sourcemap	sourcemap.json


clean-sourcemap: 
	$(RM) sourcemap.json

clean-rbxm:
	$(RM) $(RBXM_BUILD)

clean-tests:
	$(RM) tests.rbxl

clean-build:
	$(RM) $(BUILD_DIR)

clean:	clean-tests	clean-build	clean-rbxm
	$(RM) $(PACKAGE_NAME) ourcemap.json: ./Packages
	rojo sourcemap tests.project.json --output $@
