module MinitestRSpecMocksIntegration
  include RSpec::Mocks::ExampleMethods

  def before_setup
    RSpec::Mocks.setup
    super
  end

  def after_teardown
    super
    RSpec::Mocks.verify
  ensure
    RSpec::Mocks.teardown
  end
end

Minitest::Test.include(MinitestRSpecMocksIntegration)
