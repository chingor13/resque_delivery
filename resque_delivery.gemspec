Gem::Specification.new do |gem|
  gem.name = %q{resque_delivery}
  gem.authors = ["Jeff Ching"]
  gem.date = %q{2012-10-15}
  gem.description = %q{With ResqueDelivery, you can send ActionMailer messages asynchronously with Resque.}
  gem.summary = "Basic asynchronous ActionMailer delivery through Resque."
  gem.email = %q{ching.jeff@gmail.com}
  gem.homepage = 'http://github.com/chingor13/resque_delivery'

  gem.add_runtime_dependency 'actionmailer', '~> 3.0'

  gem.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  gem.files         = `git ls-files`.split("\n")
  gem.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  gem.name          = "resque_delivery"
  gem.require_paths = ['lib']
  gem.version       = "0.0.1"
end
