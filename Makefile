SRC_DIR := src
ROOT_DIR := $(SRC_DIR)/root
INCLUDE_DIR := $(SRC_DIR)/include

PACK_NAME ?= $(shell cat pack-name)
PACK_NAME := $(PACK_NAME)-pack
PACK_NAME_ZIP := $(PACK_NAME).zip

M4 := m4
M4_DIR := m4
M4_FLAGS := -I$(INCLUDE_DIR)
M4_FILES := $(shell find $(M4_DIR) -type f -name "*.m4")

ZIP := zip
ZIP_FLAGS := -r

SOURCES = $(shell find $(ROOT_DIR) -type f -name "*.glsl" -o -name "*.fsh" -o -name "*.frag" -o -name "*.vsh" -o -name "*.vert")
OBJECTS = $(patsubst $(ROOT_DIR)/%,$(PACK_NAME)/%,$(SOURCES))

MINECRAFT_DIR ?= ~/.minecraft
RESOURCEPACKS_DIR := $(MINECRAFT_DIR)/resourcepacks

pack: clean pack-dir $(OBJECTS) clone-assets zip

pack-dir:
	mkdir $(PACK_NAME)

clean:
	-rm -rf $(PACK_NAME)
	-rm -rf $(PACK_NAME_ZIP)

$(PACK_NAME)/%: $(ROOT_DIR)/%
	-mkdir -p $(@D)
	$(M4) $(M4_FLAGS) $(M4_FILES) $< > $@

clone-assets:
	cp -rn $(ROOT_DIR)/* $(PACK_NAME)

zip:
	(cd $(PACK_NAME); $(ZIP) $(ZIP_FLAGS) ../$(PACK_NAME_ZIP) *)

install: pack
	cp $(PACK_NAME_ZIP) $(RESOURCEPACKS_DIR)
