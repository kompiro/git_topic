require 'spec_helper'

RSpec.describe GitTopic::Commands::List do
  subject(:command) { described_class.new }

  it { is_expected.to be_truthy }

  describe '#execute' do
    def setup_git_branch
      stdout = instance_double(IO)
      info = '* master  cc72152 :memo: Note about overcommit when release'
      allow(stdout).to receive(:each).and_yield(info)
      allow(stdout).to receive(:eof?).and_return(false)
      allow(Open3).to receive(:popen3)
        .with('git branch -v').and_return([nil, stdout, nil, nil])
    end

    def setup_git_config
      stdout = instance_double(IO)
      allow(stdout).to receive(:readline).and_return('mainline')
      allow(stdout).to receive(:eof?).and_return(false)
      allow(Open3).to receive(:popen3)
        .with('git config branch.master.description')
        .and_return([nil, stdout, nil, nil])
    end

    before do
      setup_git_branch
      setup_git_config
    end

    subject(:executed) { command.execute }

    it { expect { executed } .to output(/Branch\s+Rev\s+Summary/).to_stdout }
    it { expect { executed } .to output(/\*.*master.*mainline/).to_stdout }
  end
end
