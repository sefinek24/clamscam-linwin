.PHONY: all
TESTS = tests/index.js

all:
	@npm install

test-linux: all
	@mkdir -p tests/infected
	@mkdir -p tests/bad_scan_dir
	@mkdir -p tests/mixed_scan_dir/folder1
	@mkdir -p tests/mixed_scan_dir/folder2
	@touch tests/clamscan-log
	@./node_modules/.bin/mocha --exit --trace-warnings --trace-deprecation --retries 1 --full-trace --timeout 5000 --check-leaks --reporter spec $(TESTS)

test-win: all
	@if not exist "tests\infected" md "tests\infected"
	@if not exist "tests\bad_scan_dir" md "tests\bad_scan_dir"
	@if not exist "tests\mixed_scan_dir\folder1" md "tests\mixed_scan_dir\folder1"
	@if not exist "tests\mixed_scan_dir\folder2" md "tests\mixed_scan_dir\folder2"
	@if not exist "tests\clamscan-log" type nul > "tests\clamscan-log"
	@.\node_modules\.bin\mocha --exit --trace-warnings --trace-deprecation --retries 1 --full-trace --timeout 5000 --check-leaks --reporter spec $(TESTS)

clean:
	rm -rf node_modules
