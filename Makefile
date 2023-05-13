SRC_DIR   = ./src
BUILD_DIR = ./build
VCD_DIR   = ./waveforms
PNG_DIR   = ./diagrams

TBFILES   = $(wildcard $(SRC_DIR)/*_tb.sv)
MODULES   = $(subst _tb,,$(notdir $(basename $(TBFILES))))
WAVEFORMS = $(addprefix $(VCD_DIR)/,$(addsuffix .vcd, $(MODULES)))

VLOG = vlog
VSIM = vsim

VLOG_FLAGS = +acc -work build -quiet
VSIM_FLAGS = -c -work build -quiet

define highlight
    $(1) | awk '/^# \[PASS\]/ {print "\033[30;42m" $$0 "\033[0m"} /^# \[FAIL\]/ {print "\033[30;41m" $$0 "\033[0m"} !/^# \[(PASS|FAIL)\]/ {print}'
endef

all: $(WAVEFORMS)

$(VCD_DIR)/%.vcd: $(SRC_DIR)/%_tb.sv
	$(VLOG) $(VLOG_FLAGS) $(SRC_DIR)/$*.sv $<
	$(call highlight, $(VSIM) $(VSIM_FLAGS) $*_tb -do "vcd file $(VCD_DIR)/$(*).vcd; vcd add -r *; run -all")

.PHONY: clean

clean:
	-rm -f $(WAVEFORMS) $(DIAGRAMS:.png=.ps)
	-rm -rf $(BUILD_DIR)/* transcript
