# frozen_string_literal: true

require 'spec_helper'

RSpec.describe GitTopic::Commands::Publish do
  subject(:command) { described_class.new client, repo, branch_name, base }

  let(:repo) { 'kompiro/git_topic' }
  let(:branch_name) { 'implement_publish' }
  let(:base) { 'master' }
  let(:client) { instance_spy(Octokit::Client) }

  describe '#execute' do
    HTML_URL = 'https://github.com/kompiro/git_topic/pull/13'
    before do
      description = <<~DESCRIPTION
        Implement publish command

        - Enable to create pull request by specified arguments
DESCRIPTION
      setup_branch_description('implement_publish', description)
      allow(client).to receive(:create_pull_request)
        .and_return(html_url: HTML_URL)
    end

    it 'calls create_pull_request' do
      command.execute

      expect(client).to have_received(:create_pull_request)
        .with(repo, base, branch_name, 'Implement publish command')
    end

    it 'outputs result html url' do
      expected = Regexp.escape(HTML_URL)
      expect { command.execute } .to output(/#{expected}/).to_stdout
    end
  end
end
