MAKE_LLVM=clang -S -emit-llvm

C_FILES=$(wildcard *.c)

TARGETS_LL=$(foreach var,$(C_FILES), $(addprefix $(basename $(var)),.ll))
TARGETS=$(TARGETS_LL)

ANALYSIS:=cfg

all: $(TARGETS)

%.ll : %.c
	$(MAKE_LLVM) $<

analysis-for-% : %.ll
	opt -analyze -dot-$(ANALYSIS) $<

%.png : %.dot
	dot -Tpng $< > $@
	rm $<

noise:
	@echo $(C_FILES)
	@echo $(TARGETS)

clean:
	-rm ./*.ll
	-rm ./*.png
	-rm ./*.dot
