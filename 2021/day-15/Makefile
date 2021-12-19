TARGETS = $(patsubst %.c, %.so, $(shell find -type f -iname *.c))

main: test
test: $(TARGETS)
	Rscript "test.R"

$(TARGETS): %.so: %.c
	R CMD SHLIB -o $@ $<

