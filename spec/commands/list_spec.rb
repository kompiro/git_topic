require 'spec_helper'

RSpec.describe GitTopic::Commands::List do
  subject(:command) { described_class.new }

  it { is_expected.to be_truthy }

  describe '#execute' do
    before do
      stdout = double(IO)
      allow(stdout).to receive(:each).and_yield('* master')
      allow(Open3).to receive(:popen3)
        .with('git branch').and_return([nil, stdout, nil, nil])

      desc_out = double(IO)
      allow(desc_out).to receive(:readline).and_return('mainline')
      allow(Open3).to receive(:popen3)
        .with('git config branch.master.description')
        .and_return([nil, desc_out, nil, nil])
    end

    subject { command.execute }
    it { expect { subject } .to output(/mainline/).to_stdout }
    it { expect { subject } .to output(/Branch/).to_stdout }
    it { expect { subject } .to output(/Summary/).to_stdout }
  end
end
