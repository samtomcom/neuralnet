
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "neuralnet/version"

Gem::Specification.new do |spec|
  spec.name          = "neuralnet"
  spec.version       = Neuralnet::VERSION
  spec.authors       = ["samtomcom"]
  spec.email         = ["sam.comer@gmail.com"]

  spec.summary       = "A barebones Artificial Neural Network framework"
  spec.homepage      = "https://github.com/samtomcom/neuralnet"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end

  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.16"
  spec.add_development_dependency "rake", "~> 13.0"
end
