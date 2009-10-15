
task :release do
    sh "vim HISTORY.markdown"
    sh "vim README.markdown"
    sh "git commit -a -m 'prerelease adjustments'; true"
end

require 'jeweler'
jeweler_tasks = Jeweler::Tasks.new do |gem|
    gem.name                = 'rake-tester'
    gem.summary             = 'rake-tester is an extension to the rake-compiler that maintains C test suites'
    gem.description         = gem.summary
    gem.email               = 'karottenreibe@gmail.com'
    gem.homepage            = 'http://github.com/karottenreibe/rake-tester'
    gem.authors             = ['Fabian Streitel']
    gem.rubyforge_project   = 'k-gems'
end

Jeweler::RubyforgeTasks.new
Jeweler::GemcutterTasks.new


require 'rake/rdoctask'
Rake::RDocTask.new do |rdoc|
    rdoc.rdoc_dir = 'rdoc'
    rdoc.title = 'Joker'
    rdoc.rdoc_files.include('lib/**/*.rb')
    rdoc.rdoc_files.include('ext/**/*.rb')
end

