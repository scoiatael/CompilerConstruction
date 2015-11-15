MAKE_LLVM=clang -S -emit-llvm

C_FILES=$(wildcard *.c)

TARGETS_LL=$(foreach var,$(C_FILES), $(addprefix $(basename $(var)),.ll))
TARGETS=$(TARGETS_LL)

TMP=tmp

ANALYSIS:=cfg

all: $(TARGETS)

%.ll : %.c
	$(MAKE_LLVM) $<

analysis-for-% : %.ll
	opt -analyze -dot-$(ANALYSIS) $<

opt-for-%: %.ll
	-mkdir $(TMP)
	opt -S $(OPT) -print-after-all $< 2>&1 | ruby -e ' \
p = [[]]; \
STDIN.each_line { |l| p.push([])  if l =~ /^\*\*\*/; p.last << l }; \
p.map { |a| a.join("") } .each.with_index { |a, i| File.write("$(TMP)/" + "#{ "%03d" %i}-nth-#{a.lines.first}.ll".gsub(/( |\/)/, "_"), a) }'


%.png : %.dot
	dot -Tpng $< > $@
	rm $<

noise:
	@echo $(C_FILES)
	@echo $(TARGETS)

clean:
	-rm -rf $(TMP)/
	-rm ./*.ll
	-rm ./*.png
	-rm ./*.dot
