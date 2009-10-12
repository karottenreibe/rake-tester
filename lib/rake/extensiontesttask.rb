require 'rake/clean'
require 'rake/extensiontask'

module Rake
    class ExtensionTask
        attr_accessor :test_files
        attr_accessor :test_includes

        def test_link( library, path )
            @test_libraries   << library
            @test_lib_folders << path
        end

        alias_method :initialize_old, :initialize

        def initialize( *args, &block )
            @test_files       = Array.new
            @test_includes    = Array.new
            @test_libraries   = Array.new
            @test_lib_folders = Array.new

            initialize_old(*args, &block)

            # some stuff we need often later on
            compile_dir   = "#{@tmp_dir}/test"
            compile_task  = "compile:#{@name}:test"
            test_task     = "test:c:#{@name}"
            valgrind_task = "test:valgrind:#{@name}"

            directory compile_dir

            desc "Compile #{@name} tests"
            task compile_task => ["compile:#{@name}", compile_dir] do
                # copy the test files into the compilation folder
                @test_files.each { |file| cp file, compile_dir }

                # start compilation
                chdir(compile_dir) do
                    includes = (@test_includes + [
                        ".",
                        "../../#{@ext_dir}",
                        "/usr/include/ruby-#{RUBY_VERSION}",
                        "/usr/include/ruby-#{RUBY_VERSION}/#{RUBY_PLATFORM}",
                    ]).join(' -I')

                    # compile the test sources
                    FileList['*.c'].each do |cfile|
                        sh "gcc -g #{includes} -c #{cfile}"
                    end

                    source_objects = FileList["../#{RUBY_PLATFORM}/#{@name}/#{RUBY_VERSION}/*.o"]
                    libraries      = (@test_libraries + %w{ruby pthread crypto}).join(' -l')
                    lib_folders    = (@test_lib_folders + %w{/usr/lib .}).join(' -L')

                    # link the executables
                    FileList['*.o'].each do |ofile|
                        sh "gcc -g #{lib_folders} #{libraries} #{source_objects} #{ofile} -o #{ofile.ext}"
                    end
                end
            end

            desc "Execute valgrind for a #{@name} test"
            task valgrind_task, :test, :needs => [compile_task] do |t,args|
                sh "valgrind --num-callers=50 --error-limit=no --partial-loads-ok=yes --undef-value-errors=no --leak-check=full #{compile_dir}/#{args.test}"
            end

            desc "Test #{@name}"
            task test_task, :test, :needs => [compile_task] do |t,args|
                if args.test
                    sh "#{compile_dir}/#{args.test}"
                else
                    FileList["#{compile_dir}/*.o"].each do |ofile|
                        sh "#{ofile.ext}"
                    end
                end
            end

            desc "Test all C extensions"
            task 'test:c' => [test_task]
        end
    end
end

