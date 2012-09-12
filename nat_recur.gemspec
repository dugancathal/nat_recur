# -*- encoding: utf-8 -*-
require File.expand_path('../lib/nat_recur/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["TJ Taylor"]
  gem.email         = ["dugancathal@gmail.com"]
  gem.description   = %q{Natural Language Time Recurrence Parsing}
  gem.summary       = %q{A natural language time recurrence gem, shamelessy copying functionality and a lot of code from Tickle, by noactivityinc}
  gem.homepage      = "http://github.com/dugancathal/nat_recur"

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "nat_recur"
  gem.require_paths = ["lib"]
  gem.version       = NatRecur::VERSION

  #Dependencies
  gem.add_dependency "chronic", "~> 0.7"
  gem.add_dependency "activesupport", "~> 3.2"
  gem.add_development_dependency "rspec", "~> 2"
  gem.add_development_dependency "timecop", "~> 0.4"
end
