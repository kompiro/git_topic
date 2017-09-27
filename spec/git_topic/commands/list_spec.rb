# frozen_string_literal: true

require 'spec_helper'

RSpec.describe GitTopic::Commands::List do
  subject(:command) { described_class.new }

  it { is_expected.to be_truthy }

  describe '#execute' do
    def setup_git_branch
      output = <<~OUT
        * master                 cc72152 :memo: Note about overcommit when release
          longlongnamebranchname 549db63 :up: Bump up development version
      OUT
      stdout = StringIO.new(output)
      allow(Open3).to receive(:popen3)
        .with('git branch -v').and_return([nil, stdout, nil, nil])
    end

    def setup_git_config
      setup_branch_description('master', 'mainline')
      setup_branch_description('longlongnamebranchname', 'long name branch')
    end

    def setup_branch_description(branch_name, description)
      stdout = instance_double(IO)
      allow(stdout).to receive(:readline).and_return(description)
      allow(stdout).to receive(:eof?).and_return(false)
      allow(Open3).to receive(:popen3)
        .with("git config branch.#{branch_name}.description")
        .and_return([nil, stdout, nil, nil])
    end

    before do
      setup_git_branch
      setup_git_config
    end

    subject(:executed) { command.execute }

    it { expect { executed } .to output(/Branch\s+Rev\s+Summary/).to_stdout }
    it { expect { executed } .to output(/\*.*master.*mainline/).to_stdout }
    it { expect { executed } .to output(/.*branc\.\.\..*/).to_stdout }
  end
end
