# frozen_string_literal: true

require 'spec_helper'

RSpec.describe GitTopic::Commands::Start do
  subject(:command) { described_class.new topic_name }

  describe '#execute' do
    subject(:executed) { command.execute }

    context 'error case' do
      xcontext 'topic is not added' do
        let(:topic_name) { 'not_exist' }
        let(:expected) { '`not_exist` is not added' }

        it { expect { executed }.to output(expected).to_stderr }
      end
      xcontext 'the topic is already defined in the branches' do
        let(:topic_name) { 'defined' }
        let(:expected) { '`defined` is already defined' }

        it { expect { executed }.to output(expected).to_stderr }
      end
    end

    context 'valid case' do
      before do
        setup_command('git config --get topic.new_topic', 'test')
        allow(command).to receive(:system)
      end
      let(:topic_name) { 'new_topic' }

      it {
        expect { executed }.to output(/start `new_topic`/).to_stdout
        branch_command = 'git checkout -b new_topic'
        expect(command).to have_received(:system).with(branch_command).once
        desc_command = 'git config --add branch.new_topic.description test'
        expect(command).to have_received(:system).with(desc_command).once
      }
    end
  end
end
