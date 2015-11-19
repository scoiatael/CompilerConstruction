FLEX=flex

tokenizer : tokenizer.yy
		${FLEX} -o tokenizer.yy.c tokenizer.yy
	  ${CC} -o tokenizer tokenizer.yy.c
		rm tokenizer.yy.c
