require "simplecov"
SimpleCov.start

Dir["./lib/**/*.rb"].each { |file| require file }

RSpec.configure do |config|
  config.disable_monkey_patching!
end
