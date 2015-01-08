.PHONY: test clean

test-exercise:
	@$(MAKE) -C test $@

test-interpreter:
	@$(MAKE) -C test $@

clean:
	@$(MAKE) -C test $@
	@$(MAKE) -C interpreter $@
