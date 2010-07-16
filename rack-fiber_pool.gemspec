version = File.read("VERSION").strip

Gem::Specification.new do |s|
  s.name        = 'rack-fiber_pool'
  s.version     = version
  s.platform    = Gem::Platform::RUBY
  s.summary     = "Rack middleware to execute each request in a Fiber"
  s.description = "Rack middleware to execute each request in a Fiber"
  
  s.authors     = ["Mike Perham"]
  s.email       = ["mperham@gmail.com"]
  s.homepage    = "http://github.com/mperham/rack-fiber_pool"

  s.files        = Dir['README.md', 'VERSION', 'lib/**/*']
  s.require_path = 'lib'
end
