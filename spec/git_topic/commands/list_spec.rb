# frozen_string_literal: true

require 'spec_helper'

RSpec.describe GitTopic::Commands::List do
  subject(:command) { described_class.new }

  it { is_expected.to be_truthy }

  describe '#execute' do
    def setup_git_branch(output)
      setup_command('git branch -v', output)
    end

    def setup_git_config
      setup_branch_description('master', 'mainline')
      setup_branch_description('longlongnamebranchname', 'long name branch')
    end

    def setup_branch_description(branch_name, description)
      setup_command("git config branch.#{branch_name}.description", description)
    end

    context 'rev length is 7' do
      before do
        output = <<~OUT
          * master                 cc72152 :memo: Note about overcommit when release
            longlongnamebranchname 549db63 :up: Bump up development version
        OUT
        setup_git_branch(output)
        setup_git_config
      end

      subject(:executed) { command.execute }

      it { expect { executed } .to output(/Branch\s+Rev\s+Summary/).to_stdout }
      it { expect { executed } .to output(/\*.*master.*mainline/).to_stdout }
      it { expect { executed } .to output(/.*branc\.\.\..*/).to_stdout }
    end

    context 'more log rev length' do
      before do
        output = <<~OUT
          * master                 cc7215212345 :memo: Note about overcommit when release
            longlongnamebranchname 549db6312345 :up: Bump up development version
        OUT
        setup_git_branch(output)
        setup_git_config
      end

      subject(:executed) { command.execute }

      it { expect { executed } .to output(/Branch\s+Rev\s+Summary/).to_stdout }
    end
  end
end
