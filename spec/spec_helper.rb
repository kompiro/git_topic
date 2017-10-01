# frozen_string_literal: true

require 'bundler/setup'
require 'git_topic'
require 'pry'

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = '.rspec_status'

  # Disable RSpec exposing methods globally on `Module` and `main`
  # config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  config.define_derived_metadata do |meta|
    meta[:aggregate_failures] = true
  end
end

def setup_command(command, output)
  stdout = StringIO.new(output)
  allow(Open3).to receive(:popen3)
    .with(command).and_return([nil, stdout, nil, nil])
end
