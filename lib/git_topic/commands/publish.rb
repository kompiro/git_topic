# frozen_string_literal: true

require 'octokit'

module GitTopic
  module Commands
    # Publish command pushes branch and create pull request from description.
    class Publish
      def initialize(repo, branch_name, base)
        @repo = repo
        @branch_name = branch_name
        @base = base
      end

      def execute
        head = @branch_name
        push_branch(head)
        create_pull_request(@repo, @base, head)
      end

      private

      def push_branch(head)
        system("git push origin #{head}")
      end

      def create_pull_request(repo, base, branch_name)
        client = Octokit::Client.new(netrc: true)
        title = load_title(branch_name)
        client.create_pull_request(repo, base, branch_name, title)
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
