MAKE_LLVM=clang -S -emit-llvm

C_FILES=$(wildcard *.c)

TARGETS_LL=$(foreach var,$(C_FILES), $(addprefix $(basename $(var)),.ll))
TARGETS_PNG=$(foreach var,$(C_FILES), $(addprefix $(basename $(var)),.png))
TARGETS=$(TARGETS_LL) $(TARGETS_PNG)

all: $(TARGETS)

%.ll : %.c
	$(MAKE_LLVM) $<

%.png : %.ll
	opt -analyze -dot-callgraph $<
	dot -Tpng callgraph.dot > $@
	rm callgraph.dot

noise:
	@echo $(C_FILES)
	@echo $(TARGETS)

clean:
	-rm ./*.ll
	-rm ./*.png
