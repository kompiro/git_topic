# frozen_string_literal: true

require 'git_topic/formatter/branches'
require 'git_topic/formatter/topics'

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
        return unless @all
        puts ''
        topics = ::GitTopic::Formatter::Topics.new
        topics.print
      end
    end
  end
end
