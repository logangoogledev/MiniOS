NASM := nasm
QEMU := qemu-system-x86_64
BUILD_DIR := build
BOOT_SRC := boot/boot.asm
BOOT_IMG := $(BUILD_DIR)/boot.img

.PHONY: all run ephemeral clean purge setup

all: $(BOOT_IMG)

$(BUILD_DIR):
	mkdir -p $(BUILD_DIR)

$(BOOT_IMG): $(BOOT_SRC) | $(BUILD_DIR)
	$(NASM) -f bin $(BOOT_SRC) -o $(BOOT_IMG)

run: all
	$(QEMU) -fda $(BOOT_IMG) -boot a -m 64M

# Create build artifacts in a temporary dir and remove them when QEMU exits
ephemeral:
	tmpdir=$$(mktemp -d /tmp/minios-XXXX) && \
	$(NASM) -f bin $(BOOT_SRC) -o $$tmpdir/boot.img && \
	$(QEMU) -fda $$tmpdir/boot.img -boot a -m 64M; \
	rm -rf $$tmpdir

clean:
	rm -f $(BUILD_DIR)/*

purge:
	rm -rf $(BUILD_DIR)

setup:
	@echo "Prerequisites: $(NASM), $(QEMU). Install with your package manager (e.g., apt install nasm qemu-system-x86)."