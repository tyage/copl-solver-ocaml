.PHONY: test clean

test:
	@$(MAKE) test-exercise
	@$(MAKE) test-interpreter

test-exercise:
	@$(MAKE) -C test $@

test-interpreter:
	@$(MAKE) -C test $@

clean:
	@$(MAKE) -C test $@
	@$(MAKE) -C interpreter $@
