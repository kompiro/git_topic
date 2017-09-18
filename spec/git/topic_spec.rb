require 'spec_helper'

RSpec.describe Git::Topic do
  it 'has a version number' do
    expect(Git::Topic::VERSION).not_to be nil
  end

  it 'does something useful' do
    expect(false).to eq(true)
  end
end
