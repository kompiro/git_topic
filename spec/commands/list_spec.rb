require 'spec_helper'

RSpec.describe GitTopic::Commands::List do
  subject(:command) { described_class.new }

  it { is_expected.to be_truthy }

  describe '#execute' do
    subject { command.execute }
    it { expect { subject } .to output(/master/).to_stdout }
  end
end
