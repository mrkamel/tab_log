
$:.push File.expand_path("../lib", __FILE__)
require "tab_log/version"

Gem::Specification.new do |s|
  s.name        = "tab_log"
  s.version     = TabLog::VERSION
  s.authors     = ["Benjamin Vetter"]
  s.email       = ["vetter@flakks.com"]
  s.homepage    = ""
  s.summary     = %q{Active Record alike tab delimited logs}
  s.description = %q{Write to tab delimited logs with an Active Record alike interface}

  s.rubyforge_project = "tab_log"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_development_dependency "rake"
end

