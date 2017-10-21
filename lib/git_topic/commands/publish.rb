# frozen_string_literal: true

require 'octokit'

module GitTopic
  module Commands
    # Publish command creates pull request from description.
    class Publish
      def initialize(client, repo, branch_name, base)
        @client = client
        @repo = repo
        @branch_name = branch_name
        @base = base
      end

      def execute
        head = @branch_name
        response = create_pull_request(@repo, @base, head)
        puts response[:html_url]
      rescue StandardError => ex
        STDERR.puts ex.message
      end

      private

      def create_pull_request(repo, base, branch_name)
        title = load_title(branch_name)
        @client.create_pull_request(repo, base, branch_name, title)
      end

      def load_title(head)
        config_key = "branch.#{head}.description"
        command = "git config #{config_key}"
        _stdin, stdout, _stderr, _wait_thr = *Open3.popen3(command)
        stdout.readlines[0].chop
      end
    end
  end
end
