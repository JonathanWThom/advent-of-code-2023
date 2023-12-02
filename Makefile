.SILENT: test
.PHONY: test

test:
	find . -type f -name '*_test.rb' | xargs ruby
