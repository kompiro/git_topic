require "spec_helper"

RSpec.describe Git::Topics do
  it "has a version number" do
    expect(Git::Topics::VERSION).not_to be nil
  end

  it "does something useful" do
    expect(false).to eq(true)
  end
end
