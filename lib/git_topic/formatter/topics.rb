# frozen_string_literal: true

require 'term/ansicolor'

module GitTopic
  module Formatter
    # summarizes topics information
    # Topic means theme that not start to implement
    class Topics
      include Term::ANSIColor

      def print
        puts '[Topics]'
        puts ''
        topics = parse_topics
        print_header
        print_contents topics
      end

      private

      def print_header
        header_format = '%-20s %s'
        puts format(header_format, :Topic, :Summary)
        puts '-' * 80
      end

      def parse_topics; end

      def print_contents(topics); end
    end
  end
end
