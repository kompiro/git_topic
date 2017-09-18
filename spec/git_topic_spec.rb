require 'spec_helper'

RSpec.describe GitTopic do
  it 'has a version number' do
    expect(GitTopic::VERSION).not_to be nil
  end
end
