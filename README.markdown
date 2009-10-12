# rake-tester #

<http://www.github.com/karottenreibe/rake-tester>

An extension of the [rake-compiler][rakecompiler] that allows
for automatic compilation of C test suites, e.g. using
[cmockery].


## Features/Limitations ##

*   Automatically compiles and executes test suites of
    arbitrary C testing frameworks
*   Can batch-execute all suites or selectively run a single suite
*   Can only compile the tests for your current platform
*   Thus, no cross compilation of the tests
*   Support for running the tests with valgrind


## Installation ##

    gem install karottenreibe-rake-tester --source http://gems.github.com
    gem install rake-tester


## Usage ##

In the Rakefile:

    require 'rake/extensiontask'
    require 'rake/extensiontesttask'

    Rake::ExtensionTask.new(...) do |ext|
        # ... confgure as normal

        ext.test_files          = FileList['test/c/*']
        ext.test_includes       << '/usr/include/frood_stuff'
        ext.test_libraries      << 'zaphods_heads'
        ext.test_lib_folders    << '/usr/lib/floopy'
    end

Write your tests.

To test everything:

    $ rake test:c

To test one extension:

    $ rake test:c:extension

To execute one test file:

    $ rake test:c:extension[test_feature]

To use valgrind:

    $ rake test:valgrind:extension[test_feature]


## License ##

    Copyright (c) 2009 Fabian Streitel

    Permission is hereby granted, free of charge, to any person
    obtaining a copy of this software and associated documentation
    files (the "Software"), to deal in the Software without
    restriction, including without limitation the rights to use,
    copy, modify, merge, publish, distribute, sublicense, and/or sell
    copies of the Software, and to permit persons to whom the
    Software is furnished to do so, subject to the following
    conditions:

    The above copyright notice and this permission notice shall be
    included in all copies or substantial portions of the Software.

    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
    EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
    OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
    NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
    HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
    WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
    FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
    OTHER DEALINGS IN THE SOFTWARE.

[rakecompiler]:     http://github.com/luislavena/rake-compiler      "The rake-compile project"
[cmockery]:         http://code.google.com/p/cmockery/              "The cmockery C testing framework"

