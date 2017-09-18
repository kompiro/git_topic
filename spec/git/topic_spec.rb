require 'spec_helper'

RSpec.describe Git::Topic do
  it 'has a version number' do
    expect(Git::Topic::VERSION).not_to be nil
  end
end
