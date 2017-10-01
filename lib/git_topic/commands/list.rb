# frozen_string_literal: true

require 'git_topic/formatter/branches'

module GitTopic
  module Commands
    # list command shows summarized topic information
    class List
      def execute
        branches = ::GitTopic::Formatter::Branches.new
        branches.print
      end
    end
  end
end
