# frozen_string_literal: true

require 'spec_helper'

RSpec.describe GitTopic::Commands::Publish do
  subject(:command) { described_class.new client, repo, branch_name, base }

  let(:repo) { 'kompiro/git_topic' }
  let(:branch_name) { 'implement_publish' }
  let(:base) { 'master' }
  let(:client) { instance_spy(Octokit::Client) }

  describe '#execute' do
    before do
      description = <<~DESCRIPTION
        Implement publish command

        - Enable to create pull request by specified arguments
DESCRIPTION
      setup_branch_description('implement_publish', description)
    end

    example do
      command.execute

      expect(client).to have_received(:create_pull_request)
        .with(repo, base, branch_name, 'Implement publish command')
    end
  end
end
