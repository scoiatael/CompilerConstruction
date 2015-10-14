MAKE_LLVM=clang -S -emit-llvm

C_FILES=$(wildcard *.c)

TARGETS=$(foreach var,$(C_FILES), $(addprefix $(basename $(var)),.ll))

all: $(TARGETS)

%.ll : %.c
	$(MAKE_LLVM) $<

noise:
	@echo $(C_FILES)
	@echo $(TARGETS)

clean:
	-rm ./*.ll
