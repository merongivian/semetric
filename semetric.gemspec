lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |spec|
  spec.name         = 'Semetric'
  spec.version      = '1.0.0'
  spec.date         = '2014-11-02'
  spec.summary      = 'Semetric gem'
  spec.description  = 'Ruby wrapper for the musicmetric API'
  spec.authors      = 'Jose Anasco (merongivian)'
  spec.email        = 'jose_anasco@hotmail.com'
  spec.homepage     = "https://github.com/merongivian/semetric"
  spec.license      = 'MIT'

  spec.files         =`git ls-files`.split($/)
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency 'faraday', '~> 0.9.0'
  spec.add_dependency "faraday_middleware-parse_oj", '0.3.0'
  spec.add_development_dependency "bundler"
  spec.add_development_dependency "rake", "~> 10.1"
  spec.add_development_dependency "rspec", "~> 3.1.0"
  spec.add_development_dependency "vcr", "~> 2.9.3"
  spec.add_development_dependency "webmock", "~> 1.20.4"
  spec.add_development_dependency "coveralls"
end
