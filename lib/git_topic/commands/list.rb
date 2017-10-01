# frozen_string_literal: true

require 'git_topic/formatter/branches'

module GitTopic
  module Commands
    # list command shows summarized topic information
    class List
      def initialize(options = {})
        @options = options
        @all = options[:all]
      end

      def execute
        branches = ::GitTopic::Formatter::Branches.new @options
        branches.print
      end
    end
  end
end
