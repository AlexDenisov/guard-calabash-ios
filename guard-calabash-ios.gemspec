# -*- encoding: utf-8 -*-
require File.expand_path('../lib/guard/calabash-ios/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Alex Denisov"]
  gem.email         = ["1101.debian@gmail.com"]
  gem.description   = %q{Guard::Calabash-iOS automatically run your calabash features for iOS }
  gem.summary       = %q{Guard gem for calabash-ios}
  gem.homepage      = "https://github.com/AlexDenisov/guard-calabash-ios"
  gem.files         = Dir.glob('{lib}/**/*') + %w[LICENSE README.md]
 # gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
 # gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "guard-calabash-ios"
  gem.require_paths = ["lib"]
  gem.version       = Guard::CalabashiOSVersion::VERSION
  gem.add_dependency 'guard', '<1.1.0'
  gem.add_dependency 'calabash-cucumber', '>= 0.9.48'
  gem.required_ruby_version     = '>= 1.8.7'
  gem.required_rubygems_version = '>= 1.3.6'
  gem.post_install_message = %{
    See https://github.com/AlexDenisov/guard-calabash-ios#readme for more details
  }
end
