# frozen_string_literal: true

require 'spec_helper'

RSpec.describe GitTopic::Formatter::Topics do
  def setup_git_config(output)
    setup_command('git config --get-regexp ^topic.\*', output)
  end

  describe '#print' do
    subject(:printed) { described_class.new.print }

    it { expect { printed } .to output(/[Topics]/).to_stdout }
    it { expect { printed } .to output(/Topic\s+Summary/).to_stdout }

    context 'set topic summary' do
      before do
        output = <<~OUT
          topic.test hoge
        OUT
        setup_git_config output
      end

      it { expect { printed } .to output(/.{2}test\s{16}.{4} hoge/).to_stdout }
    end
  end
end
