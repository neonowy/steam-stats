# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'steam_stats/version'

Gem::Specification.new do |spec|
  spec.name          = 'steam_stats'
  spec.version       = SteamStats::VERSION
  spec.authors       = ['Krzysztof Zbudniewek']
  spec.email         = ['krzysztof.zbudniewek@gmail.com']
  spec.summary       = %q{Get players' games stats from Ruby.}
  spec.homepage      = 'https://github.com/neonowy/steam-stats'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.7'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'webmock'

  spec.add_dependency "nokogiri"
end
